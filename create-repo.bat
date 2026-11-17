@echo off
REM Create GitHub repository georgefox247/co-uk
set PAT=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
set USERNAME=georgefox247

echo Creating repository via API...
curl -s -X GET "https://api.github.com/user/repos?name=%USERNAME/co-uk&private=true" --header "Authorization: Bearer %PAT%"

if %errorlevel%==0 (
    echo Repository exists!
) else (
    echo Repository does NOT exist yet. Please create it manually at https://github.com/%USERNAME%/co-uk
    pause
)
