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
    this.informationPadding,
    required this.videoWatched,
    this.informationAlign,
    this.actionsAlign,
    this.actionsPadding,
  }) : super(key: key);
  final VideoModel video;
  final Widget Function(VideoModel? video)? customVideoInfo;
  final Widget Function(VideoModel? video)? followWidget;
  final Widget Function(VideoModel? video, Function(int likes, bool liked))? likeWidget;
  final Widget Function(VideoModel? video)? commentWidget;
  final Widget Function(VideoModel? video)? shareWidget;
  final Widget Function(VideoModel? video)? buyWidget;
  final EdgeInsetsGeometry? informationPadding;
  final List<String> videoWatched;
  final AlignmentGeometry? informationAlign;
  final AlignmentGeometry? actionsAlign;
  final EdgeInsetsGeometry? actionsPadding;

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

          //Video info______________
          Align(
            alignment: informationAlign ?? Alignment.bottomLeft,
            child: Padding(
              padding: informationPadding ?? const EdgeInsets.only(left: 20, bottom: 70),
              child: (customVideoInfo != null)
                  ? customVideoInfo!(video)
                  : VideoInformation(
                      video.user ?? "",
                      video.videoTitle ?? "",
                      video.videoDescription ?? "",
                    ),
            ),
          ),
          //Video actions______________
          Align(
            alignment: actionsAlign ?? Alignment.bottomRight,
            child: Padding(
              padding: actionsPadding ?? const EdgeInsets.only( bottom: 70),
              child: ActionsToolbar(
                video: video,
                followWidget: followWidget,
                likeWidget: likeWidget,
                commentWidget: commentWidget,
                shareWidget: shareWidget,
                buyWidget: buyWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
