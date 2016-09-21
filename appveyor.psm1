$RequiredCoverage=80
$User="appveyor"

function Invoke-PendingStatus
{
	param()

	Update-GitHubStatus -status "pending" -message "Waiting for OpenCover coverage update to complete"
}

function Update-GitHubStatus
{
	param(
		[String] $status,
		[String] $message
	)

	$RepoSlug = $env:APPVEYOR_REPO_NAME
	$Commit = $env:APPVEYOR_REPO_COMMIT
	$Token = $env:GITHUB_TOKEN

	$Data = @{
		state = $status;
		target_url = "https://appveyor.com/";
		description = $message;
		context = "coverage/opencover";
	}

	$Params = @{
		Uri = "https://octodemo.com/api/v3/repos/$RepoSlug/statuses/$Commit";
		Method = 'POST';
		Headers = @{
			Authorization = 'Basic ' + [Convert]::ToBase64String(
			[Text.Encoding]::ASCII.GetBytes($Token + ":x-oauth-basic"));
		}    
		ContentType = 'application/json';
		Body = (ConvertTo-Json $Data -Compress)
	}
	
	Invoke-RestMethod @Params

}

function Invoke-OpenCover
{
    param()

	$PercentageValue
	$Filter="+[ReadingTimeDemo]* -[ReadingTimeDemo]*Startup -[ReadingTimeDemo]*Program"
	$OpenCoverVersion="4.6.519"
	$ReportGeneratorVersion="2.4.5"

	$Packages="C:\Users\$User\.nuget\packages"
	$OpenCover="$Packages\OpenCover\$OpenCoverVersion\tools\OpenCover.Console.exe"
	$ReportGenerator="$Packages\ReportGenerator\$ReportGeneratorVersion\tools\ReportGenerator.exe"

	$WorkingDir= Get-Location
	$TargetDir="$WorkingDir\test\ReadingTimeDemo.UnitTests\bin\Debug\netcoreapp1.0"
	$CoverageDir="coverage"

	$CoverageFile="coverage.xml"

	$AllArgs = @("-oldStyle","-filter:$Filter", "-register:user","-targetdir:$TargetDir", '-target:dotnet.exe', "-output:$CoverageFile", "-targetargs:test $WorkingDir\test\ReadingTimeDemo.UnitTests")

	& $OpenCover $AllArgs

	& $ReportGenerator -targetdir:$CoverageDir -reporttypes:TextSummary -reports:$CoverageFile -verbosity:Error

	type "$WorkingDir\$CoverageDir\Summary.txt" | where { $_ -match "Line coverage: (?<percentage>[A-Z0-9.%]+)" } | foreach { $PercentageValue = $matches['percentage'] }

	Write-Host "Coverage percentage: $PercentageValue"

	Post-ReportStatus -percentage $PercentageValue
}

function Post-ReportStatus
{
	param(
		[string] $percentage
	)

	$Status = "failure"
	$Message = "Coverage failed to reach $RequiredCoverage% ($percentage)" 

	if ($percentage -ge $RequiredCoverage) {
		$Status = "success"
		$Message = "Coverage is $RequiredCoverage% or higher  ($percentage)"
	}

	Update-GitHubStatus -status $Status -message $Message
}

Export-ModuleMember -Function "Invoke-*"
