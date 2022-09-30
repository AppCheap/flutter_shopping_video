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
    double screenRatio = MediaQuery.of(context).size.aspectRatio;
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
      child: (widget.controller.value.aspectRatio < screenRatio)
          ? Stack(
              fit: StackFit.expand,
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: widget.controller.value.size.width,
                      height: widget.controller.value.size.height,
                      child: VideoPlayer(widget.controller),
                    ),
                  ),
                ),
                if (_showPause)
                  const Center(
                    child: Icon(Icons.play_arrow, color: Colors.white54, size: 40),
                  ),
              ],
            )
          : AspectRatio(
              aspectRatio: widget.controller.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(widget.controller),
                  if (_showPause)
                    const Center(
                      child: Icon(Icons.play_arrow, color: Colors.white54, size: 40),
                    ),
                ],
              ),
            ),
    );
  }
}
