import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';

class CreateCategory extends StatelessWidget {
  final String categoryImage;
  final String categoryName;
  final bool isSelected;
  const CreateCategory({super.key, required this.categoryImage, required this.categoryName, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: 110,
      color: Colors.white54,
      child: Center(
        child: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            gradient: isSelected? Palette.btnGradientColorLight : Palette.btnGradientColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(categoryName,
                  style: TextStyle(
                    fontFamily: Palette.layoutFont,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isSelected? Palette.bgColorPerple : Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}