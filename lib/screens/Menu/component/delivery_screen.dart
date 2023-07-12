import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  late TextEditingController customerTextController;
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
    return Container(
      decoration: Palette.containerCurbBoxdecoration,
        height: MediaQuery.of(context).size.height*0.80,
        child:  Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Delivery",
                  style: TextStyle(
                    fontFamily: Palette.layoutFont,
                    fontSize: Palette.sheetTitleFontsize,
                  ),
                ),
                const SizedBox(
                  height: 100,
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
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
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
                const CommonSubmitButton(title: "Submit"),
              ],
            ),
          ),
        ),
      );
  }
}