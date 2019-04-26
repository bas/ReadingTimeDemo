$url = "https://octodemo.com/api/v3/repos/office-tools/ReadingTimeDemo/deployments"

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Token $env:MAPPED_GITHUB_TOKEN")
$headers.Add("Accept", "application/json")

$body = @{
    ref         = $Env:BUILD_SOURCEBRANCHNAME
    description = "Deploying branch to development"
    environment = "development"
}

$json = $body | ConvertTo-Json

Write-Output "$json" 

Write-Output "Token $env:MAPPED_GITHUB_TOKEN"

$response = Invoke-RestMethod $url -Headers $headers -Method Post -Body $json -ContentType 'application/json'

Write-Host "$("##vso[task.setvariable variable=DeployId]")$($response.id)"
