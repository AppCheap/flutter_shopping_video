import 'package:flutter/material.dart';
import 'package:video_shop_flutter/video_shop_flutter.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({
    Key? key,
    required this.video,
    this.customVideoInfo,
    required this.followWidget,
    required this.likeWidget,
    required this.commentWidget,
    required this.shareWidget,
    required this.buyWidget,
  }) : super(key: key);
  final VideoModel video;
  final Widget Function(VideoModel? video)? customVideoInfo;
  final Widget Function(VideoModel? video)? followWidget;
  final Widget Function(VideoModel? video)? likeWidget;
  final Widget Function(VideoModel? video)? commentWidget;
  final Widget Function(VideoModel? video)? shareWidget;
  final Widget Function(VideoModel? video)? buyWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: VideoItem(
              video: video,
            ),
          ),
          //Video action & info
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  (customVideoInfo != null)
                      ? customVideoInfo!(video)
                      : VideoInformation(
                          video.user ?? "",
                          video.videoTitle ?? "",
                          video.videoDescription ?? "",
                        ),
                  ActionsToolbar(
                    video: video,
                    followWidget: followWidget,
                    likeWidget: likeWidget,
                    commentWidget: commentWidget,
                    shareWidget: shareWidget,
                    buyWidget: buyWidget,
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        ],
      ),
    );
  }
}
