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
    this.contentPadding,
    required this.videoWatched
  }) : super(key: key);
  final VideoModel video;
  final Widget Function(VideoModel? video)? customVideoInfo;
  final Widget Function(VideoModel? video)? followWidget;
  final Widget Function(VideoModel? video, Function(int likes, bool liked))? likeWidget;
  final Widget Function(VideoModel? video)? commentWidget;
  final Widget Function(VideoModel? video)? shareWidget;
  final Widget Function(VideoModel? video)? buyWidget;
  final EdgeInsetsGeometry? contentPadding;
  final List<String> videoWatched;

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
              videoWatched: videoWatched,
            ),
          ),

          //Video action & info______________
          Padding(
            padding: contentPadding ??
                const EdgeInsets.only(
                  bottom: 90,
                  left: 20,
                  right: 10,
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    (customVideoInfo != null)
                        ? Expanded(child: customVideoInfo!(video))
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
