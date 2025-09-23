import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class VideoDisplayScreen extends StatefulWidget {
  final List<String> videoPaths;

  VideoDisplayScreen({required this.videoPaths});

  @override
  _VideoDisplayScreenState createState() => _VideoDisplayScreenState();
}

class _VideoDisplayScreenState extends State<VideoDisplayScreen> {
  List<VideoPlayerController> _controllers = [];
  int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeVideoControllers();
  }

  void _initializeVideoControllers() {
    for (String videoPath in widget.videoPaths) {
      VideoPlayerController controller;
      
      if (videoPath.startsWith('http')) {
        controller = VideoPlayerController.networkUrl(Uri.parse(videoPath));
      } else {
        controller = VideoPlayerController.file(File(videoPath));
      }
      
      controller.initialize().then((_) {
        setState(() {});
      });
      
      _controllers.add(controller);
    }
  }

  void _playVideo(int index) {
    // Pause all other videos
    for (int i = 0; i < _controllers.length; i++) {
      if (i != index) {
        _controllers[i].pause();
      }
    }
    
    // Play selected video
    setState(() {
      _currentVideoIndex = index;
    });
    
    _controllers[index].play();
  }

  void _pauseVideo(int index) {
    _controllers[index].pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Videos'),
        backgroundColor: Colors.blue,
      ),
      body: widget.videoPaths.isEmpty
          ? Center(
              child: Text(
                'No videos generated',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                // Main video player area
                Container(
                  height: 300,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: _controllers.isNotEmpty && 
                         _controllers[_currentVideoIndex].value.isInitialized
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: _controllers[_currentVideoIndex].value.aspectRatio,
                            child: VideoPlayer(_controllers[_currentVideoIndex]),
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                
                // Video controls
                if (_controllers.isNotEmpty && 
                    _controllers[_currentVideoIndex].value.isInitialized)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_controllers[_currentVideoIndex].value.isPlaying) {
                              _pauseVideo(_currentVideoIndex);
                            } else {
                              _playVideo(_currentVideoIndex);
                            }
                          },
                          icon: Icon(
                            _controllers[_currentVideoIndex].value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _controllers[_currentVideoIndex].seekTo(Duration.zero);
                          },
                          icon: Icon(Icons.replay, size: 30),
                        ),
                      ],
                    ),
                  ),
                
                // Video thumbnail grid
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 16 / 9,
                      ),
                      itemCount: widget.videoPaths.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _playVideo(index),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _currentVideoIndex == index
                                    ? Colors.blue
                                    : Colors.grey[300]!,
                                width: _currentVideoIndex == index ? 3 : 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: _controllers[index].value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: VideoPlayer(_controllers[index]),
                                    )
                                  : Container(
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.video_file, size: 30),
                                            Text('Video ${index + 1}'),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    for (VideoPlayerController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}