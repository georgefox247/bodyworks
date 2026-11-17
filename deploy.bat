@echo off
REM Create Theydon Bodyworks repository on GitHub via HTTPS

cd D:\AI\github.co-uk

REM Remove existing remote if it exists (might be SSH which we don't have)
git remote remove origin 2>nul

REM Add new HTTPS remote with token in URL
git remote add origin https://georgefox247.github.io@example.com/git@github.com:georgefox247/co-uk.git

echo Press any key when ready to push...
pause >nul

REM Commit and push with full path and token
cd D:\AI\github.co-uk
git remote set-url origin https://georgefox247.github.io@example.com/git@github.com:georgefox247/co-uk.git
git push -u origin master

echo Repository created: https://github.com/georgefox247/co-uk
pause
