$RequiredCoverage=80
$User="appveyor"
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

$RepoSlug = $env:APPVEYOR_REPO_NAME
$Commit = $env:APPVEYOR_REPO_COMMIT
$Token = $env:GITHUB_TOKEN

$PendingData = @{
	state = "pending";
	target_url = "https://appveyor.com/";
	description = "Waiting for OpenCover coverage update to complete";
	context = "coverage/opencover";
}

$PendingReleaseParams = @{
   Uri = "https://octodemo.com/api/v3/repos/$RepoSlug/statuses/$Commit";
   Method = 'POST';
   Headers = @{
     Authorization = 'Basic ' + [Convert]::ToBase64String(
     [Text.Encoding]::ASCII.GetBytes($Token + ":x-oauth-basic"));
   }
   ContentType = 'application/json';
   Body = (ConvertTo-Json $PendingData -Compress)
 }

 $PendingResult = Invoke-RestMethod @PendingReleaseParams

& $OpenCover $AllArgs

& $ReportGenerator -targetdir:$CoverageDir -reporttypes:Html -reports:$CoverageFile -verbosity:Error

$PercentageValue

type "$WorkingDir\$CoverageDir\index.htm" | where { $_ -match "Line coverage:</th><td>(?<percentage>[A-Z0-9.%]+)</td></tr>" } | foreach { $PercentageValue = $matches['percentage'] }

Write-Host "Coverage percentage: $PercentageValue"

$Status = "failure"
$Message = "Coverage failed to reach $RequiredCoverage% ($PercentageValue)" 

if ($PercentageValue -ge $RequiredCoverage) {
	$Status = "success"
	$Message = "Coverage is $RequiredCoverage% or higher  ($PercentageValue)"
}

$Data = @{
	state = $Status;
	target_url = "https://appveyor.com/";
	description = $Message;
	context = "coverage/opencover";
}

$ReleaseParams = @{
   Uri = "https://octodemo.com/api/v3/repos/$RepoSlug/statuses/$Commit";
   Method = 'POST';
   Headers = @{
     Authorization = 'Basic ' + [Convert]::ToBase64String(
     [Text.Encoding]::ASCII.GetBytes($Token + ":x-oauth-basic"));
   }
   ContentType = 'application/json';
   Body = (ConvertTo-Json $Data -Compress)
 }

 $Result = Invoke-RestMethod @ReleaseParams