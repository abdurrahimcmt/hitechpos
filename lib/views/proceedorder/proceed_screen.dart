import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/controllers/delivery_controller.dart';
import 'package:hitechpos/controllers/dini_in_controller.dart';
import 'package:hitechpos/controllers/drivethrough_controller.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/controllers/menu_controller.dart';
import 'package:hitechpos/controllers/proceed_controller.dart';
import 'package:hitechpos/controllers/takeway_controller.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/customeraddress.dart';
import 'package:hitechpos/models/customerinfo.dart';
import 'package:hitechpos/models/invoiceinfodetails.dart';
import 'package:hitechpos/views/cart/cart_screen.dart';
import 'package:hitechpos/views/menu/component/dine_in.dart';
import 'package:hitechpos/views/proceedorder/ordersuccessful.dart';
import 'package:hitechpos/widgets/curb_button.dart';
class ProceedScreen extends StatefulWidget {
  const ProceedScreen({super.key});

  @override
  State<ProceedScreen> createState() => _ProceedScreenState();
}
class _ProceedScreenState extends State<ProceedScreen> {

  final controller = Get.find<ProceedController>();
  final menuController = Get.find<MenuScreenController>();
  final driveThroughController = Get.find<DriveThroughController>();
  final deliveryController = Get.find<DeliveryController>();
  final takeAwayController = Get.find<TakeAwayController>();
  final diniInController = Get.find<DiniInController>();
  final cartController = Get.find<CartController>();

  late String combinedAddress = "";
  String floorAndTableName = "";
  
  int selectedOrderType = 0;
  String selectedOrderTypeName = "";

  @override
  void initState() {
    
    selectedOrderType = menuController.selectedOrderType.value;
    selectedOrderTypeName = orderTypes[selectedOrderType].name;
    if(selectedOrderTypeName == "Dine In"){
      floorAndTableName = "${diniInController.selectedFloor.value.vFloorName}  ${diniInController.selectedTable.value.vTableName}";
      // setState(() {
      //  controller.refreshProceedController();
      // });
    }
    else if(selectedOrderTypeName == "Take Away"){
      //controller.refreshProceedController();
      if(takeAwayController.selectedCustomer.vCustomerId.isNotEmpty){
        controller.selectedCustomer = takeAwayController.selectedCustomer;
      }
    }
    else if(selectedOrderTypeName == "Delivery"){
      //controller.refreshProceedController();
      if(deliveryController.selectedCustomer.vCustomerId.isNotEmpty){
        controller.selectedCustomer = deliveryController.selectedCustomer;
      }
      if(deliveryController.selectedCustomerAddress.vArea.isNotEmpty){
        controller.selectedCustomerAddress = deliveryController.selectedCustomerAddress;
      }
    }
    else if(selectedOrderTypeName == "Drive Through"){
     // controller.refreshProceedController();
      if(driveThroughController.selectedCustomer.vCustomerId.isNotEmpty){
        controller.selectedCustomer = driveThroughController.selectedCustomer;
      }
      if(driveThroughController.selectedCustomerAddress.vArea.isNotEmpty){
        controller.selectedCustomerAddress = driveThroughController.selectedCustomerAddress;
      }
      if(driveThroughController.carNumberController.text.isNotEmpty){
        controller.carNumberController.text = driveThroughController.carNumberController.text;
      }
    }

    if(controller.getSelectedCustomerAddress().vAddId.isNotEmpty){
      combinedAddress = controller.combinedCustomerAddressFields(controller.getSelectedCustomerAddress());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    floorAndTableName = "${diniInController.selectedFloor.value.vFloorName}  ${diniInController.selectedTable.value.vTableName}";
    TextEditingValue selectedCustomer = TextEditingValue(text: controller.getSelectedCustomer().vCustomerName);
    TextEditingValue selectedAddress = TextEditingValue(text: combinedAddress);
    controller.setCustomerList();
    TextEditingController addressTextController = TextEditingController();
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
                if(selectedOrderType == 1 || selectedOrderType == 2 || selectedOrderType == 3) 
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
                if(selectedOrderType == 2 || selectedOrderType == 3) 
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
                Palette.sizeBoxVarticalSpace,
                if(selectedOrderType == 3) 
                TextField(
                    controller: controller.carNumberController,
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
        child: TextButton(
          onPressed: (){
            Future<InvoiceInfoDetails> invoiceData = cartController.getInvoiceInfoDetails(
              (selectedOrderType + 1).toString(),
              diniInController.selectedTable.value.vTableId, 
              controller.getSelectedCustomer().vCustomerId,
              controller.combinedCustomerAddressFields(controller.getSelectedCustomerAddress())
              );
            controller.proceedOrderPostRequest(invoiceData);
            // Navigator.push(context,
            // MaterialPageRoute(builder: (_) => const MenuScreen(),),);
            //Get.to(const OrderSuccessfulScreen());
          }, 
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