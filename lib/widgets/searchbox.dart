import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical:15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0.5),
        ),
        prefixIcon: const Icon(
          Icons.search,
        ),
        suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
            Icons.clear,
          ),
        ),
        hintText: "Search here",
        filled: true,
        fillColor: Color.fromARGB(255, 237, 227, 238),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 1.0,
            color: Palette.iconBackgroundColorPurple,
          ),
        ),
      ),
    );
  }
}