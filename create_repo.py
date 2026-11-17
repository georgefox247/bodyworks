import urllib.request
import json
import sys

username = "georgefox247"
repository_name = "co-uk"
token = "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"

url = f"https://api.github.com/repos/{username}/{repository_name}"
body = {
    "name": repository_name,
    "description": "Theydon Bodyworks - UK Website",
    "private": False,
    "auto_init": True,
}
headers = {
    'Accept': 'application/vnd.github+json',
    'Authorization': f'Bearer {token}',
    'Content-Type': 'application/json',
    'X-GitHub-Api-Version': '2026-03-10',
}

req = urllib.request.Request(url, method='POST', data=json.dumps(body).encode(), headers=headers)

try:
    with urllib.request.urlopen(req, timeout=10) as response:
        result = json.loads(response.read().decode())
        print("Repository created successfully!")
        print(json.dumps(result, indent=2))
except urllib.error.HTTPError as e:
    print(f"HTTP Error {e.code}: {e.reason}")
    error_body = e.read().decode() if hasattr(e, 'read') else ""
    print(f"Response body: {error_body}")
