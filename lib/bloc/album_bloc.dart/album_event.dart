part of 'album_bloc.dart';

@immutable
abstract class AlbumEvent {}

class FetchAlbumList extends AlbumEvent {}

class InternetCheck extends AlbumEvent {}
