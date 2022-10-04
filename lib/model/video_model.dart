class VideoModel {
  int? id;
  String? user;
  String? userPic;
  String? videoTitle;
  String? songName;
  int? likes;
  String? comments;
  String? videoDescription;
  String url;
  String? thumbnail;
  bool liked;
  String? productName;
  String? productPermalink;
  String? stockStatus;

  VideoModel({
    this.id,
    this.user,
    this.userPic,
    this.videoTitle,
    this.songName,
    this.likes,
    this.comments,
    this.videoDescription,
    this.thumbnail,
    required this.url,
    this.liked = false,
    this.productName,
    this.productPermalink,
    this.stockStatus = 'instock',
  });

  VideoModel.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        user = json['user'],
        userPic = json['user_pic'],
        videoTitle = json['video_title'],
        songName = json['song_name'],
        likes = json['likes'],
        comments = json['comments'],
        url = json['url'],
        thumbnail = json['thumbnail'],
        videoDescription = json['description'],
        liked = json['liked'] ?? false,
        productName = json['product_name'],
        productPermalink = json['product_permalink'],
        stockStatus = json['stock_status'];
}
