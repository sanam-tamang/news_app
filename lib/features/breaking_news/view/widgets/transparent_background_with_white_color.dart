import 'package:flutter/material.dart';

class TransparentWhiteBackgroundWithTextWidget extends StatelessWidget {
  const TransparentWhiteBackgroundWithTextWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          color: Colors.grey.shade100.withOpacity(0.3),
          borderRadius: BorderRadius.circular(50)),
      child: child,
    );
  }
}
