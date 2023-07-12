import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
class DashBoardButton extends StatelessWidget {
  final String title;
  final IconData buttonIcon;
  const DashBoardButton({super.key, required this.title, required this.buttonIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
        decoration: BoxDecoration(
          gradient: Palette.bgGradient,
          borderRadius: Palette.textContainerBorderRadius,
          border: Border.all(
            color: Palette.btnBoxShadowColor,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(buttonIcon,size: 70,color: Palette.iconBackgroundColorPurple,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text(title,
                      style: const TextStyle(
                        fontFamily: Palette.layoutFont,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color:Palette.textColorPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
              ),
            ),
          ],
        ),
      );
  }
}