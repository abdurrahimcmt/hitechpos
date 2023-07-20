import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/views/menu/component/dine_in.dart';
import 'package:hitechpos/views/proceedorder/ordersuccessful.dart';
import 'package:hitechpos/widgets/curb_button.dart';
class ProceedScreen extends StatefulWidget {
  const ProceedScreen({super.key});

  @override
  State<ProceedScreen> createState() => _ProceedScreenState();
}

class _ProceedScreenState extends State<ProceedScreen> {
  int selectedOrderType = 0;
  List<String> customerNames= <String>[
    'Ali',
    'Ahmed',
    'Kumar',
    'Hassan',
    'Khan',
    'Hussain',
    'Mohamed',
    'Abdulla',
    'Yousif',
    'Ebrahim',
    'Janahi',
    'Salman',
    'Nair',
    'Saleh',
    'Mahmood',
    'Mathew'
  ];
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Proceed"),
        backgroundColor: Palette.bgColorPerple,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: const BoxDecoration(
            gradient: Palette.bgGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(orderTypes.length, (index) {
                      return TextButton(
                          onPressed: (){
                            setState(() {
                             // _buildModelBottomSheet(orderTypes[index].name);
                              selectedOrderType = index;
                            });
                          }, 
                          child: Container(
                            width: size.width < 800 ? size.width * 0.18 : size.width * 0.22,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: selectedOrderType == index? Palette.btnGradientColor : Palette.bgGradient,
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
                                            color: selectedOrderType == index? Colors.white: Palette.textColorLightPurple,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            ),
                          );
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Autocomplete <String>(
                  optionsBuilder: (TextEditingValue textEditingValue){
                    if(textEditingValue.text == ''){
                      return const Iterable<String>.empty();
                    }
                    return customerNames.where((String customer){
                      return customer.contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onEditingComplete: onFieldSubmitted,
                      decoration: const InputDecoration(
                        hintText: "Customer Name",
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Color.fromARGB(106, 113, 15, 131),
                        ),
                      ),
                    );
                  },
                ),
                Palette.sizeBoxVarticalSpace,
                Autocomplete <String>(
                  optionsBuilder: (TextEditingValue textEditingValue){
                    if(textEditingValue.text == ''){
                      return const Iterable<String>.empty();
                    }
                    return customerNames.where((String customer){
                      return customer.contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onEditingComplete: onFieldSubmitted,
                      decoration: const InputDecoration(
                        hintText: "Address",
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Color.fromARGB(106, 113, 15, 131),
                        ),
                      ),
                    );
                  },
                ),
                Palette.sizeBoxVarticalSpace,
                const TextField(
                    decoration: InputDecoration(
                      hintText: "Car Number",
                      prefixIcon: Icon(
                        Icons.car_crash,
                        color: Color.fromARGB(106, 113, 15, 131),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if(selectedOrderType == 0)
                  Row(
                    children: [
                      const Text("Floor 1 - Table 5",
                        style: TextStyle(
                          fontFamily: Palette.layoutFont,
                          fontWeight: FontWeight.w600,
                          color: Palette.textColorPurple,
                          fontSize: Palette.contentTitleFontSizeL
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      TextButton(onPressed: (){
                          showModalBottomSheet(context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40),
                            )
                          ), 
                          builder: (BuildContext context){
                            return const DineInScreen();
                          }
                        );
                      },
                      child: Container(
                        width: 80,
                        height: 40,
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
                          child: Text("Edit",
                                style: TextStyle(
                                fontFamily: Palette.layoutFont,
                                fontWeight: Palette.btnFontWeight,
                                fontSize: Palette.btnFontsize,
                                color: Palette.btnTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                 
              ],
            ),
          ),
        ),
      ),
      bottomSheet:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextButton(
          onPressed: (){
          // Navigator.push(context,
          // MaterialPageRoute(builder: (_) => const MenuScreen(),),);
          Get.to(const OrderSuccessfulScreen());}, 
            child: const CurbButton(
              buttonPadding: EdgeInsets.only(left: 0,right: 0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("PROCEED",style: TextStyle(
                  fontFamily: Palette.layoutFont,
                  fontWeight: Palette.btnFontWeight,
                  fontSize: Palette.btnFontsize,
                  color: Palette.btnTextColor,
                ),),
                Icon(Icons.arrow_forward,size: 20,color: Colors.white,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}