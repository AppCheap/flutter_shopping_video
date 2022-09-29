import 'package:flutter/cupertino.dart';
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
  ///   'url': 'https://video.mp4'
  ///   'thumbnail': 'https://thumbnail.jpg'
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
  const VideoShopFlutter({
    Key? key,
    required this.listData,
    this.customVideoInfo,
    this.followWidget,
    this.likeWidget,
    this.commentWidget,
    this.shareWidget,
    this.buyWidget,
    required this.pageSize,
    required this.loadMore,
  }) : super(key: key);
  final List<Map<String, dynamic>> listData;
  final Widget Function(VideoModel? video)? customVideoInfo;
  final Widget Function(VideoModel? video)? followWidget;
  final Widget Function(VideoModel? video)? likeWidget;
  final Widget Function(VideoModel? video)? commentWidget;
  final Widget Function(VideoModel? video)? shareWidget;
  final Widget Function(VideoModel? video)? buyWidget;
  final int pageSize;
  final Function(
    int page,
    int pageSize,
  ) loadMore;

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
