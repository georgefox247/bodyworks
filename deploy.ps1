# GitHub Pages deployment script
Pushing to GitHub using the personal access token...

$pat = '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'
$repository = 'https://github.com/georgefox247/bodyworks.git'
$remote = git remote get-url origin 2>$null

if ($remote -eq '') {
    Write-Host "Setting up remote..."
    $remote = $repository
} else {
    # Update the remote to use HTTPS with token
    Write-Host "Updating remote to HTTPS with token..."
    git remote set-url origin https://$pat@github.com/georgefox247/co-uk.git
}

Write-Host "`nPushing..."
git push -u origin master
