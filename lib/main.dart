import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppData appData = AppData();

  runApp(
    ChangeNotifierProvider<AppData>.value(
      value: appData,
      builder: (BuildContext context, Widget? child) => const SubseraApp(),
    ),
  );
}

// Data Model for a single video item
class VideoItem {
  final String title;
  final String description;
  final String imageUrl;
  final String duration;
  final String channelName;
  bool isLocked; // Can be changed

  VideoItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.duration,
    required this.channelName,
    this.isLocked = true,
  });
}

// Global Application Data and State Management
class AppData extends ChangeNotifier {
  int _coinCount = 110;
  int _unlocksRemaining = 1;
  bool _hasCompletedOnboarding = false; // New state for onboarding
  String _userInterests = ""; // User's selected interests
  final Set<String> _favoriteCollections = <String>{}; // Favorite collection IDs

  // YouTube video ID for the placeholder thumbnail
  static const String _youtubeVideoId = "Lf8fKbn0PRk";
  static const String _youtubeThumbnailUrl =
      "https://img.youtube.com/vi/$_youtubeVideoId/hqdefault.jpg";
  static const String _logoImageUrl =
      "https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg";

  final List<VideoItem> _videoItems = <VideoItem>[
    // All video items updated to match the specified YouTube video info
    VideoItem(
      title: "How to Build a Complete Flutter App | Flutter Tutorial",
      description:
          "In this tutorial, we will build a complete, production-ready Flutter app from scratch, covering everything from UI to backend integration. We'll use Provider for state management, Firebase for authentication and database, and much more. This is an advanced tutorial for developers who want to take their Flutter skills to the next level.",
      imageUrl: _youtubeThumbnailUrl,
      duration: "01:24:00",
      channelName: "Flutter",
      isLocked: true,
    ),
    VideoItem(
      title: "How to Build a Complete Flutter App | Flutter Tutorial",
      description:
          "In this tutorial, we will build a complete, production-ready Flutter app from scratch, covering everything from UI to backend integration. We'll use Provider for state management, Firebase for authentication and database, and much more. This is an advanced tutorial for developers who want to take their Flutter skills to the next level.",
      imageUrl: _youtubeThumbnailUrl,
      duration: "01:24:00",
      channelName: "Flutter",
      isLocked: true,
    ),
    VideoItem(
      title: "How to Build a Complete Flutter App | Flutter Tutorial",
      description:
          "In this tutorial, we will build a complete, production-ready Flutter app from scratch, covering everything from UI to backend integration. We'll use Provider for state management, Firebase for authentication and database, and much more. This is an advanced tutorial for developers who want to take their Flutter skills to the next level.",
      imageUrl: _youtubeThumbnailUrl,
      duration: "01:24:00",
      channelName: "Flutter",
      isLocked: true,
    ),
    VideoItem(
      title: "How to Build a Complete Flutter App | Flutter Tutorial",
      description:
          "In this tutorial, we will build a complete, production-ready Flutter app from scratch, covering everything from UI to backend integration. We'll use Provider for state management, Firebase for authentication and database, and much more. This is an advanced tutorial for developers who want to take their Flutter skills to the next level.",
      imageUrl: _youtubeThumbnailUrl,
      duration: "01:24:00",
      channelName: "Flutter",
      isLocked: true,
    ),
    VideoItem(
      title: "How to Build a Complete Flutter App | Flutter Tutorial",
      description:
          "In this tutorial, we will build a complete, production-ready Flutter app from scratch, covering everything from UI to backend integration. We'll use Provider for state management, Firebase for authentication and database, and much more. This is an advanced tutorial for developers who want to take their Flutter skills to the next level.",
      imageUrl: _youtubeThumbnailUrl,
      duration: "01:24:00",
      channelName: "Flutter",
      isLocked: true,
    ),
  ];

  AppData();

  int get coinCount => _coinCount;
  int get unlocksRemaining => _unlocksRemaining;
  List<VideoItem> get videoItems => _videoItems;
  String get logoImageUrl => _logoImageUrl;
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;
  String get userInterests => _userInterests;
  Set<String> get favoriteCollections => _favoriteCollections;

  void setUserInterests(String interests) {
    _userInterests = interests;
    notifyListeners();
  }

  void toggleFavoriteCollection(String collectionId) {
    if (_favoriteCollections.contains(collectionId)) {
      _favoriteCollections.remove(collectionId);
    } else {
      _favoriteCollections.add(collectionId);
    }
    notifyListeners();
  }

  bool isCollectionFavorite(String collectionId) {
    return _favoriteCollections.contains(collectionId);
  }

