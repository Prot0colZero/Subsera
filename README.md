# Subsera.AI - Video Discovery Platform

A modern Flutter web application for personalized video discovery powered by artificial intelligence.

🌐 **Live Demo**: [View App](https://YOUR_USERNAME.github.io/SubseraNew/)

## ✨ Features

### Onboarding Experience
- **Welcome Screen**: Beautiful animated logo with pulsing effect
- **Interests Selection**: Personalized content preferences
- **Loading Screen**: Smooth transition to main app
- **All transitions are buttery smooth** (900ms-1200ms with cubic easing)

### Main Features
- **Home Screen**: Video unlock system with coin-based mechanics
- **Gallery**: Collection-based video organization with thumbnails
- **Favorites**: Save your favorite collections with heart button
- **Auto Generator**: Text input for generating personalized video recommendations
- **Bottom Navigation**: Easy switching between Home, Gallery, Favorites, and Generator

### UI/UX Highlights
- Clean white theme with Google Blue (#4285F4) accents
- Custom logo and icons (40x40 logo, 30x30 nodes icon)
- Smooth fade, slide, and scale animations throughout
- Responsive layout optimized for web
- WhatsApp-inspired video card design

## Dependencies

- `flutter`: Flutter SDK
- `video_player`: For video playback functionality
- `path_provider`: For accessing device storage
- `permission_handler`: For handling device permissions
- `http`: For network requests
- `ffmpeg_kit_flutter`: For video generation and processing

## Installation

### Prerequisites

1. Install Flutter SDK from [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
2. Install Android Studio or VS Code with Flutter extensions
3. Set up an Android emulator or connect a physical device

### Setup

1. Clone this repository
2. Navigate to the project directory
3. Run the following commands:

```bash
flutter pub get
flutter run
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── screens/
│   ├── home_screen.dart         # Main input screen
│   └── video_display_screen.dart # Video playback screen
└── services/
    └── video_generator_service.dart # Video generation logic

assets/
├── videos/                      # Generated videos storage
└── images/                      # App images and icons

android/                         # Android platform files
ios/                            # iOS platform files (for future iOS support)
```

## How It Works

1. **Input**: User enters text describing the type of videos they want to generate
2. **Generation**: The app creates 5 videos with different visual properties based on the input
3. **Display**: Videos are shown in a grid layout with a main player at the top
4. **Playback**: Users can tap any video thumbnail to play it in the main player

## Video Generation

The app uses FFmpeg to generate videos with:
- Different background colors for each video
- User input text overlaid on the video
- 5-second duration per video
- 720x480 resolution

When FFmpeg is not available, the app falls back to demo videos or placeholder content.

## Permissions

The app requires the following permissions:
- **Internet**: For downloading sample videos (demo mode)
- **Storage**: For saving and accessing generated videos

## Development

### Running Tests

```bash
flutter test
```

### Building for Release

```bash
flutter build apk --release
```

## Troubleshooting

### Common Issues

1. **Flutter not found**: Ensure Flutter is installed and added to your system PATH
2. **Build errors**: Run `flutter clean` and `flutter pub get`
3. **Permission errors**: Ensure app has storage permissions enabled in device settings

### Demo Mode

If video generation fails, the app will use sample videos from the internet for demonstration purposes.

## Future Enhancements

- iOS support
- Custom video templates
- Advanced video editing features
- Cloud-based video generation
- Social sharing capabilities

## License

This project is licensed under the MIT License.