import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/delivery_controller.dart';
import 'package:hitechpos/models/customeraddress.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key?key}) : super(key:key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final deliverycontroller = Get.find<DeliveryController>();
  late String combinedAddress = "";
  @override
  void initState() {
    if(deliverycontroller.getSelectedCustomerAddress().vAddId.isNotEmpty){
      combinedAddress = deliverycontroller.combinedCustomerAddressFields(deliverycontroller.getSelectedCustomerAddress());
    }
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    TextEditingValue selectedCustomer = TextEditingValue(text: deliverycontroller.getSelectedCustomer().vCustomerName);
    TextEditingValue selectedAddress = TextEditingValue(text: combinedAddress);
    //selectedCustomer.text = deliverycontroller.getSelectedCustomer().vCustomerName;
    deliverycontroller.setCustomerList();
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
                    deliverycontroller.setSelectedCustomer(option);
                    debugPrint("From Controller ${deliverycontroller.getSelectedCustomer().vCustomerName}");
                    deliverycontroller.setCustomerAddressList(option.vCustomerId);
                    setState(() {
                      deliverycontroller.setSelectedCustomerAddress(CustomerAddressList(vCustomerId: "", vAddId: "", vArea: "", vBuildingNo: "", vFlatNo: "", vBlockNo: "", vRoadNo: ""));
                      addressTextController.text = "";
                    });
                  },
                  optionsBuilder: (TextEditingValue textEditingValue){
                    if(textEditingValue.text == ''){
                      return const Iterable<CustomerList>.empty();
                    }
                    return deliverycontroller.customerList.where((CustomerList customer){
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
                    deliverycontroller.setSelectedCustomerAddress(option);
                  },
                  optionsBuilder: (TextEditingValue textEditingValue){
                    if(textEditingValue.text == ''){
                      return const Iterable<CustomerAddressList>.empty();
                    }
                    return deliverycontroller.customerAddressList.where((CustomerAddressList address){
                      String combinedAddress = deliverycontroller.combinedCustomerAddressFields(address);
                      return combinedAddress.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  displayStringForOption: (address) {
                    return deliverycontroller.combinedCustomerAddressFields(address);
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
                //     if(deliverycontroller.isDataLoading.value){
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
                //         value: deliverycontroller.selectedCustomerAddress,
                //         items: deliverycontroller.addressDropdownItemMenu.value,
                //         autovalidateMode: AutovalidateMode.onUserInteraction,
                //         // validator: (value) {
                //         //   if(value! == "0"){
                //         //     return "Please select Branch";
                //         //   }
                //         //   return null;
                //         // },
                //         onChanged: (val) {
                //           deliverycontroller.setSelectedCustomerAddress(val!);
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