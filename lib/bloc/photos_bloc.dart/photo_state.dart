import 'package:flutter/material.dart';
import 'package:testing_app/model/photo_res.dart';

@immutable
abstract class PhotosState {}

class PhotosInitial extends PhotosState {}

class PhotosLoading extends PhotosState {}

class PhotosLoaded extends PhotosState {
  final List<PhotoRes> photos;
  PhotosLoaded({required this.photos});
}

class PhotosError extends PhotosState {
  final String error;
  PhotosError({required this.error});
}
