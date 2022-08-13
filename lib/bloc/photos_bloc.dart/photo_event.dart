import 'package:flutter/material.dart';

@immutable
abstract class PhotosEvent {}

class FetchPhotos extends PhotosEvent {
  final int albumId;
  FetchPhotos({required this.albumId});
}

class CheckInternet extends PhotosEvent {}
