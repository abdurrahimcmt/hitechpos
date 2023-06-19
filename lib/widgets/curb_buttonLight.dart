import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';

class CurbButtonLight extends StatelessWidget {
  final Widget child;
  final EdgeInsets buttonPadding;
  const CurbButtonLight({super.key, required this.child, required this.buttonPadding});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: buttonPadding,
      child: Container(
          decoration: const BoxDecoration(
          gradient: Palette.btnGradientColorLight,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          width: size.width,
          height: 60,
          padding: const EdgeInsets.only(
            top: 15.0,
            bottom: 15.0,
          ),
          child: child,
      ),
    );
  }
}