import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';

class VideoGeneratorService {
  /// Generates 5 videos based on user input
  /// For this demo, we'll use sample videos when FFmpeg is not available
  Future<List<String>> generateVideos(String userInput, int count) async {
    try {
      // First try to generate actual videos with FFmpeg
      return await _generateActualVideos(userInput, count);
    } catch (e) {
      print('FFmpeg not available, using demo videos: $e');
      // Fallback to demo videos
      return await generateDemoVideos(userInput);
    }
  }

  /// Generate actual videos using FFmpeg
  Future<List<String>> _generateActualVideos(String userInput, int count) async {
    List<String> videoPaths = [];
    
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String videoDir = '${appDocDir.path}/generated_videos';
    
    // Create videos directory if it doesn't exist
    Directory(videoDir).createSync(recursive: true);
    
    for (int i = 0; i < count; i++) {
      String videoPath = await _generateSingleVideo(
        userInput, 
        i, 
        videoDir,
      );
      videoPaths.add(videoPath);
    }
    
    return videoPaths;
  }

  /// Generate a single video with different visual properties
  Future<String> _generateSingleVideo(String input, int index, String outputDir) async {
    String outputPath = '$outputDir/video_${index + 1}.mp4';
    
    // Different colors for each video
    List<String> colors = ['red', 'blue', 'green', 'purple', 'orange'];
    String color = colors[index % colors.length];
    
    // Create a simple video with colored background and text
    String ffmpegCommand = 
        '-f lavfi '
        '-i "color=c=${color}:s=720x480:d=5" '
        '-vf "drawtext=fontfile=/system/fonts/arial.ttf:'
        'text=\'Video ${index + 1}: $input\':'
        'fontcolor=white:fontsize=30:x=(w-text_w)/2:y=(h-text_h)/2" '
        '-c:v libx264 -t 5 -pix_fmt yuv420p -y "$outputPath"';

    try {
      await FFmpegKit.execute(ffmpegCommand).then((session) async {
        final returnCode = await session.getReturnCode();
        if (ReturnCode.isSuccess(returnCode)) {
          print('Video ${index + 1} generated successfully');
        } else {
          throw Exception('FFmpeg failed for video ${index + 1}');
        }
      });
      
      return outputPath;
    } catch (e) {
      // Fallback: create a placeholder video file
      return await _createPlaceholderVideo(input, index, outputDir);
    }
  }

  /// Creates a placeholder video file when FFmpeg is not available
  Future<String> _createPlaceholderVideo(String input, int index, String outputDir) async {
    String outputPath = '$outputDir/placeholder_video_${index + 1}.mp4';
    
    // Create a simple placeholder file
    // In a real implementation, you might use a different video generation method
    File placeholderFile = File(outputPath);
    await placeholderFile.writeAsString('Placeholder for Video ${index + 1}: $input');
    
    return outputPath;
  }

  /// Get sample video URLs for demo purposes
  List<String> getSampleVideoUrls() {
    return [
      'https://sample-videos.com/zip/10/mp4/SampleVideo_720x480_1mb.mp4',
      'https://sample-videos.com/zip/10/mp4/SampleVideo_720x480_2mb.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    ];
  }

  /// Generate demo videos using sample URLs (for testing purposes)
  Future<List<String>> generateDemoVideos(String userInput) async {
    // Simulate video generation delay
    await Future.delayed(Duration(seconds: 2));
    
    // Return sample video URLs for demo
    return getSampleVideoUrls();
  }
}