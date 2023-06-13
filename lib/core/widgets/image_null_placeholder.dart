import 'package:flutter/material.dart';

class ImageNullPlaceholder extends StatelessWidget {
  const ImageNullPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
   
      return Image.asset(
        'assets/images/placeholder.png',
        fit: BoxFit.cover,
      );
    
  }
}