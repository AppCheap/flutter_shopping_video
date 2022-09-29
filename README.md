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

![](https://github.com/AppCheap/flutter_shopping_video/blob/main/feature.gif)

## Getting started

First, add video_shop_flutter as a [dependency in your pubspec.yaml file](https://docs.flutter.dev/development/packages-and-plugins/using-packages).

## Example

```dart
import 'package:example/data/video_data.dart';
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
  List<Map<String, dynamic>> data = playList.sublist(0,8);
  @override
  Widget build(BuildContext context) {
    debugPrint("\n data length: ${data.length} \n");
    return Scaffold(
      body: VideoShopFlutter(listData: data,
      pageSize: 8,
      loadMore: (page,  pageSize){
        //just for test__
        debugPrint("page:$page, pageSize: $pageSize");
        int start = (page + 1) * pageSize;
        int end = start  + pageSize;
        if(page <= 1){
          debugPrint("load more...");
          setState(() {
            data = [...data, ...playList.sublist(start, end)];
          });
        }
        //_______________
      }),
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
   }
  ```
  Please follow above format data.
  
  The `pageSize` is size of list data every time load more data, it affects when to load more data.

  The `loadMore` is a function to load more data, it is called every time current PageView is at position: `listData.length` - (`pageSize`/2)


