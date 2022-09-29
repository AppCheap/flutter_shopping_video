import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:video_shop_flutter/page/page.dart';
import 'package:http/http.dart' as http;


const String productUrl = "https://grocery2.rnlab.io/wp-json/wc/v3/products";
const String consumerKey = "Your key";
const String consumerSecret = "Your Key";

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
  // List<Map<String, dynamic>> data = playList.sublist(0, 8);
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    List<Map<String, dynamic>> response = await mapData(1, 4);
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
          listData: data,
          pageSize: 4,
          loadMore: (page, pageSize) async{

            //just for test__
            if (page < 1) {
              debugPrint("load more...");
              List<Map<String, dynamic>> newData = await mapData((page + 2), 4);
              setState(() {
                data = [...data, ...newData];
              });
            }
            //_______________

          }),
    );
  }

  Future<dynamic> getData(int page, int perPage) async {
    http.Response response = await http.get(
      Uri.parse(
          "$productUrl?consumer_key=$consumerKey&consumer_secret=$consumerSecret&page=$page&per_page=$perPage&category=125"),
    );
    return jsonDecode(response.body);
  }

  Future<List<Map<String, dynamic>>> mapData(int page, int perPage) async {
    List<Map<String, dynamic>> listData = [];
    List<dynamic> response = await getData(page, perPage);
    for (var product in response) {
      List<dynamic> metaData = product['meta_data'];
      int id =
      metaData.firstWhere((element) => element['key'] == '_app_builder_shopping_video_addons_video_url')['id'];
      String url =
          metaData.firstWhere((element) => element['key'] == '_app_builder_shopping_video_addons_video_url')['value'];
      String title =
      metaData.firstWhere((element) => element['key'] == '_app_builder_shopping_video_addons_video_name')['value'];
      String description =
      metaData.firstWhere((element) => element['key'] == '_app_builder_shopping_video_addons_video_description')['value'];
      listData.add({
        'id': id,
        'url' : url,
        'video_title': title,
        'description': description
      });
    }

    return listData;
  }
}
