import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/dini_in_controller.dart';
import 'package:hitechpos/models/floorandtableinfo.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';
class DineInScreen extends GetView<DiniInController> {
  const DineInScreen({super.key});

 // List<String> isSelectedTabels = selectedTables;

 // String newSelectedTable = "";

  //int selectcount = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
            decoration: Palette.containerCurbBoxdecoration,
            height: size.height*0.80,
            child:  Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Text("Dine In",
                    style: TextStyle(
                      fontFamily: Palette.layoutFont,
                      fontSize: Palette.sheetTitleFontsize,
                    ),
                  ),
                //Floor Work Start
                FutureBuilder<FloorAndTableInfo>(
                  future: controller.floorInfoList,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.onlineFloorTableList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TextButton(
                              onPressed:() {
                                 controller.fatchTableInfo(snapshot.data!.onlineFloorTableList[index].iFloorId);
                              },
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
                                      Text(snapshot.data!.onlineFloorTableList[index].vFloorName,
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
                      );
                    }
                    else if(snapshot.hasError){
                       return SnackBar( content: Text("${snapshot.error}"),);
                    }
                    else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                Palette.sizeBoxVarticalSpace,
                  //Table Work Start
                  SizedBox(
                    height: isPortrait ? size.height*0.55 : size.height*0.30,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Obx( () {
                          final tableinfo = controller.tableList.value;
                          if(controller.isTableInfoLoding.value){
                            return const Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                ),
                                CircularProgressIndicator(),
                              ],
                            );
                          }
                          else{
                            if(tableinfo.onlineFloorTableList.isNotEmpty){
                              return Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                  alignment: WrapAlignment.center,
                                  direction: Axis.horizontal,
                                  spacing: 0,
                                  runSpacing: 2,
                                  children: List.generate(tableinfo.onlineFloorTableList.first.onlineTableList.length, (index) {
                                    String tableName= tableinfo.onlineFloorTableList.first.onlineTableList[index].vTableName;
                                    String invoiceNo = tableinfo.onlineFloorTableList.first.onlineTableList[index].vInvoiceNo; 
                                      if(invoiceNo.isNotEmpty){
                                         controller.isSelectedTabels.add(tableName);
                                      }
                                      return TextButton(
                                        onPressed: controller.isSelectedTabels.contains(tableName)  ? null :
                                        
                                        (){
                                          controller.newSelectedTable.value = tableName;
                                            // if(!controller.isSelectedTabels.contains(tableName)){
                                            //    controller.isSelectedTabels.add(tableName);
                                            //   controller.selectcount ++;
                                            //  }
                                            //  else{
                                            //    controller.isSelectedTabels.remove(tableName);
                                            //    controller.selectcount--;
                                            //  }
                                          // setState(() {
                                          //   newSelectedTable = tables[index];
                                            // if(!isSelectedTabels.contains(tables[index])){
                                            //    isSelectedTabels.add(tables[index]);
                                            //    selectcount++;
                                            //  }
                                            //  else{
                                            //    isSelectedTabels.remove(tables[index]);
                                            //    selectcount--;
                                            //  }
                                          // });
                                        } ,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: controller.isSelectedTabels.contains(tableName) || controller.newSelectedTable.value == tableName ? Colors.red : Colors.white,
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
                                              Text(tableName,
                                                style: TextStyle(
                                                  color: controller.isSelectedTabels.contains(tableName) || controller.newSelectedTable.value == tableName  ? Colors.white :Palette.textColorPurple,
                                                  fontFamily: Palette.layoutFont,
                                                  fontSize: Palette.containerButtonFontSize,
                                                ),
                                              ),
                                              if(controller.isSelectedTabels.contains(tableName) || controller.newSelectedTable.value == tableName) 
                                              Text(invoiceNo,
                                                style: TextStyle(
                                                  color: controller.isSelectedTabels.contains(tableName) || controller.newSelectedTable.value == tableName  ? Colors.white :Palette.textColorPurple,
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
                            );
                            }
                            else{
                              return const SizedBox(
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Sorry, no table found",
                                      style: TextStyle(
                                        fontFamily: Palette.layoutFont,
                                        fontSize: Palette.contentTitleFontSizeL,
                                        fontWeight: FontWeight.w700,
                                        color: Palette.textColorLightPurple,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        }
                        ),
                      ),
                    ),
                  ),
                  const CommonSubmitButton(title: "Submit"),
              ],
              ),
            ),
          );
        
  }
}
