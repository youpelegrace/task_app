import 'dart:async';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:testing_app/model/album_res.dart';
import 'package:testing_app/model/photo_res.dart';

class Repository {
  Future<List<AlbumRes>> getAlbums({bool remoteOnly = true}) async {
    final albumBox = Hive.box("cachedata");
    List<AlbumRes> albums = [];
    dynamic data;
    if (!remoteOnly) {
      final cache = await albumBox.get('albums');
      if (cache != null) {
        data = jsonDecode(cache);
      }
    }

    if (data == null) {
      final response =
          await get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        await albumBox.put('albums', jsonEncode(data));
      } else {
        throw Exception('Failed to load album');
      }
    }
    albums = List<AlbumRes>.from(data.map((x) => AlbumRes.fromJson(x)));

    return albums;
  }

  Future<List<PhotoRes>> getPhotos(int albumId,
      {bool remoteOnly = true}) async {
    final photoBox = Hive.box("cachedata");
    List<PhotoRes> photos = [];
    dynamic data;
    if (!remoteOnly) {
      final cache = await photoBox.get('albums');
      if (cache != null) {
        data = jsonDecode(cache);
      }
    }

    if (data == null) {
      final response = await get(Uri.parse(
          'https://jsonplaceholder.typicode.com/photos?albumId=$albumId'));
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        await photoBox.put('albums', jsonEncode(data));
      } else {
        throw Exception('Failed to load photo');
      }
    }
    photos = List<PhotoRes>.from(data.map((x) => PhotoRes.fromJson(x)));

    return photos;
  }
}
