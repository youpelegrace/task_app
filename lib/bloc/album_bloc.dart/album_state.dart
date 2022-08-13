part of 'album_bloc.dart';

@immutable
abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<AlbumRes> albums;
  AlbumLoaded({required this.albums});
}

class AlbumError extends AlbumState {
  final String error;
  AlbumError({required this.error});
}
