// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/core/widgets/news_loading_progress_indicator.dart';

import 'image_null_placeholder.dart';

class NewsCachedNetworkImage extends StatelessWidget {
  const NewsCachedNetworkImage(
      {Key? key, required this.image, this.fit = BoxFit.cover})
      : super(key: key);
  final String? image;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return FutureBuilder(
        future: getImgUrl(image!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool error = snapshot.data == null;

            return error
                ? Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.cover,
                  )
                : FadeInImage(
                    fit: fit,
                    imageErrorBuilder:
                        (BuildContext context, Object exception, stackTrace) {
                      return const ImageNullPlaceholder();
                    },
                    placeholder: const AssetImage(
                      'assets/images/pulse_animation.gif',
                    ),
                    image: CachedNetworkImageProvider(image!));
          } else {
            return const ImageNullPlaceholder();
          }
        },
      );
    }
    return const ImageNullPlaceholder();
  }
}

Future<String?> getImgUrl(String imageUrl) async {
//Storage structre: avatars/+919999999999/avatar.jpg
//Permanent url of an image without tokens
//%2F means "/"
//%2B mans "+"

  try {
    (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
        .buffer
        .asUint8List();
    print("The image exists!");
    return imageUrl;
  } catch (e) {
    print("Error: $e");
    return null;
  }
}
