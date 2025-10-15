# GitHub Pages Deployment Guide

## Quick Setup Instructions

### 1. Build the Flutter Web App
```powershell
flutter build web --release --base-href "/SubseraNew/"
```

### 2. Commit Your Changes
```powershell
git add .
git commit -m "Add Subsera.AI app with onboarding, gallery, and favorites"
```

### 3. Create GitHub Repository
1. Go to https://github.com/new
2. Create a new repository named "SubseraNew" (or any name you prefer)
3. Don't initialize with README (we already have a repo)
4. Click "Create repository"

### 4. Push to GitHub
Replace `YOUR_USERNAME` with your GitHub username:
```powershell
git remote add origin https://github.com/YOUR_USERNAME/SubseraNew.git
git branch -M main
git push -u origin main
```

### 5. Deploy to GitHub Pages
```powershell
git checkout --orphan gh-pages
git rm -rf .
Copy-Item -Path "build/web/*" -Destination "." -Recurse
git add .
git commit -m "Deploy to GitHub Pages"
git push origin gh-pages
```

### 6. Enable GitHub Pages
1. Go to your repository on GitHub
2. Click "Settings" > "Pages"
3. Under "Source", select branch "gh-pages"
4. Click "Save"
5. Your site will be live at: `https://YOUR_USERNAME.github.io/SubseraNew/`

## Alternative: Use the Deployment Script

I've created `deploy-to-github.ps1` that automates this process.

### First Time Setup:
```powershell
# Set your GitHub username
$env:GITHUB_USERNAME = "your-username-here"

# Run the script
.\deploy-to-github.ps1
```

### Future Updates:
```powershell
# Just rebuild and redeploy
.\deploy-to-github.ps1 -UpdateOnly
```

## Sharing with Your Business Partner

Once deployed, share this link:
```
https://YOUR_USERNAME.github.io/SubseraNew/
```

The site will be publicly accessible and update automatically when you push changes!

## Troubleshooting

### If the site shows a blank page:
- Make sure you used the correct `--base-href` in the build command
- Check browser console for errors (F12)
- Verify GitHub Pages is enabled in repository settings

### If images don't load:
- Make sure `assets/images/` folder is committed to git
- Check that `pubspec.yaml` has the assets section properly configured

### To update the site:
1. Make your changes in the code
2. Rebuild: `flutter build web --release --base-href "/SubseraNew/"`
3. Run the deploy script or manually push to gh-pages branch

## Features in Your App

✨ **Onboarding Flow:**
- Welcome screen with pulsing logo
- Interests selection screen
- Loading screen with smooth transitions

✨ **Main Features:**
- Home screen with video unlock system
- Gallery with collection cards
- Favorites system (heart button to save collections)
- Auto Generator screen
- Smooth animations throughout
- Clean white theme with Google Blue accents

## Notes

- The app is built with Flutter Web
- State management uses Provider
- All transitions are smooth (900ms-1200ms)
- Assets include custom logo and nodes icon
- No backend required - pure frontend demo
