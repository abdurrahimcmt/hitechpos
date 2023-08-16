import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/customer_and_address_controller.dart';
import 'package:hitechpos/models/customeraddress.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key?key}) : super(key:key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final controller = Get.find<CustomerAndAddressController>();
  late String combinedAddress = "";
  @override
  void initState() {
    if(controller.getSelectedCustomerAddress().vAddId.isNotEmpty){
      combinedAddress = controller.combinedCustomerAddressFields(controller.getSelectedCustomerAddress());
    }
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    TextEditingValue selectedCustomer = TextEditingValue(text: controller.getSelectedCustomer().vCustomerName);
    TextEditingValue selectedAddress = TextEditingValue(text: combinedAddress);
    //selectedCustomer.text = controller.getSelectedCustomer().vCustomerName;
    controller.setCustomerList();
    TextEditingController addressTextController = TextEditingController();
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
                Autocomplete <CustomerList>(
                  initialValue: selectedCustomer,
                  onSelected: (option) {
                    debugPrint(option.vCustomerName.toString());
                    controller.setSelectedCustomer(option);
                    debugPrint("From Controller ${controller.getSelectedCustomer().vCustomerName}");
                    controller.setCustomerAddressList(option.vCustomerId);
                    setState(() {
                      controller.setSelectedCustomerAddress(CustomerAddressList(vCustomerId: "", vAddId: "", vArea: "", vBuildingNo: "", vFlatNo: "", vBlockNo: "", vRoadNo: ""));
                      addressTextController.text = "";
                    });
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

                Autocomplete <CustomerAddressList>(
                  initialValue: selectedAddress,
                  onSelected: (option) {
                    controller.setSelectedCustomerAddress(option);
                  },
                  optionsBuilder: (TextEditingValue textEditingValue){
                    if(textEditingValue.text == ''){
                      return const Iterable<CustomerAddressList>.empty();
                    }
                    return controller.customerAddressList.where((CustomerAddressList address){
                      String combinedAddress = controller.combinedCustomerAddressFields(address);
                      return combinedAddress.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  displayStringForOption: (address) {
                    return controller.combinedCustomerAddressFields(address);
                  },
                  fieldViewBuilder: (context, addressTextController, focusNode, onFieldSubmitted) {              
                    return TextField(
                      controller: addressTextController,
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
                
                // Obx(
                //   () { 
                //     if(controller.isDataLoading.value){
                //         return const CircularProgressIndicator();
                //     }
                //     else{
                //       return DropdownButtonFormField(
                //         decoration: const InputDecoration(
                //           isDense: true,
                //           hintText: "Select Address",
                //           prefixIcon: Icon(
                //             Icons.store_mall_directory,
                //             color: Color.fromARGB(106, 113, 15, 131),
                //           ),
                //         ),
                //         value: controller.selectedCustomerAddress,
                //         items: controller.addressDropdownItemMenu.value,
                //         autovalidateMode: AutovalidateMode.onUserInteraction,
                //         // validator: (value) {
                //         //   if(value! == "0"){
                //         //     return "Please select Branch";
                //         //   }
                //         //   return null;
                //         // },
                //         onChanged: (val) {
                //           controller.setSelectedCustomerAddress(val!);
                //           debugPrint(val);
                //         }
                //       );
                //     }
                //   }
                // ),
                Palette.sizeBoxVarticalSpace,
                const CommonSubmitButton(title: "Submit"),
              ],
            ),
          ),
        ),
      );
  }
}