import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/screens/menu/menu_screen.dart';


class CreateCategory extends StatelessWidget {
  final String categoryImage;
  final String categoryName;
  const CreateCategory({super.key, required this.categoryImage, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {},
      child: Container(
        width: 110,
        color: Colors.white54,
        child: Center(
          child: Container(
            width: 100,
            height: 50,
            decoration:  const BoxDecoration(
              gradient: Palette.btnGradientColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(categoryName,
                    style: const TextStyle(
                      fontFamily: Palette.layoutFont,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}