import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_shop_flutter/model/video_model.dart';
import 'package:video_shop_flutter/page/video_page.dart';

class VideoShopFlutter extends StatefulWidget {
  /// Create Video Player Layout Like Tiktok.
  ///
  /// The listData, pageSize, loadMore are required.
  ///
  /// The others arguments use for custom UI (not required),
  ///
  /// if you want to hide them, you can return SizeBox.shrink().
  ///
  /// Note: the [listData] is a list of Map, each Map is a Video object and
  ///
  /// video object required some field of data like this:
  ///
  /// ```dart
  /// {
  ///   'id': 123,
  ///   'url': 'https://video.mp4',
  ///   'thumbnail': 'https://thumbnail.jpg',
  ///   'likes': 100,
  ///   'liked': true,
  /// }
  /// ```
  ///
  /// Please follow above format data.
  ///
  /// The [pageSize] is size of list data every time load more data,
  ///
  /// it affects when to load more data.
  ///
  /// The loadMore is a function to load more data,
  ///
  /// it is called every time current PageView is at position:
  ///
  /// [listData.length] - ([pageSize]/2)
  ///
  /// Example:
  ///
  /// ```dart
  /// VideoShopFlutter(
  ///       listData: data,
  ///       pageSize: 10,
  ///       loadMore: (){
  ///         debugPrint("load more...");
  ///         setState(() {
  ///           data = [...data, ...playList];
  ///         });
  ///       }
  ///  )
  ///
  /// ```
  const VideoShopFlutter(
      {Key? key,
      required this.listData,
      this.customVideoInfo,
      this.followWidget,
      this.likeWidget,
      this.commentWidget,
      this.shareWidget,
      this.buyWidget,
      required this.pageSize,
      required this.loadMore,
      this.contentPadding})
      : super(key: key);

  /// Your input data.
  ///
  /// Data must be a List<Map<String, dynamic>.
  ///
  /// Follow this format data:
  ///
  /// ```dart
  /// {
  ///   'id': 123,
  ///   'url': 'https://video.mp4',
  ///   'thumbnail': 'https://thumbnail.jpg',
  ///   'likes': 100,
  ///   'liked': true,
  ///   'description': 'this is description'
  ///   'video_title': this is title of video'
  /// }
  /// ```
  final List<Map<String, dynamic>> listData;

  /// Your pageSize when you call get-list API.
  final int pageSize;

  /// Load more data.
  ///
  /// It is called every time current PageView is at position:
  ///
  /// [listData.length] - ([pageSize]/2)
  ///
  /// The first argument is current page of video list (start at 0),
  ///
  /// it depends on [pageSize].
  ///
  /// The seconds argument is your [pageSize]
  final Function(int page, int pageSize) loadMore;

  /// Padding between content above video and device screen.
  final EdgeInsetsGeometry? contentPadding;
  final Widget Function(VideoModel? video)? customVideoInfo;
  final Widget Function(VideoModel? video)? followWidget;

  /// Create like widget.
  ///
  /// The first argument is instant of Video.
  ///
  /// The second argument is function to update data,
  ///
  /// this function receives two argument:
  ///
  /// first is total likes, second is liked status (true or false)
  ///
  /// this function need be called when total likes or liked status be changed
  final Widget Function(VideoModel? video, Function(int likes, bool liked))? likeWidget;
  final Widget Function(VideoModel? video)? commentWidget;
  final Widget Function(VideoModel? video)? shareWidget;
  final Widget Function(VideoModel? video)? buyWidget;

  @override
  State<VideoShopFlutter> createState() => _VideoShopFlutterState();
}

class _VideoShopFlutterState extends State<VideoShopFlutter> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      if (_pageController.page != null) {
        if (_pageController.page!.round() != currentPage) {
          currentPage = _pageController.page!.round();
          if (currentPage == widget.listData.length - (widget.pageSize / 2)) {
            widget.loadMore(
              (currentPage ~/ widget.pageSize),
              widget.pageSize,
            );
          }
        }
      }
    });
    if (widget.listData.isEmpty) {
      return Container(
          color: Colors.black,
          child: const Center(
            child: CupertinoActivityIndicator(
              color: Colors.white,
            ),
          ));
    }
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      children: List.generate(
        widget.listData.length,
        (index) => VideoPage(
          video: VideoModel.fromJson(widget.listData[index]),
          customVideoInfo: widget.customVideoInfo,
          followWidget: widget.followWidget,
          likeWidget: widget.likeWidget,
          commentWidget: widget.commentWidget,
          shareWidget: widget.shareWidget,
          buyWidget: widget.buyWidget,
        ),
      ),
    );
  }
}
