class PhotoRes {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  PhotoRes({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  PhotoRes.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}




// // To parse this JSON data, do
// //
// //     final photoRes = photoResFromJson(jsonString);

// // List<PhotoRes> photoResFromJson(List<dynamic> str) =>
// //     List<PhotoRes>.from(str.map((x) => PhotoRes.fromJson(x)));

// // String photoResToJson(List<PhotoRes> data) =>
// //     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class PhotoRes {
//   PhotoRes({
//     this.albumId,
//     this.id,
//     this.title,
//     this.url,
//     this.thumbnailUrl,
//   });

//   int? albumId;
//   int? id;
//   String? title;
//   String? url;
//   String? thumbnailUrl;

//   factory PhotoRes.fromJson(Map<String, dynamic> json) => PhotoRes(
//         albumId: json["albumId"],
//         id: json["id"],
//         title: json["title"],
//         url: json["url"],
//         thumbnailUrl: json["thumbnailUrl"],
//       );

//   Map<String, dynamic> toJson() => {
//         "albumId": albumId,
//         "id": id,
//         "title": title,
//         "url": url,
//         "thumbnailUrl": thumbnailUrl,
//       };
// }
