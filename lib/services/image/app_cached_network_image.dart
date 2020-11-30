
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../style/color.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String imageURL;
  final BoxFit fit;
  final Color color;
  AppCachedNetworkImage({
    this.imageURL,
    this.fit,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: color == null ? null : color,
          image: DecorationImage(
            image: imageProvider,
            fit: fit == null ? BoxFit.fill : fit,
          ),
        ),
      ),
      placeholder: (context, url) => const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: const CircularProgressIndicator(
            backgroundColor: AppColor.BLACK,
          ),
        ),
        //width: 10,
        //height: 10,
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        color: Colors.red,
      ),
      width: 50,
      height: 50,
    );
  }
}
