param (
    [string]$allRepoFilePath,
    [string]$publicRepoFilePath,
    [string]$privateRepoFilePath
)

if (-not $allRepoFilePath)
{
    $allRepoFilePath = 'all-repo.json'
}
$allRepos = Get-Content $allRepoFilePath | ConvertFrom-Json

$publicRepos = New-Object System.Collections.Generic.List[System.Object]
$privateRepos = New-Object System.Collections.Generic.List[System.Object]
foreach ($repoList in $allRepos)
{
    foreach ($repo in $repoList)
    {
        if ($repo.private)
        {
            $privateRepos.Add($repo.html_url)
        }
        else
        {
            $publicRepos.Add($repo.html_url)
        }
    }
}

if (-not $publicRepoFilePath)
{
    $publicRepoFilePath = 'public-repo.json'
}
$publicRepos | Sort-Object | Out-File $publicRepoFilePath
Write-Host "Public repos saved to $publicRepoFilePath"

if (-not $privateRepoFilePath)
{
    $privateRepoFilePath = 'private-repo.json'
}
$privateRepos | Sort-Object | Out-File $privateRepoFilePath
Write-Host "Private repos saved to $privateRepoFilePath"
