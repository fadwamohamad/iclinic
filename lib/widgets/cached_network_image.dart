import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget CustomNetworkImage(
    {required String image,
    required double height,
    required double width,
    required BoxFit fit,
    Color? color}) {
  print("imafe $image");
  if (image.startsWith("http://") ||
      image.startsWith("https://") ||
      image.isEmpty) {
    return CachedNetworkImage(
      imageUrl: image,
      fit: fit,
      progressIndicatorBuilder: (context, url, progress) => Container(
        alignment: AlignmentDirectional.center,
        height: height / 1.5,
        width: width / 1.5,
        child: Image.asset(
          'assets/images/image.png',
          fit: BoxFit.contain,
          //color: color ?? MyColors.mainColor,
          height: height / 1.5,
          width: width / 1.5,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        alignment: AlignmentDirectional.center,
        height: height / 1.5,
        width: width / 1.5,
        child: Image.asset(
          'assets/images/image.png',
          //color: color ?? MyColors.mainColor,
          fit: BoxFit.contain,
          width: width / 1.5,
          height: height / 1.5,
        ),
      ),
      height: height,
      width: width,
      color: color,
    );
  } else {
    return Image.file(
      File(image),
      fit: fit,
      width: width,
      height: height,
      color: color,
    );
  }
}
