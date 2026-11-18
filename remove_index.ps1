cd "D:\AI\github.co-uk"
Remove-Item -Path ".\index.html" -Force
git rm --cached index.html 2>$null
git add .
git commit -m "Remove root index.html to fix GitHub Pages 404 error"
git push
