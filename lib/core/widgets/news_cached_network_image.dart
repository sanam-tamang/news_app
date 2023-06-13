

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


import '../utils/get_image.dart';
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
