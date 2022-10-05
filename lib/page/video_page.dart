import 'package:flutter/material.dart';
import 'package:video_shop_flutter/video_shop_flutter.dart';

final List<Color> gradientBackground = [
  const Color(0xff000000).withOpacity(0.9),
  const Color(0xff000000).withOpacity(0.8),
  const Color(0xff000000).withOpacity(0.7),
  const Color(0xff000000).withOpacity(0.6),
  const Color(0xff000000).withOpacity(0.5),
  const Color(0xff000000).withOpacity(0.4),
  const Color(0xff000000).withOpacity(0.3),
  const Color(0xff000000).withOpacity(0.2),
  const Color(0xff000000).withOpacity(0.1),
  const Color(0xff000000).withOpacity(0.0),
];
const List<double> stopGradient = [
  0.1,
  0.2,
  0.3,
  0.4,
  0.5,
  0.6,
  0.7,
  0.8,
  0.9,
  1.0,
];

class VideoPage extends StatelessWidget {
  /// Create video page view.
  const VideoPage({
    Key? key,
    required this.video,
    this.customVideoInfo,
    required this.followWidget,
    required this.likeWidget,
    required this.commentWidget,
    required this.shareWidget,
    required this.buyWidget,
    required this.viewWidget,
    this.informationPadding,
    required this.videoWatched,
    this.informationAlign,
    this.actionsAlign,
    this.actionsPadding,
    required this.index,
    required this.updateLastSeenPage,
    this.enableBackgroundContent = false,
  }) : super(key: key);
  final VideoModel video;
  final Widget Function(VideoModel? video)? customVideoInfo;
  final Widget Function(VideoModel? video)? followWidget;
  final Widget Function(VideoModel? video, Function(int likes, bool liked))?
      likeWidget;
  final Widget Function(VideoModel? video)? commentWidget;
  final Widget Function(VideoModel? video)? shareWidget;
  final Widget Function(VideoModel? video)? buyWidget;
  final Widget Function(VideoModel? video, int index)? viewWidget;
  final EdgeInsetsGeometry? informationPadding;
  final List<String> videoWatched;
  final AlignmentGeometry? informationAlign;
  final AlignmentGeometry? actionsAlign;
  final EdgeInsetsGeometry? actionsPadding;
  final int index;
  final Function(int lastSeenPage)? updateLastSeenPage;
  final bool? enableBackgroundContent;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Video.
          Align(
            alignment: Alignment.center,
            child: VideoItem(
              video: video,
              videoWatched: videoWatched,
              index: index,
              updateLastSeenPage: updateLastSeenPage,
            ),
          ),
          // Background content.
          if (enableBackgroundContent != null && enableBackgroundContent!)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: stopGradient,
                    colors: gradientBackground,
                  ),
                ),
              ),
            ),
          // Video info______________.
          Align(
            alignment: informationAlign ?? Alignment.bottomLeft,
            child: Padding(
              padding: informationPadding ??
                  const EdgeInsets.only(left: 20, bottom: 70),
              child: (customVideoInfo != null)
                  ? customVideoInfo!(video)
                  : VideoInformation(
                      video.user ?? "",
                      video.videoTitle ?? "",
                      video.videoDescription ?? "",
                    ),
            ),
          ),
          // Video actions______________.
          Align(
            alignment: actionsAlign ?? Alignment.bottomRight,
            child: Padding(
              padding: actionsPadding ?? const EdgeInsets.only(bottom: 70),
              child: ActionsToolbar(
                enableBackgroundContent: enableBackgroundContent,
                video: video,
                followWidget: followWidget,
                likeWidget: likeWidget,
                commentWidget: commentWidget,
                shareWidget: shareWidget,
                buyWidget: buyWidget,
                viewWidget: viewWidget,
                index: index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
