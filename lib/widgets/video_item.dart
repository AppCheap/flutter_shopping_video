import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_shop_flutter/model/video_model.dart';
import 'package:video_shop_flutter/widgets/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoItem extends StatefulWidget {
  const VideoItem({
    Key? key,
    required this.video,
  }) : super(key: key);
  final VideoModel video;
  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController? _videoController;

  @override
  void dispose() {
    super.dispose();
    _videoController?.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _videoController != null
        ? VisibilityDetector(
            onVisibilityChanged: (visibleInfo) {
              if (visibleInfo.visibleFraction == 1) {
                if (!_videoController!.value.isPlaying) {
                  _videoController!.play();
                  _videoController!.setLooping(true);
                }
              }
            },
            key: UniqueKey(),
            child: VideoPlayerApp(
              controller: _videoController!,
            ),
          )
        : VisibilityDetector(
            key: UniqueKey(),
            child: Image.network(
              widget.video.thumbnail ?? "",
              loadingBuilder: (context, child, loadingProgress) {
                return const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Center(
                    child: Icon(Icons.play_arrow, size: 80, color: Colors.grey),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Center(
                    child: Icon(Icons.play_arrow, size: 80, color: Colors.grey),
                  ),
                );
              },
              fit: BoxFit.fill,
            ),
            onVisibilityChanged: (info) {
              if (info.visibleFraction == 1) {
                _videoController = VideoPlayerController.network(widget.video.url)
                  ..initialize().then((_) {
                    setState(() {});
                  });
              }
            },
          );
  }
}
