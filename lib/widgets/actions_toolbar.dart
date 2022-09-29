import 'package:flutter/material.dart';
import 'package:video_shop_flutter/model/model.dart';

class ActionsToolbar extends StatelessWidget {
  // Full dimensions of an action
  static const double actionWidgetSize = 60.0;

// The size of the icon  for Social Actions
  static const double actionIconSize = 35.0;

// The size of the share social icon
  static const double shareActionIconSize = 25.0;

// The size of the profile image in the follow Action
  static const double profileImageSize = 50.0;

// The size of the plus icon under the profile image in follow action
  static const double plusIconSize = 20.0;

  final VideoModel video;
  final Widget Function(VideoModel? video)? followWidget;
  final Widget Function(VideoModel? video)? likeWidget;
  final Widget Function(VideoModel? video)? commentWidget;
  final Widget Function(VideoModel? video)? shareWidget;
  final Widget Function(VideoModel? video)? buyWidget;

  const ActionsToolbar({
    super.key,
    required this.video,
    required this.followWidget,
    required this.likeWidget,
    required this.commentWidget,
    required this.shareWidget,
    required this.buyWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        (followWidget != null) ? followWidget!(video) : _getFollowAction(pictureUrl: video.url),
        (likeWidget != null)
            ? likeWidget!(video)
            : _getSocialAction(icon: Icons.heart_broken, title: video.likes ?? "0"),
        (commentWidget != null)
            ? commentWidget!(video)
            : _getSocialAction(icon: Icons.chat_bubble, title: video.comments ?? "0"),
        (shareWidget != null)
            ? shareWidget!(video)
            : _getSocialAction(icon: Icons.reply, title: 'Share', isShare: true),
        (buyWidget != null)
            ? buyWidget!(video)
            : _getSocialAction(icon: Icons.shopping_cart_checkout_outlined, title: 'Buy'),
      ]),
    );
  }

  Widget _getSocialAction({required String title, required IconData icon, bool isShare = false}) {
    return Container(
        margin: const EdgeInsets.only(top: 15.0),
        width: 60.0,
        height: 60.0,
        child: Column(children: [
          Icon(icon, size: isShare ? 25.0 : 25.0, color: Colors.grey[300]),
          Padding(
            padding: EdgeInsets.only(top: isShare ? 8.0 : 8.0),
            child: Text(title,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: isShare ? 14.0 : 14.0)),
          )
        ]));
  }

  Widget _getFollowAction({required String pictureUrl}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        width: 60.0,
        height: 60.0,
        child: Stack(children: [_getProfilePicture(pictureUrl), _getPlusIcon()]));
  }

  Widget _getPlusIcon() {
    return Positioned(
      bottom: 0,
      left: ((actionWidgetSize / 2) - (plusIconSize / 2)),
      child: Container(
          width: plusIconSize, // PlusIconSize = 20.0;
          height: plusIconSize, // PlusIconSize = 20.0;
          decoration:
              BoxDecoration(color: const Color.fromARGB(255, 255, 43, 84), borderRadius: BorderRadius.circular(15.0)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 20.0,
          )),
    );
  }

  Widget _getProfilePicture(userPic) {
    return Positioned(
        left: (actionWidgetSize / 2) - (profileImageSize / 2),
        child: Container(
            padding: const EdgeInsets.all(1.0), // Add 1.0 point padding to create border
            height: profileImageSize, // ProfileImageSize = 50.0;
            width: profileImageSize, // ProfileImageSize = 50.0;
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(profileImageSize / 2)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10000.0),
                child: Image.network(
                  userPic,
                  loadingBuilder: (context, child, loadingProgress) {
                    return Container(
                      color: Colors.white70,
                    );                  },
                  errorBuilder: (context, object, stackTrace) {
                    return Container(
                      color: Colors.white70,
                    );
                  },
                ))));
  }
}
