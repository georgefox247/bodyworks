$repo = "D:\AI\github.co-uk"
git -C "$repo" add -A
git -C "$repo" commit -m "Add GitHub Pages configuration"
git -C "$repo" push -u origin main
