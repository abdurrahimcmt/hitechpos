import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/takeway_controller.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';

class TakeAwayScreen extends StatelessWidget {
  TakeAwayScreen({Key?key}) : super(key:key);
  final controller = Get.find<TakeAwayController>();
  @override
  Widget build(BuildContext context) {
    controller.setCustomerList();
    return Container(
      decoration: Palette.containerCurbBoxdecoration,
        height: MediaQuery.of(context).size.height*0.80,
        child:  Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Take Away",
                  style: TextStyle(
                    fontFamily: Palette.layoutFont,
                    fontSize: Palette.sheetTitleFontsize,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Autocomplete <CustomerList>(
                  onSelected: (option) {
                    debugPrint(option.vCustomerName.toString());
                    controller.setSelectedCustomer(option);
                    debugPrint("From Controller ${controller.getSelectedCustomer().vCustomerName}");
                  },
                  optionsBuilder: (TextEditingValue textEditingValue){
                    if(textEditingValue.text == ''){
                      return const Iterable<CustomerList>.empty();
                    }
                    return controller.customerList.where((CustomerList customer){
                      return customer.vCustomerName.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                   displayStringForOption: (customer) {
                    return customer.vCustomerName;
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
                const CommonSubmitButton(title: "Submit"),
              ],
            ),
          ),
        ),
      );
  }
}