import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:testing_app/model/album_res.dart';
import 'package:testing_app/model/photo_res.dart';

class Repository {
  final Dio _dio;
  Repository({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
                receiveTimeout: 100000,
                connectTimeout: 100000,
                baseUrl: "https://jsonplaceholder.typicode.com")) {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.interceptors.add(DioCacheInterceptor(
        options:
            CacheOptions(policy: CachePolicy.request, store: MemCacheStore())));
  }

  Future<List<AlbumRes>> getAlbums({bool remoteOnly = false}) async {
    final albumBox = Hive.box("cachedata");
    List<AlbumRes> albums = [];
    if (!remoteOnly) {
      final cache = await albumBox.get('albums');
      // print("this one is printing $cache");
      if (cache != null) {
        // print(cache);
        final data = albumResFromJson(cache);
        print(data);
        return data;
      }
    }

    final response =
        await _dio.get('https://jsonplaceholder.typicode.com/albums');
    if (response.statusCode == 200) {
      await albumBox.put('albums', response.data);
      albums = albumResFromJson(response.data);
      // final albums = albumResFromJson(response.data);
      // save album in cache
      return albums;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<PhotoRes>> getPhotos(int albumId) async {
    // String? getPhotos = await HiveStorage.getDataFromHive(key: "getPhotos");

    // if (getPhotos!.isNotEmpty) {
    //   getPhotos;
    // }
    final response = await _dio
        .get('https://jsonplaceholder.typicode.com/photos?albumId=$albumId');
    if (response.statusCode == 200) {
      final photos = photoResFromJson(response.data);
      // HiveStorage.saveDataToHive(key: "getPhotos", value: response.data);
      return photos;
    } else {
      throw Exception('Failed to load photo');
    }
  }
}
