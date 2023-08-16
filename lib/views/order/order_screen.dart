import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/controllers/order_controller.dart';
import 'package:hitechpos/models/itemdetails.dart';
import 'package:hitechpos/models/kitchennotes.dart';
import 'package:hitechpos/views/menu/menu_screen.dart';
import 'package:hitechpos/widgets/curb_button.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key?key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  final controller = Get.find<OrderController>();
  final cartController = Get.find<CartController>();
  final loginController = Get.find<LoginController>();
  String item = Get.arguments;

  final TextEditingController _txtKitchenNotesController = TextEditingController();
  final TextEditingController _txtInvoiceNotesController = TextEditingController();
  final TextEditingController _txtQuntityController = TextEditingController();
  
  int selectedFoodItemSizeIndex = 0;
  int orderQuentity = 1;

  List<OnlineModifierList> selectedModifierList = []; 
  List<String> isSelectedModifier = <String>[];

  List<String> isSelectedKitchenNotes = <String>[];
  String concatedKitchenNotes= "";

  List<String> isSelectedInvoiceNotes = <String>[];
  String concatedInvoiceNotes= "";

  double modifierTotalPrice = 0.000;
  // double modifierTotalVat = 0.000;
  // double modifierTotalWithoutVatPrice = 0.000;
  // double selectedItemUnitVat = 0.000;
  // double selectedItemUnitWithoutVatPrice = 0.000;
  double selectedItemUnitPrice = 0.000;
  //when loading data user should not increase quentity value
  bool isloading = true;

  ItemDetails itemdetails = ItemDetails(messageId: "", message: "", itemViewList: []) ;
  ItemViewList itemViewList = ItemViewList(vItemId: "", vItemType: "", vItemName: "", vDescription: "", vItemNameAr: "", vImagePath: "", vItemPrice: "", vPriceDetails: "", vVatCatId: "", vVatOption: "", mPercentage: 0.000, itemPriceList: [], onlineModifierLists: []);
  List<ItemPriceList> itemPriceList = [ItemPriceList(vUnitId: "", vUnitName: "", vVatCatId: "", vVatOption: "", mPercentage: 0.000, mMainPrice: 0.000, mVatAmount: 0.000, mWoVatAmount: 0.000, mFinalPrice: 0.000)];
  List<OnlineModifierList>  itemModifierList = [OnlineModifierList(vItemIdModifier: "", vItemName: "", iUnitId: "0", vUnitName: "", vQuantity: "0", vMainPrice: "0", mQuantity: 0.000, mMainPrice: 0.000, mVatAmount: 0.000, mWoVatAmount: 0.000, mFinalPrice: 0.000, vVatCatId: "", vVatOption: "", mPercentage: 0.000)];
  
  // void getDeviceinfo() async{
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //   debugPrint('Running on ${androidInfo.id}'); 
  //   Get.snackbar("DeviceId", 'DeviceId ${androidInfo.id}');
  // }
  @override
  initState() {
    super.initState();
   // getDeviceinfo();
    debugPrint("User: ${loginController.userIdFromLocalStorage}");
    controller.fatchItemDetails(item).then((value) {
      setState(() {
        itemdetails = value;
        itemViewList = value.itemViewList.first;
        itemPriceList = value.itemViewList.first.itemPriceList;
        itemModifierList = value.itemViewList.first.onlineModifierLists;
        isloading = false;
      });
    }).catchError((error){
      debugPrint("Error $error");
    });
  }
    @override
  void dispose(){
    _txtKitchenNotesController.dispose();
    _txtInvoiceNotesController.dispose();
    super.dispose();
  }
  //final ItemList food = Get.arguments as ItemList;
  @override
  Widget build(BuildContext context) {

    _txtQuntityController.text = orderQuentity.toString();
    concatedKitchenNotes = isSelectedKitchenNotes.join(", ");
    concatedInvoiceNotes = isSelectedInvoiceNotes.join(", ");
    _txtKitchenNotesController.text = concatedKitchenNotes;
    _txtInvoiceNotesController.text = concatedInvoiceNotes;
    // bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
     
    selectedItemUnitPrice = itemPriceList[selectedFoodItemSizeIndex].mFinalPrice;
    //selectedItemUnitVat = itemPriceList[selectedFoodItemSizeIndex].mVatAmount;
    //selectedItemUnitWithoutVatPrice = itemPriceList[selectedFoodItemSizeIndex].mWoVatAmount;

    double price = selectedItemUnitPrice  + modifierTotalPrice;

    Size size = MediaQuery.of(context).size;
    var contentTitleFontSize = (size.width < 600)? Palette.contentTitleFontSize : Palette.contentTitleFontSizeL;
    var discriptionFontSize = (size.width < 600)? Palette.discriptionFontSize : Palette.discriptionFontSizeL;
    
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Palette.bgColorPerple,
      //   centerTitle: true,
      //   title: const Text(
      //     "HIPOS",
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 20,
      //     ),
      //   ),
      //   actions: [
      //     TextButton(
      //       onPressed: () => Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (_) => const CartScreen(),
      //         ),
      //       ),
      //       child: Text(
      //         'Cart  (${currentUser.cart.length})',
      //         style: const TextStyle(
      //           color: Colors.white,
      //           fontSize: 20,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Place Order Text Start
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text("Place Order",
                              style: TextStyle(
                                fontFamily: Palette.layoutFont,
                                fontWeight: FontWeight.w700,
                                color: Palette.textColorLightPurple,
                                fontSize: contentTitleFontSize,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Get.to(() => MenuScreen()), 
                            icon: const Icon(Icons.close,
                              size: 40,
                              color: Palette.fontBgGray
                              ),
                            ),
                        ],
                      ),
                      //Place Order Text End
                      Palette.sizeBoxVarticalSpace,
                      //Product Name price and discriptin start
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(itemViewList.vItemName,
                                style: TextStyle(
                                  fontFamily: Palette.layoutFont,
                                  color: Palette.textBackGroundBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: contentTitleFontSize,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                (price * orderQuentity).toStringAsFixed(3),
                                  textAlign: TextAlign.end,
                                  style: TextStyle( 
                                  fontFamily: Palette.layoutFont,
                                  color: Palette.textColorPurple,
                                  fontWeight: FontWeight.w800,
                                  fontSize: contentTitleFontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(itemViewList.vDescription,
                      style: TextStyle(
                        fontFamily: Palette.layoutFont,
                        color: Palette.textColorPurple,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        fontSize: discriptionFontSize,
                      ),
                      maxLines: 1,
                      softWrap: false,
                      ),
                    //Product Name and discriptin end
                     //Quantity Start
                    Palette.sizeBoxVarticalSpace,
                    Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                         flex: 4,
                          child: Text("Quantity",
                          style: TextStyle(
                              fontFamily: Palette.layoutFont,
                              color: Palette.textColorLightPurple,
                              fontWeight: FontWeight.w500,
                              fontSize: contentTitleFontSize,
                            ),
                          ),
                        ),
                        Expanded(
                         flex: 6,
                          child: Container(
                           height: 46,
                           decoration: BoxDecoration(
                             color: const Color.fromARGB(255, 241, 96, 137),
                             borderRadius: BorderRadius.circular(12.0),
                           ),
                            child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Expanded(
                                 child: TextButton(
                                   onPressed: isloading ? null : () {
                                     setState(() {
                                       if(orderQuentity > 1){
                                         orderQuentity = orderQuentity - 1;
                                       }
                                     });
                                   },
                                   child: Text(
                                     '-',
                                     style: TextStyle(
                                       color: Colors.white,
                                       fontSize: contentTitleFontSize,
                                       fontWeight: FontWeight.w600,
                                       fontFamily: Palette.layoutFont
                                     ),
                                   ),
                                 ),
                               ),
                               Expanded(
                                 child: Container(
                                   width: size.width*0.2,
                                   height: 46,
                                   decoration: const BoxDecoration(
                                     gradient: LinearGradient(colors: [
                                           Color(0xffFFF7F9),
                                           Color(0xffFFFBFC),
                                     ]),
                                     boxShadow: [
                                       BoxShadow(
                                       color: Color.fromRGBO(241, 96, 138, 0.35),
                                       spreadRadius: 5,
                                       blurRadius: 2,
                                       offset: Offset(0, 2),
                                       )
                                     ],
                                     borderRadius: BorderRadius.all(
                                       Radius.circular(10),
                                     ),
                                   ),
                                   child: Center(
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: _txtQuntityController,
                                      keyboardType: TextInputType.number,
                                      // onChanged: (value) {
                                      //     if(_txtQuntityController.text.isEmpty){
                                      //       _txtQuntityController.text = _txtQuntityController.text;
                                      //       Get.snackbar("Worning", "Quentity must be getter then 0");
                                      //     }
                                      // },
                                      onEditingComplete: isloading ? null : () {
                                       // controller.quentityAction();
                                        setState(() {
                                          if(_txtQuntityController.text.isEmpty ||  int.parse( _txtQuntityController.text) < 1 ){
                                            _txtQuntityController.text = "1";
                                            Get.snackbar("Worning", "Quentity must be getter then 0");
                                          }
                                          orderQuentity = int.parse(_txtQuntityController.text);
                                        }); 
                                      },
                                      // onChanged: (value) {
                                      //   setState(() {
                                      //     orderQuentity = int.parse(_txtQuntityController.text);
                                      //   });
                                      // },
                                    ),
                                    //  child: Text( "$orderQuentity",
                                    //    style: TextStyle(
                                    //      fontSize:contentTitleFontSize,
                                    //      fontWeight: FontWeight.w600,
                                    //      fontFamily: Palette.layoutFont
                                    //    ),
                                    //  ),
                                   ),
                                 ),
                               ),
                               Expanded(
                                 child: TextButton(
                                   onPressed: isloading ? null : () {
                                  //  controller.orderQuentity.value = controller.orderQuentity.value + 1;
                                  //  controller.txtQuntityController.text = controller.orderQuentity.value.toString();
                                     setState(() {
                                       orderQuentity = orderQuentity + 1;
                                     });
                                   },
                                   child: Text(
                                     '+',
                                     style: TextStyle(
                                       color: Colors.white,
                                       fontSize: contentTitleFontSize,
                                       fontWeight: FontWeight.w600,
                                       fontFamily: Palette.layoutFont
                                     ),
                                   ),
                                 ),
                               ),
                             ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Quentity End
                    //Item Size Start
                    Palette.sizeBoxVarticalSpace,
                    Text("Item Size",
                       style: TextStyle(
                       fontFamily: Palette.layoutFont,
                       color: Palette.textColorLightPurple,
                       fontWeight: FontWeight.w500,
                       fontSize: contentTitleFontSize,
                     ),
                   ),
                    const SizedBox(
                     height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                           alignment: WrapAlignment.start,
                           direction: Axis.horizontal,
                           spacing: 0,
                           runSpacing: 0,
                           children: List.generate(itemPriceList.length, (index) {
                             return TextButton(
                                   onPressed: (){
                                    //controller.selectedFoodItemSizeIndex.value = index;
                                     setState(() {
                                       selectedFoodItemSizeIndex = index;
                                     });
                                   }, 
                                   child: Container(
                                     width: 60,
                                     height: 30,
                                     decoration: BoxDecoration(
                                       gradient: selectedFoodItemSizeIndex == index? Palette.btnGradientColor : Palette.bgGradient,
                                       borderRadius: Palette.textContainerBorderRadius,
                                       border: Border.all(
                                         color: Palette.btnBoxShadowColor,
                                         width: 1,
                                       ),
                                     ),
                                     child: Center(
                                       child: Padding(
                                         padding: const EdgeInsets.all(5.0),
                                         child: FittedBox(
                                           child: Text("${itemPriceList[index].vUnitName}(${itemPriceList[index].mFinalPrice.toStringAsFixed(3)})",
                                                 style: TextStyle(
                                                   fontSize: discriptionFontSize,
                                                   fontWeight: FontWeight.bold,
                                                   color: selectedFoodItemSizeIndex == index? Colors.white: Palette.textColorLightPurple,
                                                 ),
                                               ),
                                         ),
                                       ),
                                     ),
                                     ),
                                   );
                           }),
                          ),
                        ),
                      ],
                    ),
                    //Modifier List Start
                    Palette.sizeBoxVarticalSpace,
                    Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         'Modifiers',
                         style: TextStyle(
                           fontFamily: Palette.layoutFont,
                           color: Palette.textColorLightPurple,
                           fontWeight: FontWeight.w500,
                           fontSize: contentTitleFontSize,
                         ),
                       ),
                       const SizedBox(
                         height: 5,
                       ),
                       //_buildModiriers(),
                       Row(
                         children: [
                           Expanded(
                             child: Wrap(
                               alignment: WrapAlignment.start,
                               direction: Axis.horizontal,
                               spacing: 0,
                               runSpacing: 0,
                               children: List.generate(itemModifierList.length, (index) {
                                String modifierName = itemModifierList[index].vItemName;
                                double modifierPrice = itemModifierList[index].mFinalPrice;
                               //double modifierVat = itemModifierList[index].mVatAmount;
                               //double modifierWithoutVat = itemModifierList[index].mWoVatAmount;
                                 return TextButton(
                                       onPressed: (){
                                          //controller.modifierAction(modifierList[index].name, modifierList[index].price);
                                         setState(() {
                                          if(!isSelectedModifier.contains(modifierName)){
                                             isSelectedModifier.add(modifierName);
                                             selectedModifierList.add(itemModifierList[index]);
                                             modifierTotalPrice = modifierTotalPrice + modifierPrice;
                                             // modifierTotalVat = modifierTotalVat + modifierVat;
                                             // modifierTotalWithoutVatPrice = modifierTotalWithoutVatPrice + modifierWithoutVat;
                                           }
                                           else{
                                             isSelectedModifier.remove(modifierName);
                                             selectedModifierList.remove(itemModifierList[index]);
                                             modifierTotalPrice = modifierTotalPrice - modifierPrice;
                                             // modifierTotalVat = modifierTotalVat - modifierVat;
                                             // modifierTotalWithoutVatPrice = modifierTotalWithoutVatPrice - modifierWithoutVat;
                                           }
                                         });
                                       }, 
                                       child: Container(
                                         width: 70,
                                         height: 55,
                                         decoration: BoxDecoration(
                                           gradient: isSelectedModifier.contains(modifierName)? Palette.btnGradientColor : Palette.bgGradient,
                                           borderRadius: Palette.textContainerBorderRadius,
                                           border: Border.all(
                                             color: Palette.btnBoxShadowColor,
                                             width: 1,
                                           ),
                                         ),
                                         child: Center(
                                           child: Padding(
                                             padding: const EdgeInsets.all(5.0),
                                             child: FittedBox(
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.center,
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                                 children: [
                                                   Text(modifierName,
                                                         style: TextStyle(
                                                          fontFamily: Palette.layoutFont,
                                                           fontSize: Palette.containerButtonFontSize,
                                                           fontWeight: FontWeight.bold,
                                                           color: isSelectedModifier.contains(modifierName)? Colors.white: Palette.textColorLightPurple,
                                                         ),
                                                   ),
                                                   Text("-",
                                                         style: TextStyle(
                                                          fontFamily: Palette.layoutFont,
                                                           fontSize: Palette.containerButtonFontSize,
                                                           fontWeight: FontWeight.bold,
                                                           color: isSelectedModifier.contains(modifierName)? Colors.white: Palette.textColorLightPurple,
                                                         ),
                                                        overflow: TextOverflow.ellipsis,                                 
                                                   ),
                                                   Text("(${modifierPrice.toStringAsFixed(3)})",
                                                         style: TextStyle(
                                                          fontFamily: Palette.layoutFont,
                                                           fontSize: Palette.containerButtonFontSize,
                                                           fontWeight: FontWeight.bold,
                                                           color: isSelectedModifier.contains(modifierName)? Colors.white: Palette.textColorLightPurple,
                                                         ),
                                                         overflow: TextOverflow.ellipsis,
                                                   ),
                                                 ],
                                               ),
                                             ),
                                           ),
                                         ),
                                     ),
                                   );
                               }),
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                   // Modifier List End
                   //kitchen Note start
                   Palette.sizeBoxVarticalSpace,
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Kitchen Note(s)",
                           style: TextStyle(
                           fontFamily: Palette.layoutFont,
                           color: Palette.textColorLightPurple,
                           fontWeight: FontWeight.w500,
                           fontSize: contentTitleFontSize,
                         ),
                       ),
                       const SizedBox(
                         height: 5,
                       ),
                       FutureBuilder<KitchenNotes>(
                        future: controller.kitchenNoteList,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    spacing: 0,
                                    runSpacing: 0,
                                    children: List.generate(snapshot.data!.noteList.length, (index) {
                                     // String noteId = snapshot.data!.noteList[index].vNoteId;
                                      String noteDetails = snapshot.data!.noteList[index].vNoteDetails;
                                      return TextButton(
                                            onPressed: (){
                                              // if(!controller.isSelectedKitchenNotes.contains(kitchenNotes[index])){
                                              //      controller.isSelectedKitchenNotes.add(kitchenNotes[index]);
                                              //      controller.refreshChichenNotes();
                                              //    }
                                              //    else{
                                              //      controller.isSelectedKitchenNotes.remove(kitchenNotes[index]);
                                              //      controller.refreshChichenNotes();
                                              // }
                                              setState(() {
                                                if(!isSelectedKitchenNotes.contains(noteDetails)){
                                                  isSelectedKitchenNotes.add(noteDetails);
                                                }
                                                else{
                                                  isSelectedKitchenNotes.remove(noteDetails);
                                                }
                                              });
                                            }, 
                                            child: Container(
                                              width: 60,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                gradient:  isSelectedKitchenNotes.contains(noteDetails)? Palette.btnGradientColor : Palette.bgGradient,
                                                borderRadius: Palette.textContainerBorderRadius,
                                                border: Border.all(
                                                  color: Palette.btnBoxShadowColor,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: FittedBox(
                                                    child: Text(noteDetails,
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: Palette.layoutFont,
                                                            fontSize: Palette.containerButtonFontSize,
                                                            fontWeight: FontWeight.bold,
                                                            color:  isSelectedKitchenNotes.contains(noteDetails)? Colors.white: Palette.textColorLightPurple,
                                                        ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ),
                                        );
                                    }),
                                  ),
                                ),
                              ],
                            );
                          }
                          else if (snapshot.hasError){
                            return SnackBar( content: Text("${snapshot.error}"),);
                          }
                          else{
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                       ),
                       const SizedBox(
                         height: 5,
                       ),
                       TextField(
                         controller: _txtKitchenNotesController,
                         style: TextStyle(
                           fontFamily: Palette.layoutFont,
                           fontSize: discriptionFontSize,
                         ),
                         decoration: const InputDecoration(
                           hintText: "Kitchen Note(s)",
                           prefixIcon: Icon(
                             Icons.kitchen_outlined,
                             color: Color.fromARGB(106, 113, 15, 131),
                           ),
                         ),
                       ),
                     ],
                   ),
                   //kitchen Note end
                   //Invoice Note start
                   Palette.sizeBoxVarticalSpace,
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Invoice Note(s)",
                           style: TextStyle(
                           fontFamily: Palette.layoutFont,
                           color: Palette.textColorLightPurple,
                           fontWeight: FontWeight.w500,
                           fontSize: contentTitleFontSize,
                         ),
                       ),
                       const SizedBox(
                        height: 5,
                       ),
                       FutureBuilder(
                        future: controller.invoiceNoteList,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    spacing: 0,
                                    runSpacing: 0,
                                    children: List.generate(snapshot.data!.noteList.length, (index) {
                                      String noteDetails = snapshot.data!.noteList[index].vNoteDetails;
                                      return TextButton(
                                            onPressed: (){
                                                // if(!controller.isSelectedInvoiceNotes.contains(invoiceNotes[index])){
                                                //    controller.isSelectedInvoiceNotes.add(invoiceNotes[index]);
                                                //    controller.refreshInvoiceNotes();
                                                //  }
                                                // else{
                                                //    controller.isSelectedInvoiceNotes.remove(invoiceNotes[index]);
                                                //    controller.refreshInvoiceNotes();
                                                // }
                                              setState(() {
                                                if(!isSelectedInvoiceNotes.contains(noteDetails)){
                                                  isSelectedInvoiceNotes.add(noteDetails);
                                                }
                                                else{
                                                  isSelectedInvoiceNotes.remove(noteDetails);
                                                }
                                              });
                                            }, 
                                            child: Container(
                                              width: 60,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                gradient: isSelectedInvoiceNotes.contains(noteDetails)? Palette.btnGradientColor : Palette.bgGradient,
                                                borderRadius: Palette.textContainerBorderRadius,
                                                border: Border.all(
                                                  color: Palette.btnBoxShadowColor,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: FittedBox(
                                                    child: Text(noteDetails,
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: Palette.layoutFont,
                                                            fontSize: discriptionFontSize,
                                                            fontWeight: FontWeight.bold,
                                                            color: isSelectedInvoiceNotes.contains(noteDetails)? Colors.white: Palette.textColorLightPurple,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ),
                                        );
                                    }),
                                  ),
                                ),
                              ],
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
                       const SizedBox(
                        height: 5,
                       ),
                       TextField(
                         controller: _txtInvoiceNotesController,
                         style: TextStyle(
                           fontFamily: Palette.layoutFont,
                           fontSize: discriptionFontSize,
                         ),
                         decoration: const InputDecoration(
                           hintText: "Invoice Note(s)",
                           prefixIcon: Icon(
                             Icons.note_alt_outlined,
                             color: Color.fromARGB(106, 113, 15, 131),
                           ),
                         ),
                       ),
                     ],
                   ),
                   //Invoice Note end
                   const SizedBox(
                     height: 60,
                   ),
                  ],
                ),
              ),
              ],
            ),
          ],
        ),
      ),
      //Order buttorn Start
      bottomSheet: TextButton(
        onPressed: (){
        cartController.addToCart(
          item, itemViewList.vItemName,orderQuentity, itemViewList.itemPriceList[selectedFoodItemSizeIndex].mFinalPrice , price,
          0.000, itemViewList.vVatCatId,itemViewList.vVatOption,itemViewList.mPercentage,
          itemPriceList[selectedFoodItemSizeIndex], 
          selectedModifierList, concatedKitchenNotes, concatedInvoiceNotes
        );
        Get.to(() => MenuScreen());}, 
        child: const CurbButton(
          buttonPadding: EdgeInsets.only(left: 0,right: 0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
              Text("ORDER",style: TextStyle(
                  fontFamily: Palette.layoutFont,
                  fontWeight: Palette.btnFontWeight,
                  fontSize: Palette.btnFontsize,
                  color: Palette.btnTextColor,
                ),
              ),
              Icon(Icons.add_card,size: 20,color: Colors.white,),
            ],
          ),
        ),
      ),
      //Order button End,
    );
  }
}