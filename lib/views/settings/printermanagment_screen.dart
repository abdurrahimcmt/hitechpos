import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/views/settings/printersetting_screen.dart';

class PrinterManagemntScreen extends StatefulWidget {
  const PrinterManagemntScreen({super.key});

  @override
  State<PrinterManagemntScreen> createState() => _PrinterManagemntScreenState();
}

class _PrinterManagemntScreenState extends State<PrinterManagemntScreen> {
  List<String> printerList = ["Printer 1","Printer 2","Printer 3","Printer 4","Printer 5","Printer 6",];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Palette.bgColorPerple,
        centerTitle: true,
        title: const Text(
          "Printers Management",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
          gradient: Palette.bgGradient
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    const Text("Printers",
                    style: TextStyle(
                      fontFamily: Palette.layoutFont,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Palette.textColorPurple
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      Get.to(const PrinterSettingScreen());
                    },
                   icon: const Icon(Icons.add_circle_outline,size: 40,color: Palette.bgColorPerple),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: printerList.length,
                  itemBuilder: ( BuildContext context, index) {
                    return SizedBox(
                      height: 80,
                      child: Card(
                        color: Colors.purple[50],
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(printerList[index],
                                  style: const TextStyle(
                                    fontFamily: Palette.layoutFont,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Palette.contentTitleFontSizeL,
                                    color: Palette.textColorPurple,
                                  ),
                                ),
                              ),
                              //Edit Button
                              TextButton(
                                onPressed: (){
                                  Get.to(const PrinterSettingScreen());
                                }, 
                                child: Container(
                                  height: 50,
                                  width: 40,
                                  decoration:  const BoxDecoration(
                                    gradient: Palette.btnGradientColor,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Palette.btnBoxShadowColor,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(0,1),
                                      )
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                              //Delete Button
                              TextButton(
                                onPressed: (){
                                  setState(() {
                                    showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: const Icon(
                                            Icons.info,
                                            size: 40,
                                            color: Palette.iconBackgroundColorPurple,
                                          ),
                                          content: const Text("Are you want to delete printer?",
                                            style: TextStyle(
                                              color: Palette.textColorPurple,
                                              fontFamily: Palette.layoutFont,
                                              fontWeight: FontWeight.w700
                                            ),
                                            textAlign: TextAlign.center,

                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      printerList.remove(printerList[index]);
                                                      Navigator.of(context).pop();
                                                    }
                                                  );
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 70,
                                                  decoration:  const BoxDecoration(
                                                    gradient: Palette.btnGradientColor,
                                                    borderRadius: BorderRadius.all(Radius.circular(25)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Palette.btnBoxShadowColor,
                                                        spreadRadius: 2,
                                                        blurRadius: 2,
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                  ),
                                                  child: const Center(
                                                    child: Text("Yes",
                                                          style: TextStyle(
                                                          fontFamily: Palette.layoutFont,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: Palette.containerButtonFontSize,
                                                          color: Palette.btnTextColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                  height: 35,
                                                  width: 70,
                                                  decoration:  const BoxDecoration(
                                                    gradient: Palette.btnGradientColor,
                                                    borderRadius: BorderRadius.all(Radius.circular(25)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Palette.btnBoxShadowColor,
                                                        spreadRadius: 2,
                                                        blurRadius: 2,
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                  ),
                                                  child: const Center(
                                                    child: Text("No",
                                                          style: TextStyle(
                                                          fontFamily: Palette.layoutFont,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: Palette.containerButtonFontSize,
                                                          color: Palette.btnTextColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  });
                                }, 
                                child: Container(
                                  height: 50,
                                  width: 40,
                                  decoration:  const BoxDecoration(
                                    gradient: Palette.btnGradientColor,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Palette.btnBoxShadowColor,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(0,1),
                                      )
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}