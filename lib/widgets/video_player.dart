import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerApp extends StatefulWidget {
  const VideoPlayerApp({Key? key, required this.controller}) : super(key: key);
  final VideoPlayerController controller;
  @override
  State<VideoPlayerApp> createState() => _VideoPlayerAppState();
}

class _VideoPlayerAppState extends State<VideoPlayerApp> {
  bool _showPause = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.controller.value.isPlaying) {
          widget.controller.pause();
          setState(() {
            _showPause = true;
          });
        } else {
          widget.controller.play();
          setState(() {
            _showPause = false;
          });
        }
      },
      child: Stack(
        children: [
          VideoPlayer(widget.controller),
          if (_showPause)
            const Center(
              child: Icon(Icons.play_arrow, color: Colors.white54, size: 40),
            ),
        ],
      ),
    );
  }
}
