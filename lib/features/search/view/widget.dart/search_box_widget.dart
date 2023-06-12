// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    Key? key,
    this.controller,
    this.absorbPointer = true,
    this.onSubmit,
  }) : super(key: key);
  final TextEditingController? controller;
  final bool absorbPointer;
  final Function(String query)? onSubmit;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.grey.shade200),
      child: AbsorbPointer(
        absorbing: absorbPointer,
        child: TextField(
          controller: controller,
          onSubmitted: (query) {
            onSubmit!(query);
          },
          decoration: const InputDecoration(
            hintText: 'Search',
            prefixIcon: Padding(
              padding: EdgeInsets.only(top: 6, left: 10, right: 10),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