  void unlockAllVideos() {
    if (_unlocksRemaining > 0) {
      bool unlockedAny = false;
      for (final VideoItem item in _videoItems) {
        if (item.isLocked) {
          item.isLocked = false;
          unlockedAny = true;
        }
      }
      if (unlockedAny) {
        _unlocksRemaining--;
        notifyListeners();
      }
    }
  }

  void completeOnboarding() {
    _hasCompletedOnboarding = true;
    notifyListeners();
  }
}

class SubseraApp extends StatelessWidget {
  const SubseraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF4285F4),
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
          background: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        textTheme: TextTheme(
          titleLarge: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: Colors.grey[800], fontSize: 16),
          bodyMedium: TextStyle(color: Colors.grey[700], fontSize: 14),
          bodySmall: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF4285F4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
        ),
      ),
      home: Consumer<AppData>(
        builder: (BuildContext context, AppData appData, Widget? child) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 1200),
            switchInCurve: Curves.easeInOutCubic,
            switchOutCurve: Curves.easeInOutCubic,
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ));
              
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: child,
                ),
              );
            },
            child: appData.hasCompletedOnboarding
                ? const _MainNavigationScreen(key: ValueKey('main'))
                : const _OnboardingFlow(key: ValueKey('onboarding')),
          );
        },
      ),
    );
  }
}

// Onboarding Flow State Manager
class _OnboardingFlow extends StatefulWidget {
  const _OnboardingFlow({super.key});

  @override
  State<_OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<_OnboardingFlow> {
  int _currentStep = 0; // 0: Welcome, 1: Interests, 2: Loading

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 900),
      switchInCurve: Curves.easeInOutCubic,
      switchOutCurve: Curves.easeInOutCubic,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0.0, 0.05),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ));
        
        final scaleAnimation = Tween<double>(
          begin: 0.95,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ));
        
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: offsetAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: child,
            ),
          ),
        );
      },
      child: _currentStep == 0
          ? _OnboardingScreen(
              key: const ValueKey('welcome'),
              onGetStarted: _nextStep,
            )
          : _currentStep == 1
              ? _InterestsScreen(
                  key: const ValueKey('interests'),
                  onContinue: _nextStep,
                )
              : _LoadingScreen(
                  key: const ValueKey('loading'),
                ),
    );
  }
}

class _OnboardingScreen extends StatefulWidget {
  final VoidCallback onGetStarted;

  const _OnboardingScreen({required this.onGetStarted, super.key});

