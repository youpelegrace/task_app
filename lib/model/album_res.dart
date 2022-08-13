// To parse this JSON data, do
//
//     final albumRes = albumResFromJson(jsonString);

import 'dart:convert';

List<AlbumRes> albumResFromJson(List<dynamic> str) =>
    List<AlbumRes>.from(str.map((x) => AlbumRes.fromJson(x)));

String albumResToJson(List<AlbumRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlbumRes {
  AlbumRes({
    this.userId,
    this.id,
    this.title,
  });

  int? userId;
  int? id;
  String? title;

  factory AlbumRes.fromJson(Map<String, dynamic> json) => AlbumRes(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
