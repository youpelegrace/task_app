import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:testing_app/bloc/photos_bloc.dart/photo_event.dart';
import 'package:testing_app/bloc/photos_bloc.dart/photo_state.dart';
import 'package:testing_app/core/services/album_services.dart';
import 'package:testing_app/core/services/connectivity_service.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  Repository repository;
  ConnectivityService connectivityService;
  PhotosBloc({required this.repository, required this.connectivityService})
      : super(PhotosInitial()) {
    on<CheckInternet>((event, emit) {
      connectivityService.connectivityStream.stream.listen((status) {
        emit(status == ConnectivityResult.none
            ? PhotosError(error: 'No Internet Connection')
            : PhotosInitial());
      });
    });
    on<FetchPhotos>((event, emit) async {
      emit(PhotosLoading());
      await repository.getPhotos(event.albumId).then((photos) {
        emit(PhotosLoaded(photos: photos));
      }).catchError((e) {
        emit(PhotosError(error: e.toString()));
      });
    });
  }
}
