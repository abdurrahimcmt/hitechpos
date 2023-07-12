import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';
class DineInScreen extends StatefulWidget {
  const DineInScreen({super.key});

  @override
  State<DineInScreen> createState() => _DineInScreenState();
}

class _DineInScreenState extends State<DineInScreen> {
  List<String> isSelectedTabels = selectedTables;
  String newSelectedTable = "";
  int selectcount = 0;
  @override
  Widget build(BuildContext context) {
    
    return Container(
            decoration: Palette.containerCurbBoxdecoration,
            height: MediaQuery.of(context).size.height*0.80,
            child:  Padding(
              padding: EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text("Dine In",
                      style: TextStyle(
                        fontFamily: Palette.layoutFont,
                        fontSize: Palette.sheetTitleFontsize,
                      ),
                    ),
                    Palette.sizeBoxVarticalSpace,
                    //Floor Work Start

                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: floors.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TextButton(
                            onPressed:() {},
                            child: Center(
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration:  const BoxDecoration(
                                  gradient: Palette.btnGradientColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(floors[index],
                                        style: const TextStyle(
                                          fontFamily: Palette.layoutFont,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    //Table Work Start
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                          alignment: WrapAlignment.center,
                          direction: Axis.horizontal,
                          spacing: 0,
                          runSpacing: 2,
                          children: List.generate(tables.length, (index) {
                              return TextButton(
                                onPressed: isSelectedTabels.contains(tables[index])  ? null :
                                (){
                                  setState(() {
                                    newSelectedTable = tables[index];
                                    // if(!isSelectedTabels.contains(tables[index])){
                                    //   isSelectedTabels.add(tables[index]);
                                    //   selectcount++;
                                    // }
                                    // else{
                                    //   isSelectedTabels.remove(tables[index]);
                                    //   selectcount--;
                                    // }
                                  });
                                } ,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelectedTabels.contains(tables[index]) || newSelectedTable == tables[index] ? Colors.red : Colors.white,
                                    borderRadius:const BorderRadius.all(Radius.circular(10)),
                                    boxShadow: const [
                                      BoxShadow(
                                      color: Palette.btnBoxShadowColor,
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                      offset: Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  height: 70,
                                  width: 70,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(tables[index],
                                        style: TextStyle(
                                          color: isSelectedTabels.contains(tables[index]) || newSelectedTable == tables[index]  ? Colors.white :Palette.textColorPurple,
                                          fontFamily: Palette.layoutFont,
                                          fontSize: Palette.containerButtonFontSize,
                                        ),
                                      ),
                                      if(isSelectedTabels.contains(tables[index]) || newSelectedTable == tables[index]) 
                                      Text("Order No : 5",
                                        style: TextStyle(
                                          color: isSelectedTabels.contains(tables[index]) || newSelectedTable == tables[index]  ? Colors.white :Palette.textColorPurple,
                                          fontFamily: Palette.layoutFont,
                                          fontSize: Palette.containerButtonFontSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ), 
                              );
                            }
                          ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    const CommonSubmitButton(title: "Submit"),
                  ],
                ),
              ),
            ),
          );
        
  }
}