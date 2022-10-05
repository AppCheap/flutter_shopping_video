import 'package:example/constant.dart';
import 'package:example/service/service.dart';
import 'package:flutter/material.dart';

class LikeWidget extends StatefulWidget {
  /// Create like widget.
  const LikeWidget(
      {Key? key,
      required this.liked,
      required this.likes,
      required this.updateData,
      required this.id})
      : super(key: key);
  final bool liked;
  final int likes;
  final int? id;
  final Function(int likes, bool liked) updateData;
  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  late bool localLiked;
  late int localLikes;
  ApiService service = ApiService();

  @override
  void initState() {
    super.initState();
    localLiked = widget.liked;
    localLikes = widget.likes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      width: 60.0,
      height: 60.0,
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              if (localLiked) {
                service.likeVideo(id: widget.id ?? 0, token: token);
                setState(() {
                  localLikes -= 1;
                  localLiked = false;
                  widget.updateData(localLikes, localLiked);
                });
              } else {
                service.likeVideo(id: widget.id ?? 0, token: token);
                setState(() {
                  localLikes += 1;
                  localLiked = true;
                  widget.updateData(localLikes, localLiked);
                });
              }
            },
            child: Icon(Icons.heart_broken,
                size: 25.0, color: (localLiked) ? Colors.red : Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              localLikes.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