  @override
  State<_OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<_OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Animated Logo
            ScaleTransition(
              scale: _pulseAnimation,
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
                errorBuilder:
                    (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: <Color>[Color(0xFF00F0FF), Color(0xFF00BFFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Icon(
                      Icons.blur_on,
                      color: theme.colorScheme.onSurface,
                      size: 60,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            // Welcome text
            Text(
              "Welcome to",
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 8),

            // Subsera.AI text
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ) ??
                    const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                children: <TextSpan>[
                  const TextSpan(text: "Subsera."),
                  TextSpan(
                    text: "AI",
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Description text
            Text(
              "Your personalized video discovery platform\npowered by artificial intelligence",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
            ),
            const SizedBox(height: 40),

            // Get Started Button
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: widget.onGetStarted,
                    child: Text(
                      "Get Started",
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: theme.colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Interests Selection Screen
class _InterestsScreen extends StatefulWidget {
  final VoidCallback onContinue;

  const _InterestsScreen({required this.onContinue, super.key});

  @override
  State<_InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<_InterestsScreen> {
  final TextEditingController _interestsController = TextEditingController();

  @override
  void dispose() {
    _interestsController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final AppData appData = Provider.of<AppData>(context, listen: false);
    appData.setUserInterests(_interestsController.text);
    widget.onContinue();
  }

  void _handleSkip() {
    widget.onContinue();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF4285F4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.interests,
                size: 40,
                color: Color(0xFF4285F4),
              ),
            ),
            const SizedBox(height: 24),
            // Title
            const Text(
              "What specific content do\nyou like to see?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            // Subtitle
            Text(
              "Tell us your interests so we can personalize\nyour video recommendations",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            // Input Field
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search, color: Colors.grey[600], size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _interestsController,
                          decoration: InputDecoration(
                            hintText: "e.g., Technology, Science, Gaming...",
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down,
                          color: Colors.grey[600], size: 24),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Info Text
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.settings, color: Colors.grey[600], size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "You can change these preferences anytime",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Buttons
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: OutlinedButton(
                          onPressed: _handleSkip,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.grey[300]!, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _handleContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4285F4),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Loading Screen with transition to Main Screen
class _LoadingScreen extends StatefulWidget {
  const _LoadingScreen({super.key});

  @override
  State<_LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<_LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Complete onboarding after 3 seconds
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final AppData appData = Provider.of<AppData>(context, listen: false);
        appData.completeOnboarding();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                'assets/images/logo.png',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0xFF4285F4),
                    ),
                    child: const Icon(
                      Icons.video_library,
                      color: Colors.white,
                      size: 60,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Setting up your experience...",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "This will only take a moment",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF4285F4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainNavigationScreen extends StatefulWidget {
  const _MainNavigationScreen({super.key});

  @override
  State<_MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<_MainNavigationScreen> 
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      _animationController.reset();
      setState(() {
        _currentIndex = index;
      });
      _animationController.forward();
    }
  }

  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return const _SubseraHomePage();
      case 1:
        return const _GalleryScreen();
      case 2:
        return const _FavoritesScreen();
      case 3:
        return const _ProfileScreen();
      default:
        return const _SubseraHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _getCurrentScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4285F4),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Generator',
          ),
        ],
      ),
    );
  }
}

class _SubseraHomePage extends StatelessWidget {
  const _SubseraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppData appData = Provider.of<AppData>(context, listen: false);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: const LinearGradient(
                      colors: <Color>[Color(0xFF00F0FF), Color(0xFF00BFFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(
                    Icons.blur_on,
                    color: theme.colorScheme.onPrimary,
                    size: 28,
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            Text("Subsera", style: theme.appBarTheme.titleTextStyle),
          ],
        ),
        centerTitle: false,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF4285F4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/nodes-icon.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 6),
                Consumer<AppData>(
                  builder:
                      (BuildContext context, AppData appData, Widget? child) {
                    return Text(
                      appData.coinCount.toString(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<AppData>(
        builder: (BuildContext context, AppData appData, Widget? child) {
          return _ScrollableContent(
            videoItems: appData.videoItems,
            unlocksRemaining: appData.unlocksRemaining,
            onUnlock: appData.unlockAllVideos,
          );
        },
      ),
    );
  }
}

class _ScrollableContent extends StatelessWidget {
  final List<VideoItem> videoItems;
  final int unlocksRemaining;
  final VoidCallback onUnlock;

  const _ScrollableContent({
    required this.videoItems,
    required this.unlocksRemaining,
    required this.onUnlock,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _UnlockVideosButton(
            unlocksRemaining: unlocksRemaining,
            onUnlock: onUnlock,
          ),
          const SizedBox(height: 24),
          ...videoItems.map<Widget>((VideoItem video) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _VideoCard(video: video),
            );
          }).toList(),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class _UnlockVideosButton extends StatelessWidget {
  final int unlocksRemaining;
  final VoidCallback onUnlock;

  const _UnlockVideosButton({
    required this.unlocksRemaining,
    required this.onUnlock,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool canUnlock = unlocksRemaining > 0;
    final ThemeData theme = Theme.of(context);

    return Center(
      child: ElevatedButton(
        onPressed: canUnlock ? onUnlock : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canUnlock
              ? theme.colorScheme.primary
              : theme.disabledColor,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.lock_open_rounded,
              color: canUnlock
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface.withOpacity(0.7),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              "Unlock Today's Videos",
              style: theme.textTheme.titleMedium?.copyWith(
                color: canUnlock
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            if (canUnlock)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "$unlocksRemaining unlock remaining today",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimary.withOpacity(0.8),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "No unlocks remaining today",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final VideoItem video;

  const _VideoCard({required this.video, super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.network(
                  video.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (
                        BuildContext context,
                        Object error,
                        StackTrace? stackTrace,
                      ) {
                        return Container(
                          color: Colors.grey,
                          alignment: Alignment.center,
                          height: 200,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.white,
                            size: 50,
                          ),
                        );
                      },
                ),
                if (video.isLocked)
                  Positioned.fill(
                    child: Container(
                      color: const Color.fromRGBO(0, 0, 0, 0.6),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.lock_rounded,
                              color: Colors.white,
                              size: 48,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Locked",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.9),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  video.title,
                  style: theme.textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  video.description,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: theme.textTheme.bodySmall?.color,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(video.duration, style: theme.textTheme.bodySmall),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.person,
                      color: theme.textTheme.bodySmall?.color,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(video.channelName, style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryScreen extends StatelessWidget {
  const _GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppData appData = Provider.of<AppData>(context);
    final ThemeData theme = Theme.of(context);
    
    // Filter unlocked videos
    final List<VideoItem> unlockedVideos = appData.videoItems
        .where((VideoItem video) => !video.isLocked)
        .toList();

    // Group videos into collections (for now, one collection with all videos)
    final int collectionCount = unlockedVideos.isEmpty ? 0 : 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF4285F4),
                  ),
                  child: const Icon(
                    Icons.video_library,
                    color: Colors.white,
                    size: 24,
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            const Text(
              "Gallery",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(
              "$collectionCount collections",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: unlockedVideos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.video_library_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No collections yet",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Unlock videos from the Home tab",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: <Widget>[
                      _CollectionCard(
                        title: "science",
                        date: "8/10/2025",
                        videoCount: unlockedVideos.length,
                        videos: unlockedVideos,
                        collectionId: "science_collection",
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  final String title;
  final String date;
  final int videoCount;
  final List<VideoItem> videos;
  final String collectionId;
  final bool showFavoriteButton;

  const _CollectionCard({
    super.key,
    required this.title,
    required this.date,
    required this.videoCount,
    required this.videos,
    required this.collectionId,
    this.showFavoriteButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF4285F4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    videoCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (showFavoriteButton)
                Consumer<AppData>(
                  builder: (BuildContext context, AppData appData, Widget? child) {
                    final bool isFavorite = appData.isCollectionFavorite(collectionId);
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey[600],
                        size: 28,
                      ),
                      onPressed: () {
                        appData.toggleFavoriteCollection(collectionId);
                      },
                    );
                  },
                ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[600],
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: videos.length,
              itemBuilder: (BuildContext context, int index) {
                final VideoItem video = videos[index];
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          video.imageUrl,
                          width: 100,
                          height: 140,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Container(
                              width: 100,
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.video_library,
                                color: Colors.grey[600],
                                size: 32,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoritesScreen extends StatelessWidget {
  const _FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppData appData = Provider.of<AppData>(context);
    final ThemeData theme = Theme.of(context);
    
    // Filter unlocked videos for favorite collections
    final List<VideoItem> unlockedVideos = appData.videoItems
        .where((VideoItem video) => !video.isLocked)
        .toList();

    // Get favorite collections (currently only "science" collection exists)
    final bool hasScienceCollection = unlockedVideos.isNotEmpty;
    final bool isScienceFavorite = appData.isCollectionFavorite("science_collection");
    
    final List<Widget> favoriteCollectionCards = <Widget>[];
    
    if (hasScienceCollection && isScienceFavorite) {
      favoriteCollectionCards.add(
        _CollectionCard(
          title: "science",
          date: "8/10/2025",
          videoCount: unlockedVideos.length,
          videos: unlockedVideos,
          collectionId: "science_collection",
          showFavoriteButton: false,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF4285F4),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 24,
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            const Text(
              "Favorites",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(
              "${favoriteCollectionCards.length} favorites",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: favoriteCollectionCards.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.favorite_border,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No favorites yet",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Mark collections as favorite from Gallery",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: favoriteCollectionCards,
                  ),
          ),
        ],
      ),
    );
  }
}

class _ProfileScreen extends StatefulWidget {
  const _ProfileScreen({super.key});

  @override
  State<_ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<_ProfileScreen> {
  final TextEditingController _inputController = TextEditingController();
  bool _isGenerating = false;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _generateVideos() async {
    if (_inputController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a topic to generate videos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isGenerating = true;
    });

    // Simulate API call delay
    await Future<void>.delayed(const Duration(seconds: 2));

    setState(() {
      _isGenerating = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Videos generated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppData appData = Provider.of<AppData>(context);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: const LinearGradient(
                      colors: <Color>[Color(0xFF00F0FF), Color(0xFF00BFFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(
                    Icons.blur_on,
                    color: theme.colorScheme.onSurface,
                    size: 28,
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            Text("Auto Generator", style: theme.appBarTheme.titleTextStyle),
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20),
            // Generator Icon
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xFF00F0FF), Color(0xFF00BFFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(
                  Icons.auto_awesome,
                  size: 60,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                "Auto Video Generator",
                style: theme.textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "Generate personalized videos automatically",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            // Input Section
            Text(
              "Update Prompt",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: "e.g., Flutter development, AI, Cooking...",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF4285F4)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF4285F4), width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: 1,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _generateVideos(),
            ),
            const SizedBox(height: 24),
            // Generate Button
            SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: _isGenerating ? null : _generateVideos,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4285F4),
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isGenerating
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Generating...",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.auto_awesome,
                            color: theme.colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Update Prompt",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: theme.textTheme.titleMedium),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle, style: theme.textTheme.bodySmall),
        ),
      ),
    );
  }
}
