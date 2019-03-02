Write-Host "Reading:" $env:DeployId

$url = "https://api.github.com/repos/octodemo/ReadingTimeDemo/deployments/$env:DeployId/statuses"

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Token $env:MAPPED_GITHUB_TOKEN")
$headers.Add("Accept", "application/json")

$body = @{
    state       = "$env:STATE"
    target_url  = "$env:RELEASE_RELEASEWEBURL"
    description = "Deployment to development"
}

$json = $body | ConvertTo-Json

try {
    $response = Invoke-RestMethod $url -Headers $headers -Method Post -Body $json -ContentType 'application/json' 
}
catch {
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
}