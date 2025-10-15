# Quick Deployment Commands

## First Time Setup

1. **Create GitHub Repository**
   - Go to https://github.com/new
   - Repository name: `SubseraNew` (or your choice)
   - Make it Public
   - Don't initialize with README
   - Click "Create repository"

2. **Run Deployment Script**
   ```powershell
   .\deploy-to-github.ps1 -GitHubUsername "YOUR_USERNAME"
   ```

3. **Enable GitHub Pages**
   - Go to: Settings > Pages
   - Source: Deploy from branch `gh-pages`
   - Click Save
   - Wait 1-2 minutes

4. **Share the Link**
   ```
   https://YOUR_USERNAME.github.io/SubseraNew/
   ```

## Future Updates

When you make changes and want to update the live site:

```powershell
.\deploy-to-github.ps1 -UpdateOnly
```

That's it! The script handles:
- ✅ Building the Flutter web app
- ✅ Committing changes
- ✅ Pushing to GitHub
- ✅ Deploying to gh-pages
- ✅ Your live site updates automatically

## Manual Commands (if script fails)

```powershell
# Build
flutter build web --release --base-href "/SubseraNew/"

# Commit to main
git add .
git commit -m "Update app"
git push origin main

# Deploy to gh-pages
git checkout gh-pages
Remove-Item -Path * -Recurse -Force -Exclude .git
Copy-Item -Path "build/web/*" -Destination "." -Recurse
git add .
git commit -m "Deploy"
git push origin gh-pages -f
git checkout main
```

## Viewing Your Site

Your business partner can access the app at:
```
https://YOUR_USERNAME.github.io/SubseraNew/
```

- Works on any device (desktop, tablet, mobile)
- No installation needed
- Updates automatically when you push changes
- Free hosting via GitHub Pages
- Professional URL you can share

## Current App Features

✨ **Live in the app:**
- Onboarding flow with interests selection
- Video unlock system with coins
- Gallery with collection cards
- Favorites system (heart button)
- Auto Generator for prompts
- 4-tab navigation (Home, Gallery, Favorites, Generator)
- Smooth animations everywhere
- Custom logo and icons
- Clean white/blue theme

## Need Help?

1. Check `GITHUB_DEPLOYMENT.md` for detailed instructions
2. Make sure you have:
   - Git installed
   - Flutter SDK installed
   - GitHub account created
   - Repository created on GitHub

## Tips

- Use `-UpdateOnly` flag for faster deployments after first setup
- The base-href must match your repository name
- GitHub Pages can take 1-2 minutes to update after pushing
- Clear browser cache if changes don't appear immediately
