import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
class CurbButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets buttonPadding;
  const CurbButton({Key ? key,required this.child, required this.buttonPadding}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: buttonPadding,
      child: Container(
          width: size.width,
          height: 50,
          decoration:  const BoxDecoration(
            gradient: Palette.btnGradientColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Palette.btnBoxShadowColor,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: child,
      ),
    );
  }
}

