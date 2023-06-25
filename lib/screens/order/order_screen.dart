import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/food.dart';
import 'package:hitechpos/screens/Menu/menu_screen.dart';
import 'package:hitechpos/widgets/curb_button.dart';

class OrderScreen extends StatefulWidget {
  final Food food;
  const OrderScreen({Key?key, required this.food}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController _txtKitchenNotesController = TextEditingController();
  final TextEditingController _txtInvoiceNotesController = TextEditingController();
  int selectedFoodItemSizeIndex = 0;
  int orderQuentity = 1;
  List<String> isSelectedModifier = <String>[];
  List<String> isSelectedKitchenNotes = <String>[];
  String concatedKitchenNotes= "";
  List<String> isSelectedInvoiceNotes = <String>[];
  String concatedInvoiceNotes= "";
  double modifierTotalPrice = 0;
  @override
  void dispose(){
    _txtKitchenNotesController.dispose();
    _txtInvoiceNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    concatedKitchenNotes = isSelectedKitchenNotes.join(",");
    concatedInvoiceNotes = isSelectedInvoiceNotes.join(",");
    _txtKitchenNotesController.text = concatedKitchenNotes;
    _txtInvoiceNotesController.text = concatedInvoiceNotes;
    Size size = MediaQuery.of(context).size;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double price = foodSizeList[selectedFoodItemSizeIndex].price + modifierTotalPrice;
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
      body:SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                //header image work start
                Hero(
                tag: widget.food.imageUrl,
                child: Image(
                  height: isPortrait? size.height*0.30 : size.height*0.40,
                  width: size.width,
                  image: AssetImage(widget.food.imageUrl),
                  fit: BoxFit.cover,
                  ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 50.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      iconSize: 30.0,
                    ),
                    IconButton(
                      onPressed: () => {},
                      icon: Icon(
                        Icons.favorite,
                        color: Theme.of(context).primaryColor,
                      ),
                      iconSize: 30.0,
                    ),
                  ],
                ),
                
              ),
             //header image work end
              Container(
              margin: EdgeInsets.only(top: isPortrait ? size.height*0.25 : size.height*0.30,),
               width: size.width,
               decoration: Palette.containerCurbBoxdecoration,
               child: Padding(
                 padding: const EdgeInsets.all(40.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     //Place Order Text Start
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           const Expanded(
                             child: Text("Place Order",
                               style: TextStyle(
                                 fontFamily: Palette.layoutFont,
                                 fontWeight: FontWeight.w700,
                                 color: Palette.textColorLightPurple,
                                 fontSize: 30,
                               ),
                             ),
                           ),
                           Center(
                             child: IconButton(
                               onPressed: () => Navigator.pop(context), 
                               icon: const Icon(Icons.close,
                                 size: 40,
                                 color: Palette.fontBgGray
                                 ),
                               ),
                           ),
                         ],
                       ),
                       //Place Order Text End
                       const SizedBox(
                         height: 30,
                       ),
                       //Product Name price and discriptin start
                       SizedBox(
                         width: size.width,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Expanded(
                               child: Text(widget.food.name,
                                 style: const TextStyle(
                                   fontFamily: Palette.layoutFont,
                                   color: Palette.textBackGroundBlack,
                                   fontWeight: FontWeight.w600,
                                   fontSize: 25
                                 ),
                               ),
                             ),
                             Expanded(
                               child: Text("\$ ${price * orderQuentity}",
                                   textAlign: TextAlign.end,
                                   style: const TextStyle( 
                                   fontFamily: Palette.layoutFont,
                                   color: Palette.textColorPurple,
                                   fontWeight: FontWeight.w800,
                                   fontSize: 30,
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                       SizedBox(
                         child: Text(widget.food.discription,
                         style: const TextStyle(
                           fontFamily: Palette.layoutFont,
                           color: Palette.textColorPurple,
                           overflow: TextOverflow.ellipsis,
                           fontWeight: FontWeight.w400,
                           fontSize: 20
                         ),
                         maxLines: 1,
                         softWrap: false,
                         ),
                       ),
                     //Product Name and discriptin end
                      //Quantity Start
                     const SizedBox(
                      height: 20,
                     ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         const Expanded(
                          flex: 4,
                           child: Text("Quantity",
                           style: TextStyle(
                               fontFamily: Palette.layoutFont,
                               color: Palette.textColorLightPurple,
                               fontWeight: FontWeight.w500,
                               fontSize: 23,
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
                                    onPressed: () {
                                      setState(() {
                                        if(orderQuentity > 1){
                                          orderQuentity = orderQuentity - 1;
                                        }
                                      });
                                    },
                                    child: const SizedBox(
                                      height: 46,
                                      child: Center(
                                        child: Text(
                                          '-',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: Palette.layoutFont
                                          ),
                                        ),
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
                                      child: Text( "${orderQuentity}",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: Palette.layoutFont
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        orderQuentity = orderQuentity + 1;
                                      });
                                    },
                                    child: Container(
                                      height: 46,
                                      child: Center(
                                        child: const Text(
                                          '+',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: Palette.layoutFont
                                          ),
                                        ),
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
                     const SizedBox(
                      height: 30,
                     ),
                     const Text("Item Size",
                        style: TextStyle(
                        fontFamily: Palette.layoutFont,
                        color: Palette.textColorLightPurple,
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                      ),
                    ),
                     const SizedBox(
                      height: 15,
                     ),
                     Row(
                       children: [
                         Expanded(
                           child: Wrap(
                            alignment: WrapAlignment.start,
                            direction: Axis.horizontal,
                            spacing: 2,
                            runSpacing: 8,
                            children: List.generate(foodSizeList.length, (index) {
                              return TextButton(
                                  onPressed: (){
                                    setState(() {
                                      selectedFoodItemSizeIndex = index;
                                    });
                                  }, 
                                  child: Container(
                                    //margin: const EdgeInsets.only(right: 2, bottom: 2 ),
                                    width: 100,
                                    height: 50,
                                    
                                    decoration: BoxDecoration(
                                      gradient: selectedFoodItemSizeIndex == index? Palette.btnGradientColor : Palette.bgGradient,
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                      border: Border.all(
                                        color: Palette.btnBoxShadowColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        child: Text("${foodSizeList[index].sizeName}( \$${foodSizeList[index].price} )",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: selectedFoodItemSizeIndex == index? Colors.white: Palette.textColorLightPurple,
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
                     const SizedBox(
                      height: 30,
                     ),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Modifiers',
                          style: TextStyle(
                            fontFamily: Palette.layoutFont,
                            color: Palette.textColorLightPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: 23,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //_buildModiriers(),
                        Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                spacing: 2,
                                runSpacing: 8,
                                children: List.generate(modifierList.length, (index) {
                                  return TextButton(
                                      onPressed: (){
                                        setState(() {
                                          if(!isSelectedModifier.contains(modifierList[index].name)){
                                            isSelectedModifier.add(modifierList[index].name);
                                            modifierTotalPrice = modifierTotalPrice + modifierList[index].price;
                                          }
                                          else{
                                            isSelectedModifier.remove(modifierList[index].name);
                                            modifierTotalPrice = modifierTotalPrice - modifierList[index].price;
                                          }
                                        });
                                      }, 
                                      child: Container(
                                        //margin: const EdgeInsets.only(right: 2, bottom: 2 ),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          gradient: isSelectedModifier.contains(modifierList[index].name)? Palette.btnGradientColor : Palette.bgGradient,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          border: Border.all(
                                            color: Palette.btnBoxShadowColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(modifierList[index].name,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: isSelectedModifier.contains(modifierList[index].name)? Colors.white: Palette.textColorLightPurple,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(modifierList[index].discription,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: isSelectedModifier.contains(modifierList[index].name)? Colors.white: Palette.textColorLightPurple,
                                                      ),
                                                      overflow: TextOverflow.clip,
                                                      maxLines: 2,
                                                      softWrap: true,
                                          
                                                ),
                                                Text("Price: ${modifierList[index].price}",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: isSelectedModifier.contains(modifierList[index].name)? Colors.white: Palette.textColorLightPurple,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
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
                    const SizedBox(
                      height: 30,
                     ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Kitchen Note(s)",
                            style: TextStyle(
                            fontFamily: Palette.layoutFont,
                            color: Palette.textColorLightPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: 23,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                spacing: 2,
                                runSpacing: 8,
                                children: List.generate(kitchenNotes.length, (index) {
                                  return TextButton(
                                      onPressed: (){
                                        setState(() {
                                          if(!isSelectedKitchenNotes.contains(kitchenNotes[index])){
                                            isSelectedKitchenNotes.add(kitchenNotes[index]);
                                          }
                                          else{
                                            isSelectedKitchenNotes.remove(kitchenNotes[index]);
                                          }
                                        });
                                      }, 
                                      child: Container(
                                        //margin: const EdgeInsets.only(right: 2, bottom: 2 ),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          gradient: isSelectedKitchenNotes.contains(kitchenNotes[index])? Palette.btnGradientColor : Palette.bgGradient,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          border: Border.all(
                                            color: Palette.btnBoxShadowColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(kitchenNotes[index],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: isSelectedKitchenNotes.contains(kitchenNotes[index])? Colors.white: Palette.textColorLightPurple,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  softWrap: false,
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
                        const SizedBox(
                          height: 15,
                        ),                    
                        TextField(
                          controller: _txtKitchenNotesController,
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
                     const SizedBox(
                      height: 30,
                     ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Invoice Note(s)",
                            style: TextStyle(
                            fontFamily: Palette.layoutFont,
                            color: Palette.textColorLightPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: 23,
                          ),
                        ),
                        const SizedBox(
                         height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                spacing: 2,
                                runSpacing: 8,
                                children: List.generate(invoiceNotes.length, (index) {
                                  return TextButton(
                                      onPressed: (){
                                        setState(() {
                                          if(!isSelectedInvoiceNotes.contains(invoiceNotes[index])){
                                            isSelectedInvoiceNotes.add(invoiceNotes[index]);
                                          }
                                          else{
                                            isSelectedInvoiceNotes.remove(invoiceNotes[index]);
                                          }
                                        });
                                      }, 
                                      child: Container(
                                        //margin: const EdgeInsets.only(right: 2, bottom: 2 ),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          gradient: isSelectedInvoiceNotes.contains(invoiceNotes[index])? Palette.btnGradientColor : Palette.bgGradient,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          border: Border.all(
                                            color: Palette.btnBoxShadowColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(invoiceNotes[index],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: isSelectedInvoiceNotes.contains(invoiceNotes[index])? Colors.white: Palette.textColorLightPurple,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  softWrap: false,
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
                        const SizedBox(
                         height: 15,
                        ),
                        TextField(
                          controller: _txtInvoiceNotesController,
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
                    //Order buttorn Start
                    const SizedBox(
                      height: 40,
                    ),
                    TextButton(
                      onPressed: (){ 
                      Navigator.pop(context);}, 
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
                            ),),
                            Icon(Icons.add_card,size: 20,color: Colors.white,),
                          ],
                        ),
                      ),
                    ),
                    //Order button End
                   ],
                 ),
               ),
               ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}