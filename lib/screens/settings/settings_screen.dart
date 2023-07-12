import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/screens/settings/printermanagment_screen.dart';
import 'package:hitechpos/screens/settings/printersetting_screen.dart';
import 'package:hitechpos/widgets/dashboardbutton.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.bgColorPerple,
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
          gradient: Palette.bgGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                  height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const PrinterManagemntScreen());
                      },
                      child: const DashBoardButton(title: "Printer Settings", buttonIcon: Icons.print
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  const Expanded(
                    flex: 6,
                    child: SizedBox(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}