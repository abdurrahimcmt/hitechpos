import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/controllers/customer_and_address_controller.dart';
import 'package:hitechpos/controllers/dini_in_controller.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/controllers/menu_controller.dart';
import 'package:hitechpos/controllers/orderlist_controller.dart';
import 'package:hitechpos/controllers/proceed_controller.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/customeraddress.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:hitechpos/models/invoiceinfodetails.dart';
import 'package:hitechpos/views/cart/cart_screen.dart';
import 'package:hitechpos/views/menu/component/dine_in.dart';
import 'package:hitechpos/widgets/curb_button.dart';
import 'package:hitechpos/widgets/loading_prograss_screen.dart';
class ProceedScreen extends StatefulWidget {
  const ProceedScreen({super.key});

  @override
  State<ProceedScreen> createState() => _ProceedScreenState();
}
class _ProceedScreenState extends State<ProceedScreen> {

  final controller = Get.find<ProceedController>();
  final menuController = Get.find<MenuScreenController>();
  final customerAndAddressController = Get.find<CustomerAndAddressController>();
  final diniInController = Get.find<DiniInController>();
  final cartController = Get.find<CartController>();
  final loginController = Get.find<LoginController>();
  final orderListController = Get.find<OrderListController>();

  late String combinedAddress = "";
  String floorAndTableName = "";
  
  int selectedOrderType = 0;
  String selectedOrderTypeName = "";
  late Future<InvoiceInfoDetails> invoiceInfoDetailsFuture;
  late String floorName;
  late String customerId;
  late String addressId;


  @override
  void initState() {
    setState(() {
      if(customerAndAddressController.getSelectedCustomerAddress().vAddId.isNotEmpty){
        combinedAddress = customerAndAddressController.combinedCustomerAddressFields(customerAndAddressController.getSelectedCustomerAddress());
      }
      selectedOrderType = menuController.selectedOrderType.value;
      selectedOrderTypeName = orderTypes[selectedOrderType].name;
      //controller.setOrderTypeData(menuController.selectedOrderType.value);
      customerAndAddressController.selectedCustomertext.value = TextEditingValue(text: customerAndAddressController.getSelectedCustomer().vCustomerName);
      customerAndAddressController.selectedAddress.value = TextEditingValue(text: customerAndAddressController.combinedCustomerAddressFields(customerAndAddressController.getSelectedCustomerAddress()));
      customerAndAddressController.setCustomerList();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    floorAndTableName = "${diniInController.selectedFloor.value.vFloorName}  ${diniInController.selectedTable.value.vTableName}";
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Proceed"),
        backgroundColor: Palette.bgColorPerple,
        leading: GestureDetector(
        onTap: () {
          Get.to(() => const CartScreen());
        },
        child: const Icon(Icons.arrow_back),
        ),
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
                            customerAndAddressController.refreshWhenSelectOrderType(index);
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
                if(selectedOrderType == 1 || selectedOrderType == 2 || selectedOrderType == 3) 
                Autocomplete <CustomerList>(
                  initialValue: customerAndAddressController.selectedCustomertext.value,
                  onSelected: (option) {
                    debugPrint(option.vCustomerName.toString());
                    customerAndAddressController.setSelectedCustomer(option);
                    debugPrint("From Controller ${customerAndAddressController.getSelectedCustomer().vCustomerName}");
                    customerAndAddressController.setCustomerAddressList(option.vCustomerId);
                    // setState(() {
                    //   customerAndAddressController.setSelectedCustomerAddress(CustomerAddressList(vCustomerId: "", vAddId: "", vArea: "", vBuildingNo: "", vFlatNo: "", vBlockNo: "", vRoadNo: ""));
                    // });
                  },
                  optionsBuilder: (TextEditingValue textEditingValue){
                    if(textEditingValue.text == ''){
                      return const Iterable<CustomerList>.empty();
                    }
                    return customerAndAddressController.customerList.where((CustomerList customer){
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
                if(selectedOrderType == 2 || selectedOrderType == 3) 
                // We should use RawAutocomplete here
                 Autocomplete <CustomerAddressList>(
                    initialValue: customerAndAddressController.selectedAddress.value,
                    onSelected: (option) {
                      customerAndAddressController.setSelectedCustomerAddress(option);
                    },
                    optionsBuilder: (TextEditingValue textEditingValue){
                      if(textEditingValue.text == ''){
                        return const Iterable<CustomerAddressList>.empty();
                      }
                      return customerAndAddressController.customerAddressList.where((CustomerAddressList address){
                        String combinedAddress = customerAndAddressController.combinedCustomerAddressFields(address);
                        return combinedAddress.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    displayStringForOption: (address) {
                      return customerAndAddressController.combinedCustomerAddressFields(address);
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
                if(selectedOrderType == 3) 
                TextField(
                    controller: customerAndAddressController.carNumberController,
                    decoration: const InputDecoration(
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
                      Obx(
                        () => Text("${diniInController.selectedFloor.value.vFloorName}  ${diniInController.selectedTable.value.vTableName}",
                          style: const TextStyle(
                            fontFamily: Palette.layoutFont,
                            fontWeight: FontWeight.w600,
                            color: Palette.textColorPurple,
                            fontSize: Palette.contentTitleFontSizeL
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      TextButton(onPressed: (){
                        setState(() {
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
                        });
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
        child: Obx(
           () => TextButton(
            onPressed: controller.isProceedStart.value ? null : () {
              controller.orderProceeedValidation(selectedOrderType);
            }, 
            child: CurbButton(
              buttonPadding: EdgeInsets.only(left: 0,right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("PROCEED",style: TextStyle(
                    fontFamily: Palette.layoutFont,
                    fontWeight: Palette.btnFontWeight,
                    fontSize: Palette.btnFontsize,
                    color: controller.isProceedStart.value ?Palette.bgColorPerple :Palette.btnTextColor,
                  ),),
                  Icon(Icons.arrow_forward,size: 20,color: Colors.white,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}