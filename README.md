<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Flutter Shopping Video: Create video player layout like tiktok.

## Features

Video player layout: 

![](https://github.com/AppCheap/flutter_shopping_video/blob/3ca297a9967053e1ab790b1e34b963284876b5a4/example.gif)

## Getting started

First, add video_shop_flutter as a [dependency in your pubspec.yaml file](https://docs.flutter.dev/development/packages-and-plugins/using-packages).

## Example

```dart
import 'package:example/service/service.dart';
import 'package:example/widgets/like_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_shop_flutter/page/page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> data = [];
  ApiService service = ApiService();
  List<String> videoWatched = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    List<Map<String, dynamic>> response = await service.mapData(1, 4);
    setState(() {
      data = response;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("\n data length: ${data.length} \n");

    return Scaffold(
      body: VideoShopFlutter(
        // Called every time video page is changed.
        updateLastSeenPage: (lastSeenPageIndex) {},
        // Video data.
        listData: data,
        // Watched videos, it's updated every time new video is watched.
        videoWatched: videoWatched,
        pageSize: 4,
        enableBackgroundContent: true,
        // Load more video data.
        loadMore: (page, pageSize) async {
          // Just for test.
          debugPrint("load more...");
          debugPrint("Video $videoWatched");
          List<Map<String, dynamic>> newData =
              await service.mapData((page + 2), 4);
          if (newData.isNotEmpty) {
            setState(() {
              data = [...data, ...newData];
            });
          }
          //.
        },
        // Your custom widget.
        likeWidget: (video, updateData) {
          return LikeWidget(
            likes: video?.likes ?? 0,
            liked: video?.liked ?? false,
            updateData: updateData,
            id: video?.id,
          );
        },
      ),
    );
  }
}
```


## Note

- `listData` in `VideoShopFlutter(listData: playList,)`

  The `listData` is a list of Map, each Map is a Video object and
  video object required some field of data like this:
  ```dart
   {
     'id': 123,
     'url': 'https://video.mp4'
     'thumbnail': 'https://thumbnail.jpg'
     'video_title': 'title',
     'description': 'description',
     'likes': 5 ,
     'liked': true,
     'product_name': 'productName',
     'product_permalink': 'productPermalink',
     'stock_status': 'stockStatus',
   }
  ```
  Please follow above format data.
  
  The `pageSize` is size of list data every time load more data, it affects when to load more data.

  The `loadMore` is a function to load more data, it is called every time current PageView is at position: `listData.length` - (`pageSize`/2)


