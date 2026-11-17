import urllib.request
import json

username = "georgefox247"
repository_name = "co-uk"
token = "ghp_huh00dndxX8ZbRVcsBidNtMqJor3fso22"

# First try GET to check if repo exists (different endpoint)
url = f"https://api.github.com/repos/{username}/{repository_name}"
headers = {
    'Accept': 'application/vnd.github+json',
    'Authorization': f'Bearer {token}',
    'X-GitHub-Api-Version': '2026-03-10',
}

req = urllib.request.Request(url, headers=headers)

try:
    with urllib.request.urlopen(req, timeout=10) as response:
        result = json.loads(response.read().decode())
        print("Repository already exists!")
        print(json.dumps(result, indent=2))
except urllib.error.HTTPError as e:
    print(f"HTTP Error {e.code}: {e.reason}")
    error_body = e.read().decode() if hasattr(e, 'read') else ""
    print(f"Response body: {error_body}")
