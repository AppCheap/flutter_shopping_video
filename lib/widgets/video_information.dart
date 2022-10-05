import 'package:flutter/material.dart';

class VideoInformation extends StatelessWidget {
  final String username;
  final String videoTitle;
  final String songInfo;

  /// Create video information.
  const VideoInformation(this.username, this.videoTitle, this.songInfo,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120.0,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                username,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                videoTitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(songInfo,
                  style: const TextStyle(color: Colors.white, fontSize: 14.0)),
              const SizedBox(
                height: 10,
              ),
            ]));
  }
}
