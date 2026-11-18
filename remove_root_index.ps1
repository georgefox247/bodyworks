Remove-Item -Path "D:\AI\github-gh-pages\index.html" -Force;
git rm "D:\AI\github-gh-pages\index.html";
git add .;
git commit -m "Remove root index.html to fix GitHub Pages 404 error";
git push origin main
