import 'package:flutter/material.dart';
import 'package:video_shop_flutter/model/model.dart';

class ActionsToolbar extends StatelessWidget {
  final VideoModel video;
  final Widget Function(VideoModel? video)? followWidget;
  final Widget Function(VideoModel? video, Function(int likes, bool liked))?
      likeWidget;
  final Widget Function(VideoModel? video)? commentWidget;
  final Widget Function(VideoModel? video)? shareWidget;
  final Widget Function(VideoModel? video)? buyWidget;
  final Widget Function(VideoModel? video, int index)? viewWidget;
  final bool? enableBackgroundContent;
  final int index;

  /// Create video actions bar.
  const ActionsToolbar(
      {super.key,
      required this.video,
      required this.followWidget,
      required this.likeWidget,
      required this.commentWidget,
      required this.shareWidget,
      required this.buyWidget,
      required this.viewWidget,
      required this.index,
      this.enableBackgroundContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (enableBackgroundContent != null && enableBackgroundContent!)
          ? BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (followWidget != null)
              ? followWidget!(video)
              : const SizedBox.shrink(),
          (likeWidget != null)
              ? likeWidget!(
                  video,
                  (likes, liked) {
                    video.likes = likes;
                    video.liked = liked;
                  },
                )
              : _getSocialAction(
                  icon: Icons.heart_broken,
                  title: (video.likes ?? 0).toString()),
          (commentWidget != null)
              ? commentWidget!(video)
              : const SizedBox.shrink(),
          (shareWidget != null)
              ? shareWidget!(video)
              : _getSocialAction(icon: Icons.reply, title: 'Share'),
          (viewWidget != null)
              ? viewWidget!(video, index)
              : const SizedBox.shrink(),
          (buyWidget != null)
              ? buyWidget!(video)
              : _getSocialAction(
                  icon: Icons.shopping_cart_checkout_outlined, title: 'Buy'),
        ],
      ),
    );
  }

  /// Create default actions
  ///
  /// The title & icon are required.
  Widget _getSocialAction({required String title, required IconData icon}) {
    return Container(
        margin: const EdgeInsets.only(top: 15.0),
        width: 60.0,
        height: 60.0,
        child: Column(children: [
          Icon(icon, size: 25.0, color: Colors.white),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0)),
          )
        ]));
  }
}
