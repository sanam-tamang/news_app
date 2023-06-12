import 'package:flutter/material.dart';

import 'news_cached_network_image.dart';

class NewsImageShaderMask extends StatelessWidget {
  const NewsImageShaderMask({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.black.withOpacity(0.4),
        ],
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: NewsCachedNetworkImage(image: imageUrl),
    );
  }
}
