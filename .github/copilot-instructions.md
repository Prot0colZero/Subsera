# Subsera Video Generator App - AI Assistant Instructions

## Project Overview
This is a Flutter mobile app that generates and displays videos based on user input. The app uses YouTube API for real video content with fallbacks to demo videos. Key architecture includes a tab-based navigation structure with video generation, gallery, and display capabilities.

## Core Architecture

### App Structure
- **Entry Point**: `main.dart` → `SplashScreen` → `NavigationScreen` (3-tab layout)
- **Navigation**: Bottom tab navigation with `IndexedStack` to preserve state
- **Theme**: Dark theme with `Color(0xFF0A0A0B)` background and indigo accents
- **State Management**: StatefulWidgets with local state (no external state management)

### Key Components
- `VideoGeneratorService`: YouTube API integration with graceful fallbacks
- `VideoInfo` model: Standardized video data structure with dual constructors
- `NavigationScreen`: Main container with preserved tab state
- WhatsApp-style video widgets: Custom video display components

### Data Flow
1. User input → `VideoGeneratorService.generateVideos()`
2. YouTube API call → Fallback to demo videos if API fails
3. `VideoInfo` objects → UI components via StatefulWidget state
4. Video playback via `youtube_player_flutter` package

## Development Patterns

### File Organization
```
lib/
├── main.dart                    # App entry + theme
├── screens/                     # Tab screens + navigation
├── services/                    # YouTube API + business logic  
├── models/                      # Data structures
└── widgets/                     # Reusable UI components
```

### Error Handling Pattern
Always use try-catch with graceful fallbacks, especially in `VideoGeneratorService`:
```dart
try {
  final youtubeVideos = await _fetchYouTubeVideos(userInput, count);
  if (youtubeVideos.isNotEmpty) return youtubeVideos;
} catch (e) {
  print('❌ Error: $e');
}
return await _getFallbackVideos(userInput, count);
```

### Build & Deploy Workflow
- **Quick Build**: Use `quick-build.ps1` (configures D: drive caching)
- **Release Build**: `flutter build apk --release --target-platform android-arm64 --split-per-abi` 
- **Upload**: PowerShell scripts with Google Drive API integration
- **Tasks**: Use VS Code tasks for common operations (`Flutter: Run App`, etc.)

## Critical Dependencies
- `youtube_player_flutter`: Video playback (not `video_player`)
- `http`: YouTube API calls
- YouTube API Key embedded in `VideoGeneratorService._youtubeApiKey`

## Common Gotchas
- **IndexedStack Usage**: Screens maintain state across tab switches
- **Video Widget Compatibility**: `VideoInfo` has dual constructors for different widget types
- **API Fallbacks**: Always handle YouTube API failures gracefully
- **Build Caching**: Use D: drive scripts to avoid C: drive space issues on Windows
- **PowerShell Execution**: Scripts require `-ExecutionPolicy Bypass` parameter

## When Making Changes
1. **Video Features**: Modify `VideoGeneratorService` for new video sources
2. **UI Changes**: Update corresponding screen in `/screens` directory  
3. **Navigation**: Changes in `NavigationScreen` affect entire tab structure
4. **Models**: Update both constructors in `VideoInfo` if changing data structure
5. **Build Issues**: Check PowerShell scripts and VS Code tasks configuration