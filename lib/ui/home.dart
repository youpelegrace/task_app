import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_app/bloc/album_bloc.dart/album_bloc.dart';
import 'package:testing_app/bloc/photos_bloc.dart/photo_bloc.dart';
import 'package:testing_app/bloc/photos_bloc.dart/photo_event.dart';
import 'package:testing_app/bloc/photos_bloc.dart/photo_state.dart';
import 'package:testing_app/core/services/album_services.dart';
import 'package:testing_app/core/services/connectivity_service.dart';
import 'package:testing_app/error.dart';
import 'package:testing_app/model/album_res.dart';
import 'package:testing_app/model/photo_res.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AlbumRes> albumList = [];
  List<PhotoRes> photoList = [];
  bool _albumError = false;
  bool _isLoading = false;
  bool _isPhotoLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Practical Task"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => AlbumBloc(
            repository: Repository(),
            connectivityService: ConnectivityService())
          ..add(
              FetchAlbumList()), // call the bloc to fetch the albums on init of the [AlbumBloc]
        child: BlocListener<AlbumBloc, AlbumState>(
          listener: (context, state) {
            if (state is AlbumLoading) {
              setState(() {
                _isLoading = true;
              });
            } else if (state is AlbumLoaded) {
              setState(() {
                _isLoading = false;
                albumList = state.albums;
              });
            } else if (state is AlbumError) {
              setState(() {
                _isLoading = false;
                _albumError = true;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
            child: _albumError
                ? Center(
                    child: ErrorClass(
                      isAlbumError: true,
                      errorText: 'Error fetching albums',
                      onRetry: () {
                        setState(() {
                          _albumError = false;
                        });
                        BlocProvider.of<AlbumBloc>(context)
                            .add(FetchAlbumList());
                      },
                    ),
                  )
                : SizedBox(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CarouselSlider.builder(
                            itemCount: albumList.take(4).length,
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              final album = albumList[index];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(album.title.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 20),
                                  BlocProvider(
                                    create: (context) => PhotosBloc(
                                        repository: Repository(),
                                        connectivityService:
                                            ConnectivityService())
                                      ..add(
                                        FetchPhotos(albumId: album.id!),
                                      ), // call the bloc to fetch the photos using albumId on init of the [PhotoBloc]
                                    child:
                                        BlocListener<PhotosBloc, PhotosState>(
                                      listener: (context, state) {
                                        if (state is PhotosLoading) {
                                          setState(() {
                                            _isPhotoLoading = true;
                                          });
                                        } else if (state is PhotosLoaded) {
                                          setState(() {
                                            _isPhotoLoading = false;
                                            photoList = state.photos;
                                          });
                                        } else if (state is PhotosError) {
                                          setState(() {
                                            _isPhotoLoading = false;
                                          });
                                          // print(state.error);
                                        }
                                      },
                                      child: SizedBox(
                                        height: 100,
                                        width: double.infinity,
                                        child: _isPhotoLoading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : CarouselSlider.builder(
                                                itemCount:
                                                    photoList.take(3).length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index,
                                                        int realIndex) {
                                                  final photo =
                                                      photoList[index];
                                                  return CachedNetworkImage(
                                                    imageUrl:
                                                        photo.thumbnailUrl!,
                                                    placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Image(
                                                      image: AssetImage(
                                                          'assets/images/No_Image_Available.jpeg'),
                                                    ),
                                                    fit: BoxFit.cover,
                                                    width: 100.0,
                                                    height: 100.0,
                                                  );
                                                },
                                                options: CarouselOptions(
                                                  height: 100.0,
                                                  enlargeCenterPage: false,
                                                  autoPlay: false,
                                                  aspectRatio: 2.0,
                                                  enableInfiniteScroll: true,
                                                  viewportFraction: 0.33,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    height: 40,
                                  ),
                                ],
                              );
                            },
                            options: CarouselOptions(
                              height: double.infinity,
                              disableCenter: true,
                              scrollDirection: Axis.vertical,
                              enlargeCenterPage: false,
                              viewportFraction: 0.33,
                              initialPage: 4,
                              autoPlay: false,
                              onPageChanged: (index, reason) {},
                            ),
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}
