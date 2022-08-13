import 'package:flutter/material.dart';

class ErrorClass extends StatelessWidget {
  ErrorClass(
      {Key? key,
      required this.errorText,
      required this.onRetry,
      required this.isAlbumError})
      : super(key: key);

  bool isAlbumError;
  String errorText;
  Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onRetry(),
      child: SizedBox(
        width: double.infinity,
        height: isAlbumError ? 400.0 : 200,
        child: Center(
          child: Text(errorText),
        ),
      ),
    );
  }
}
