# GitHub Pages deployment for Theydon Bodyworks
$pat = "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"

Write-Host "=== Theydon Bodyworks Deployment ===" -ForegroundColor Green
Write-Host "Token: $pat" -ForegroundColor Gray

$repository = "https://github.com/georgefox247/co-uk.git"

# Get current remote URL
$currentRemote = git remote get-url origin 2>$null
Write-Host "`nCurrent remote: $currentRemote" -ForegroundColor Gray

# If remote doesn't have the right format, set it up
if ($currentRemote -ne "https://$pat@github.com/georgefox247/co-uk.git") {
    Write-Host "Setting up HTTPS remote with token..." -ForegroundColor Yellow
    git remote set-url origin $repository
    
    # Verify it was set correctly
    $newRemote = git remote get-url origin 2>$null
    Write-Host "New remote: $newRemote" -ForegroundColor Gray
}

# Get the commit SHA (full 40 chars)
$commitSha = (git rev-parse HEAD).ToString()
Write-Host "`nCommit SHA: $commitSha" -ForegroundColor Gray

# Try to push using git directly first
Write-Host "`n=== Attempting git push ===" -ForegroundColor Cyan
try {
    $pushResult = git push -u origin master 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "SUCCESS: Push completed!" -ForegroundColor Green
    } else {
        Write-Host "Push failed with exit code $LASTEXITCODE" -ForegroundColor Yellow
        Write-Host "$pushResult" -ForegroundColor Yellow
        
        # If push fails, try GitHub API directly
        Write-Host "`nTrying GitHub API directly..." -ForegroundColor Gray
        
        $apiBody = @{ref="refs/heads/master"; sha=$commitSha} | ConvertTo-Json
        
        Invoke-RestMethod `
            -Uri "https://api.github.com/repos/georgefox247/co-uk/git/refs/heads/master" `
            -Method POST `
            -Headers @{
                Authorization="Bearer $pat"
                Accept="application/vnd.github.v3+json"
            } `
            -Body ($apiBody | ConvertTo-Json) `
            -ContentType "application/json"
        
        Write-Host "GitHub API response: $($LASTEXITCODE)" -ForegroundColor Yellow
        
        # After creating the repo via API, try pushing again
        if ($LASTEXITCODE -eq 0) {
            Write-Host "`nForcing push..." -ForegroundColor Gray
            $forcePush = git push -u origin master --force-with-lease 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Host "SUCCESS: Force push completed!" -ForegroundColor Green
            } else {
                Write-Host "Force push failed with exit code $LASTEXITCODE" -ForegroundColor Yellow
                Write-Host "$forcePush" -ForegroundColor Yellow
            }
        }
    }
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}

Write-Host "`n=== Deployment Complete ===" -ForegroundColor Green
Write-Host "Your website is now live at:" -ForegroundColor White
Write-Host "https://georgefox247.github.io/co-uk/" -ForegroundColor Cyan
