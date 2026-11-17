# Create Theydon Bodyworks website repository via GitHub API using our token

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Theydon Bodyworks GitHub Repo Creation" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Initialize repository in gitapi-test folder
cd "D:\AI\gitapi-test"
if (-not (Test-Path "remote-repo")) {
    mkdir "remote-repo"
}
cd "remote-repo"
if (-not (Test-Path ".")) {
    Write-Host "Initializing git repo..." -ForegroundColor Yellow
    git init --quiet
}

Write-Host ""
Write-Host "Step 1: Setting up Git config..." -ForegroundColor Yellow
git config user.name "George Fox"
git config user.email "georgefox247.github.io@example.com"

Write-Host ""
Write-Host "Step 2: Creating repository via GitHub API..." -ForegroundColor Yellow
$repoData = @{
    name = "co-uk"
    public = $true
    private = $false
} | ConvertTo-Json

curl -X POST https://api.github.com/user/repos `
  -H "Authorization: Bearer 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" `
  -H "Content-Type: application/json" `
  -d $repoData

Write-Host ""
Write-Host "Step 3: Adding remote..." -ForegroundColor Yellow
# Get the repository URL from the API response
$remoteUrl = "https://api.github.com/repos/user/co-uk/contents/"

curl -X PUT $remoteUrl `
  -H "Authorization: Bearer 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" `
  -H "Content-Type: application/json" `
  -d @{ files = @{ "public/index.html" = @{ content = [ConvertTo::Base64]((Get-ChildItem "D:\AI\github.co-uk\public\index.html").FullName); message = "Initial commit"; branch = "master" } }; "public/css/style.css" = @{ content = [ConvertTo::Base64]((Get-ChildItem "D:\AI\github.co-uk\public\css\style.css").FullName); message = "Initial commit"; branch = "master" } }; ".github\pages\_config.yml" = @{ content = [ConvertTo::Base64]((Get-ChildItem "D:\AI\github.co-uk\.github\pages\_config.yml").FullName); message = "Initial commit"; branch = "master" } }

Write-Host ""
Write-Host "Repository created: https://github.com/georgefox247/co-uk" -ForegroundColor Green
Write-Host "Next steps: Visit the repo to create a web branch and enable GitHub Pages"
Write-Host "Visit: https://github.com/georgefox247/co-uk" -ForegroundColor Cyan
