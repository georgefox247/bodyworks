@echo off
REM Create Theydon Bodyworks repository on GitHub via direct push

REM Add remote origin and push master branch
cd D:\AI\github.co-uk
git remote add origin https://georgefox247.github.io@example.com/git@github.com:georgefox247/co-uk.git
git add .
git commit -m "Initial commit - Theydon Bodyworks website"
git push -u origin master

echo Repository created: https://github.com/georgefox247/co-uk
pause
