import 'dart:convert';

import 'package:example/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiService {
  /// Get data.
  Future<dynamic> getData(int page, int perPage) async {
    http.Response response = await http.get(
      Uri.parse(
          "$productUrl?consumer_key=$consumerKey&consumer_secret=$consumerSecret&page=$page&per_page=$perPage&category=125&user_id=$userId"),
    );
    return jsonDecode(response.body);
  }

  /// Map data.
  Future<List<Map<String, dynamic>>> mapData(int page, int perPage) async {
    List<Map<String, dynamic>> listData = [];
    List<dynamic> response = await getData(page, perPage);
    for (var product in response) {
      List<dynamic> metaData = product['meta_data'];
      int? id = product['id'];
      String? url = metaData.firstWhere((element) =>
          element['key'] ==
          '_app_builder_shopping_video_addons_video_url')['value'];
      String? title = metaData.firstWhere((element) =>
          element['key'] ==
          '_app_builder_shopping_video_addons_video_name')['value'];
      String? description = metaData.firstWhere((element) =>
          element['key'] ==
          '_app_builder_shopping_video_addons_video_description')['value'];
      int? likes = metaData.firstWhere((element) =>
          element['key'] == 'app_builder_shopping_video_likes')['value'];
      String? liked = metaData.firstWhere((element) =>
          element['key'] == 'app_builder_shopping_video_liked')['value'];
      listData.add({
        'id': id,
        'url': url,
        'video_title': title,
        'description': description,
        'likes': likes,
        'liked': (liked == 'true')
      });
    }

    return listData;
  }

  Future<void> likeVideo({
    required int id,
    required String token,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
            "https://grocery2.rnlab.io/wp-json/app-builder-shopping-video-addons/v1/likes?app-builder-decode=true"),
        body: {
          "post_id": id.toString(),
        },
        headers: {"Authorization": "Bearer $token"},
      );
      debugPrint("\n ${jsonDecode(res.body)}");
    } catch (e) {
      debugPrint("Error from service: $e");
      rethrow;
    }
  }
}
