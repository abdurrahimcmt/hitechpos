import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';

class PrinterSettingScreenOLD extends StatefulWidget {
  const PrinterSettingScreenOLD({super.key});

  @override
  State<PrinterSettingScreenOLD> createState() => _PrinterSettingScreenOLDState();
}

class _PrinterSettingScreenOLDState extends State<PrinterSettingScreenOLD> {
  _commonTitleStyle(){
    return const TextStyle(
      fontFamily: Palette.layoutFont,
      color: Palette.textColorLightPurple,
      fontWeight: FontWeight.w500,
      fontSize: Palette.contentTitleFontSizeL,
    );
  }
  List<String> printerNames= <String>[
    'microsoftXPS',
    'microsoftPrint',
    'oneNote'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double spaceSizeBoxHeight = 20.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Palette.bgColorPerple,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            gradient: Palette.bgGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Save Invoice(s)",
                //     style: _commonTitleStyle(),
                // ),
                // SizedBox(
                //   height: spaceSizeBoxHeight,
                // ),
                Row(
                  children: [
                    Text("Kitchen Copy:",
                        style: _commonTitleStyle(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                     SizedBox(
                      width: 100,
                      child: const TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "0",
                          prefixIcon: Icon(
                            Icons.tag,
                            color: Color.fromARGB(106, 113, 15, 131),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Invoice Copy:",
                        style: _commonTitleStyle(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                     const SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "0",
                          prefixIcon: Icon(
                            Icons.tag,
                            color: Color.fromARGB(106, 113, 15, 131),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                  height: spaceSizeBoxHeight,
                ),
                const Divider(
                  height: 1.0,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: spaceSizeBoxHeight,
                ),
                Text("Default Printers(s)",
                    style: _commonTitleStyle(),
                ),
                SizedBox(
                  height: spaceSizeBoxHeight,
                ),
                //Kitchen Print
                Row(
                  children: [
                    Text("Kitchen:",
                        style: _commonTitleStyle(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Autocomplete <String>(
                      optionsBuilder: (TextEditingValue textEditingValue){
                      if(textEditingValue.text == ''){
                        return const Iterable<String>.empty();
                      }
                      return printerNames.where((String printer){
                        return printer.contains(textEditingValue.text.toLowerCase());
                      });
                      },
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onFieldSubmitted,
                          decoration: const InputDecoration(
                            hintText: "Select Default Kitchen Printer",
                            prefixIcon: Icon(
                              Icons.print,
                              color: Color.fromARGB(106, 113, 15, 131),
                            ),
                          ),
                        );
                      },
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(onPressed: () {
                    }, 
                    child: Container(
                      width: 50,
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
                      child: const Center(
                        child: Text("Test",
                              style: TextStyle(
                              fontFamily: Palette.layoutFont,
                              fontWeight: Palette.btnFontWeight,
                              fontSize: Palette.containerButtonFontSize,
                              color: Palette.btnTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  
                  ],
                ),

                //invoice print
                  Row(
                  children: [
                    Text("Invoice:",
                        style: _commonTitleStyle(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Autocomplete <String>(
                      optionsBuilder: (TextEditingValue textEditingValue){
                      if(textEditingValue.text == ''){
                        return const Iterable<String>.empty();
                      }
                      return printerNames.where((String printer){
                        return printer.contains(textEditingValue.text.toLowerCase());
                      });
                      },
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onFieldSubmitted,
                          decoration: const InputDecoration(
                            hintText: "Select Default Invoice Printer",
                            prefixIcon: Icon(
                              Icons.print,
                              color: Color.fromARGB(106, 113, 15, 131),
                            ),
                          ),
                        );
                      },
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(onPressed: () {
                    }, 
                    child: Container(
                      width: 50,
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
                      child: const Center(
                        child: Text("Test",
                              style: TextStyle(
                              fontFamily: Palette.layoutFont,
                              fontWeight: Palette.btnFontWeight,
                              fontSize: Palette.containerButtonFontSize,
                              color: Palette.btnTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: spaceSizeBoxHeight,
                ),
                const Center(child: CommonSubmitButton(title: "Set")),
              ],
              
            ),
          ),
        ),
      ),
    );
  }
}