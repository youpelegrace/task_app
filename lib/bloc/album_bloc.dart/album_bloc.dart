import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/core/services/album_services.dart';
import 'package:testing_app/core/services/connectivity_service.dart';
import 'package:testing_app/model/album_res.dart';

part 'album_state.dart';
part 'album_event.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  Repository repository;
  ConnectivityService connectivityService;
  AlbumBloc({required this.repository, required this.connectivityService})
      : super(AlbumInitial()) {
    on<InternetCheck>((event, emit) {
      connectivityService.connectivityStream.stream.listen((status) {
        emit(status == ConnectivityResult.none
            ? AlbumError(error: 'No Internet Connection')
            : AlbumInitial());
      });
    });
    on<FetchAlbumList>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albumsList = await repository.getAlbums();
        print(albumsList);
        emit(AlbumLoaded(albums: albumsList));
      } catch (e) {
        emit(AlbumError(error: e.toString()));
      }
    });
  }
}
