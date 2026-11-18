cd "D:\AI\github.co-uk"
Remove-Item -Path "pages\_config.yml" -Force
git add .
git commit -m "Remove duplicate _config.yml to fix GitHub Pages deployment"
git push
