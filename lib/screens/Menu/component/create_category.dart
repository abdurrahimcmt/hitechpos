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
      onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MenuScreen(),
            ),
          ),
      child: Container(
        height: 120,
        width: 120,
        color: Colors.white54,
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            decoration:  const BoxDecoration(
              gradient: Palette.btnGradientColor,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(categoryImage,height: 30,width: 30,),
                Text(categoryName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}