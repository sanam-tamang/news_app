// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/news_loading_progress_indicator.dart';

class NewsCachedNetworkImage extends StatelessWidget {
  const NewsCachedNetworkImage(
      {Key? key, required this.image, this.fit = BoxFit.cover})
      : super(key: key);
  final String? image;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return image != null
        ? CachedNetworkImage(
            imageUrl: image!,
            fit: fit,
            placeholder: (context, url) {
              return const Center(child: NewsLoadingProgressIndicator());
            },
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
          )
        : Center(
            child: Container(
                color: Colors.grey.shade200,
                child: const Text("image not found ):")));
  }
}
