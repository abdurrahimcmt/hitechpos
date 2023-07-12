import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
class CommonSubmitButton extends StatelessWidget {
  final String title;
  const CommonSubmitButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      Get.back();
    },
    child: Container(
      width: MediaQuery.of(context).size.width*0.4,
      height: 50,
      decoration:  const BoxDecoration(
        gradient: Palette.btnGradientColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Palette.btnBoxShadowColor,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Center(
        child: Text(title,
              style: const TextStyle(
              fontFamily: Palette.layoutFont,
              fontWeight: Palette.btnFontWeight,
              fontSize: Palette.btnFontsize,
              color: Palette.btnTextColor,
            ),
          ),
        ),
      ),
    );
  }
}