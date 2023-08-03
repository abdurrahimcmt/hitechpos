import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/drivethrough_controller.dart';
import 'package:hitechpos/models/customeraddress.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';

class DriveThroughScreen extends StatefulWidget {
  const DriveThroughScreen({super.key});

  @override
  State<DriveThroughScreen> createState() => _DriveThroughScreenState();
}
class _DriveThroughScreenState extends State<DriveThroughScreen> {
  final driveThroughController = Get.find<DriveThroughController>();
  late String combinedAddress = "";

  @override
  void initState() {
    if(driveThroughController.getSelectedCustomerAddress().vAddId.isNotEmpty){
      combinedAddress = driveThroughController.combinedCustomerAddressFields(driveThroughController.getSelectedCustomerAddress());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TextEditingValue selectedCustomer = TextEditingValue(text: driveThroughController.getSelectedCustomer().vCustomerName);
    TextEditingValue selectedAddress = TextEditingValue(text: combinedAddress);
    driveThroughController.setCustomerList();
    TextEditingController addressTextController = TextEditingController();
    return Container(
      decoration: Palette.containerCurbBoxdecoration,
        height: MediaQuery.of(context).size.height*0.80,
        child:  Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Drive Through",
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
                    driveThroughController.setSelectedCustomer(option);
                    debugPrint("From Controller ${driveThroughController.getSelectedCustomer().vCustomerName}");
                    driveThroughController.setCustomerAddressList(option.vCustomerId);
                    setState(() {
                      driveThroughController.setSelectedCustomerAddress(CustomerAddressList(vCustomerId: "", vAddId: "", vArea: "", vBuildingNo: "", vFlatNo: "", vBlockNo: "", vRoadNo: ""));
                      addressTextController.text = "";
                    });
                  },
                  optionsBuilder: (TextEditingValue textEditingValue){
                    if(textEditingValue.text == ''){
                      return const Iterable<CustomerList>.empty();
                    }
                    return driveThroughController.customerList.where((CustomerList customer){
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
                    driveThroughController.setSelectedCustomerAddress(option);
                  },
                  optionsBuilder: (TextEditingValue textEditingValue){
                    if(textEditingValue.text == ''){
                      return const Iterable<CustomerAddressList>.empty();
                    }
                    return driveThroughController.customerAddressList.where((CustomerAddressList address){
                      String combinedAddress = driveThroughController.combinedCustomerAddressFields(address);
                      return combinedAddress.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  displayStringForOption: (address) {
                    return driveThroughController.combinedCustomerAddressFields(address);
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
                Palette.sizeBoxVarticalSpace,
                TextField(
                  controller: driveThroughController.carNumberController,
                  decoration: const InputDecoration(
                    hintText: "Car Number",
                    prefixIcon: Icon(
                      Icons.car_crash,
                      color: Color.fromARGB(106, 113, 15, 131),
                    ),
                  ),
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