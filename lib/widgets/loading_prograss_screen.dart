import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hitechpos/common/palette.dart';

class LoadingPrograssScreen extends StatelessWidget {
  const LoadingPrograssScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Center(
        child: SpinKitCircle(
          size: 140,
          color: Colors.white,
        ),
      ),
    );
  }
}
