import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';
import 'package:intl/intl.dart';

class OrderFilterScreen extends StatefulWidget {
  const OrderFilterScreen({super.key});

  @override
  State<OrderFilterScreen> createState() => _OrderFilterScreenState();
}

class _OrderFilterScreenState extends State<OrderFilterScreen> {

  bool isSelectedOrderType = false;
  List<String> listOfDate = ["Today","Yesterday","Last Week"];
  List<String> listOfStatus = ["Pending","Settled"];
  List<String> isSelectedDate = [];
  List<int> selectedOrderType = [];
  List<String> selectedStatus = [];
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  @override
  void initState() {
    isSelectedDate = [];
    selectedOrderType = [];
    selectedStatus = [];
    fromDate.text = "";
    toDate.text = "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Container(
      decoration: Palette.containerCurbBoxdecoration,
      height: MediaQuery.of(context).size.height*0.80,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Filter Order",
                style: TextStyle(
                  fontFamily: Palette.layoutFont,
                  fontSize: Palette.sheetTitleFontsize,
                  fontWeight: FontWeight.w700
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //OrderType
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Order Type:",
                    style: TextStyle(
                      fontFamily: Palette.layoutFont,
                      fontSize: Palette.contentTitleFontSizeL,
                      fontWeight: FontWeight.w700,
                      color: Palette.textColorPurple
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(orderTypes.length, (index) {
                    return TextButton(
                        onPressed: (){
                          setState(() {
                            // _buildModelBottomSheet(orderTypes[index].name);
                            if(!selectedOrderType.contains(index)){
                              selectedOrderType.add(index) ;
                            }
                            else{
                              selectedOrderType.remove(index) ;
                            }
                          });
                        }, 
                        child: Container(
                          width: size.width < 800 ? size.width * 0.18 : size.width * 0.20,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: selectedOrderType.contains(index)? Palette.btnGradientColor : Palette.bgGradient,
                            borderRadius: Palette.textContainerBorderRadius,
                            border: Border.all(
                              color: Palette.btnBoxShadowColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image(image: AssetImage(orderTypes[index].imageUrl),
                              // height: 50,
                              // fit: BoxFit.cover,),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: FittedBox(
                                  child: Text(orderTypes[index].name,
                                        style: TextStyle(
                                          fontFamily: Palette.layoutFont,
                                          fontSize: Palette.containerButtonFontSize,
                                          fontWeight: FontWeight.bold,
                                          color: selectedOrderType.contains(index)? Colors.white: Palette.textColorLightPurple,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          ),
                        );
                      }
                    ),
                  ),

                ],
              ),
              //Date
              const SizedBox(
                height: 15,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Text("Date:",
              //       style: TextStyle(
              //         fontFamily: Palette.layoutFont,
              //         fontSize: Palette.contentTitleFontSizeL,
              //         fontWeight: FontWeight.w700,
              //         color: Palette.textColorPurple
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: List.generate(listOfDate.length, (index) {
              //       return TextButton(
              //           onPressed: (){
              //             setState(() {
              //               if(!isSelectedDate.contains(listOfDate[index])){
              //                 isSelectedDate.add(listOfDate[index]) ;
              //               }
              //               else{
              //                 isSelectedDate.remove(listOfDate[index]);
              //               }
              //             });
              //           }, 
              //           child: Container(
              //             width: size.width < 800 ? size.width * 0.25 : size.width * 0.27,
              //             height: 40,
              //             decoration: BoxDecoration(
              //               gradient: isSelectedDate.contains(listOfDate[index])? Palette.btnGradientColor : Palette.bgGradient,
              //               borderRadius: Palette.textContainerBorderRadius,
              //               border: Border.all(
              //                 color: Palette.btnBoxShadowColor,
              //                 width: 2,
              //               ),
              //             ),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 // Image(image: AssetImage(orderTypes[index].imageUrl),
              //                 // height: 50,
              //                 // fit: BoxFit.cover,),
              //                 Padding(
              //                   padding: const EdgeInsets.all(5.0),
              //                   child: FittedBox(
              //                     child: Text(listOfDate[index],
              //                           style: TextStyle(
              //                             fontFamily: Palette.layoutFont,
              //                             fontSize: Palette.containerButtonFontSize,
              //                             fontWeight: FontWeight.bold,
              //                             color: isSelectedDate.contains(listOfDate[index])? Colors.white: Palette.textColorLightPurple,
              //                           ),
              //                           textAlign: TextAlign.center,
              //                         ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             ),
              //           );
              //         }
              //       ),
              //     ),
              //   ],
              // ),

              //Date Between
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Date :",
                    style: TextStyle(
                      fontFamily: Palette.layoutFont,
                      fontSize: Palette.contentTitleFontSizeL,
                      fontWeight: FontWeight.w700,
                      color: Palette.textColorPurple
                    ),
                  ),
               
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: TextField(
                          controller: fromDate,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.calendar_today,color: Palette.iconBackgroundColorPurple,),
                            labelText: "From Date",
                            floatingLabelStyle: const TextStyle(
                              color: Palette.textColorLightPurple,
                            ),
                            border: InputBorder.none,
                            suffix: IconButton(onPressed: (){fromDate.text = "";}, icon: const Icon(Icons.clear,size: 15,))
                          ),
                          
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedFromDate = await showDatePicker(
                              context: context,
                               initialDate: DateTime.now(), 
                               firstDate: DateTime(1950), 
                               lastDate: DateTime(2100)
                            );
                            if(pickedFromDate !=null){
                              String formattedFromDate = DateFormat('dd-MM-yyyy').format(pickedFromDate);
                              setState(() {
                                fromDate.text = formattedFromDate;
                              });
                            }
                            else{
                              
                            }
                          },
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          controller: toDate,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.calendar_today,color: Palette.iconBackgroundColorPurple,),
                            labelText: "To Date",
                            floatingLabelStyle: const TextStyle(
                              color: Palette.textColorLightPurple,
                            ),
                            border: InputBorder.none,
                            suffix: IconButton(onPressed: (){toDate.text = "";}, icon: const Icon(Icons.clear,size: 15,))
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedToDate = await showDatePicker(
                              context: context,
                               initialDate: DateTime.now(), 
                               firstDate: DateTime(1950), 
                               lastDate: DateTime(2100)
                            );
                            if(pickedToDate !=null){
                              String formattedToDate = DateFormat('dd-MM-yyyy').format(pickedToDate);
                              setState(() {
                                toDate.text = formattedToDate;
                              });
                            }
                            else{
                              
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //Status
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Status:",
                    style: TextStyle(
                      fontFamily: Palette.layoutFont,
                      fontSize: Palette.contentTitleFontSizeL,
                      fontWeight: FontWeight.w700,
                      color: Palette.textColorPurple
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(listOfStatus.length, (index) {
                    return TextButton(
                        onPressed: (){
                          setState(() {
                            // _buildModelBottomSheet(orderTypes[index].name);
                            if(!selectedStatus.contains(listOfStatus[index])){
                              selectedStatus.add(listOfStatus[index]) ;
                            }
                            else{
                              selectedStatus.remove(listOfStatus[index]) ;
                            }
                          });
                        }, 
                        child: Container(
                          width: size.width < 800 ? size.width * 0.40 : size.width * 0.45,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: selectedStatus.contains(listOfStatus[index])? Palette.btnGradientColor : Palette.bgGradient,
                            borderRadius: Palette.textContainerBorderRadius,
                            border: Border.all(
                              color: Palette.btnBoxShadowColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image(image: AssetImage(orderTypes[index].imageUrl),
                              // height: 50,
                              // fit: BoxFit.cover,),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: FittedBox(
                                  child: Text(listOfStatus[index],
                                        style: TextStyle(
                                          fontFamily: Palette.layoutFont,
                                          fontSize: Palette.containerButtonFontSize,
                                          fontWeight: FontWeight.bold,
                                          color: selectedStatus.contains(listOfStatus[index])? Colors.white: Palette.textColorLightPurple,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          ),
                        );
                      }
                    ),
                  ),

                ],
              ),
              //Apply Button
              const SizedBox(
                height: 20,
              ),
              const CommonSubmitButton(title: "APPLY"),
            ],
          ),
        ),
      ),
    );
  }
}