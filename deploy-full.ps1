$pat = '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'

Write-Host "=== Theydon Bodyworks Deployment ===" -ForegroundColor Green

# Get commit SHA
$commitSha = (git rev-parse HEAD).ToString()
Write-Host "Commit: $commitSha" -ForegroundColor Gray

Write-Host "`nPushing to GitHub via HTTPS..." -ForegroundColor Cyan

# Add remote origin with token
Write-Host "`nAdding git remote..." -ForegroundColor Gray
$stdout, $stderr = echo 'git remote add origin https://$pat@github.com/georgefox247/co-uk.git' | Invoke-Expression
if ($LASTEXITCODE -eq 0) {
    Write-Host "`nGit remote added successfully!" -ForegroundColor Green
    
    # Push content on master
    Write-Host "`nPushing files to master..." -ForegroundColor Cyan
    $stdout, $stderr = echo 'git push -u origin master' | Invoke-Expression
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Exit code: $LASTEXITCODE" -ForegroundColor Yellow
        Write-Host "Output: $stdout $stderr" -ForegroundColor Yellow
    } else {
        Write-Host "`n✓ Git push successful! Content is now on GitHub." -ForegroundColor Green
    }
} else {
    Write-Host "`nError adding remote" -ForegroundColor Red
    Write-Host $_.ToString() -ForegroundColor Red
}

Write-Host "`n=== Deployment Complete ===" -ForegroundColor Green
Write-Host "Visit: https://georgefox247.github.io/co-uk/" -ForegroundColor Cyan
