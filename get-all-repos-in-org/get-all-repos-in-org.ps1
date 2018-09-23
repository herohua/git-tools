param (
    [parameter(mandatory=$true)]
    [string]$gitHubOrganization,
    [parameter(mandatory=$true)]
    [string]$gitHubPAT,
    [string]$outputFilePath
)

if ($PsVersionTable.PSVersion.Major -lt 6)
{
    throw "This script only supports PowerShell 6+."
}

$url = "https://api.github.com/orgs/${gitHubOrganization}/repos"
Write-Host "Getting all repo from $url ..."

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$allRepos = Invoke-RestMethod -Uri $url -FollowRelLink -Headers @{
    Authorization = "token $gitHubPAT"
}

if (-not $outputFilePath)
{
    $outputFilePath = 'all-repo.json'
}
$allRepos | ConvertTo-Json -Depth 100 | Out-File $outputFilePath
