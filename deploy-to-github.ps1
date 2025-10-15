# Subsera.AI - GitHub Pages Deployment Script
param(
    [string]$GitHubUsername = "Prot0colZero",
    [string]$RepoName = "Subsera",
    [switch]$UpdateOnly = $false
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Subsera.AI GitHub Deployment" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Build the Flutter Web App
Write-Host "Building Flutter web app..." -ForegroundColor Yellow
$baseHref = "/$RepoName/"
flutter clean
flutter build web --release --base-href $baseHref

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Build completed successfully!" -ForegroundColor Green
Write-Host ""

# Step 2: Add remote (first time only)
if (-not $UpdateOnly) {
    Write-Host "Setting up GitHub remote..." -ForegroundColor Yellow
    
    $remoteExists = git remote | Select-String -Pattern "origin"
    
    if ($remoteExists) {
        Write-Host "Remote already exists. Updating URL..." -ForegroundColor Yellow
        git remote set-url origin "https://github.com/$GitHubUsername/$RepoName.git"
    } else {
        git remote add origin "https://github.com/$GitHubUsername/$RepoName.git"
    }
    
    Write-Host "Remote configured!" -ForegroundColor Green
    Write-Host ""
}

# Step 3: Commit main branch changes
Write-Host "Committing changes to main branch..." -ForegroundColor Yellow
git add .
git commit -m "Update Subsera.AI app"

if (-not $UpdateOnly) {
    Write-Host "Pushing to main branch..." -ForegroundColor Yellow
    git branch -M main
    git push -u origin main -f
}

Write-Host "Main branch updated!" -ForegroundColor Green
Write-Host ""

# Step 4: Deploy to gh-pages
Write-Host "Deploying to GitHub Pages..." -ForegroundColor Yellow

$currentBranch = git rev-parse --abbrev-ref HEAD

$ghPagesExists = git ls-remote --heads origin gh-pages

if ($ghPagesExists) {
    git checkout gh-pages
    git pull origin gh-pages
    Get-ChildItem -Exclude .git | Remove-Item -Recurse -Force
    Copy-Item -Path "build/web/*" -Destination "." -Recurse -Force
} else {
    git checkout --orphan gh-pages
    git rm -rf . 2>$null
    Copy-Item -Path "build/web/*" -Destination "." -Recurse -Force
}

git add .
git commit -m "Deploy to GitHub Pages"
git push origin gh-pages -f

Write-Host "Deployed to GitHub Pages!" -ForegroundColor Green
Write-Host ""

git checkout $currentBranch

# Final instructions
Write-Host "========================================" -ForegroundColor Green
Write-Host "   Deployment Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Your app will be live at:" -ForegroundColor Cyan
Write-Host "https://$GitHubUsername.github.io/$RepoName/" -ForegroundColor Yellow
Write-Host ""
Write-Host "Enable GitHub Pages (first time only):" -ForegroundColor Cyan
Write-Host "1. Go to: https://github.com/$GitHubUsername/$RepoName/settings/pages"
Write-Host "2. Under Source, select branch: gh-pages"
Write-Host "3. Click Save"
Write-Host "4. Wait 1-2 minutes for deployment"
Write-Host ""
Write-Host "To update later, run: .\deploy-to-github.ps1 -UpdateOnly" -ForegroundColor Cyan
Write-Host ""
Write-Host "Share this link with your business partner!" -ForegroundColor Green
