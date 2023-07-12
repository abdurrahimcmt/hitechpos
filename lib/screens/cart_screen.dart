import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/order.dart';
import 'package:hitechpos/widgets/curb_button.dart';

import 'proceedorder/proceed_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var contentTitleFontSize = (size.width < 600)? Palette.contentTitleFontSize : Palette.contentTitleFontSizeL;
    var discriptionFontSize = (size.width < 600)? Palette.discriptionFontSize : Palette.discriptionFontSizeL;
    double totalPrice = 0;
    for (var order in currentUser.cart) {
      totalPrice += order.quantity * order.food.price;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Palette.bgColorPerple,
        title: Text('Cart (${currentUser.cart.length})'),
      ),
      body: ListView.separated(
        itemCount: currentUser.cart.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cart.length) {
            int orderQuentity = currentUser.cart[index].quantity;
            Order order = currentUser.cart[index];
            return Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 5,top: 5),
              child: Column(
                children: [
                  //First Row
                  Row(
                    children: [
                      //First Part
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Name
                              Text( "${index + 1}) ${order.food.name}",
                              style: const TextStyle(
                                fontSize: Palette.btnFontsize,
                                fontWeight: FontWeight.bold,
                                fontFamily: Palette.layoutFont
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            //Kitchen Note
                            Text("KN: Extra Sauce, No Oil",
                              style: TextStyle(
                                fontSize: discriptionFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: Palette.layoutFont
                              ),
                            ),
                            //Invoice Note
                            Text("IN: After 1 Houre",
                              style: TextStyle(
                                fontSize: discriptionFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: Palette.layoutFont
                              ),
                            ),
                          ],
                        )
                      ),
                      
                      //Second Part
                      Container(
                        height: 30,
                      width: size.width > 700 ? 150 : size.width >= 400? 120 : 100 ,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 96, 137),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // - button
                          Expanded(
                            flex: 3,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if(currentUser.cart[index].quantity > 1){
                                    currentUser.cart[index].quantity = currentUser.cart[index].quantity - 1;
                                  }
                                });
                              },
                              child: LayoutBuilder(
                                builder: (BuildContext context, BoxConstraints constraints){
                                  return SizedBox(
                                    width: constraints.maxWidth,
                                    child: const Center(
                                      child: Text('-',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Palette.contentTitleFontSize,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: Palette.layoutFont
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ),
                          ),
                        
                          // Counter Box
                          Expanded(
                            flex: 6,
                            child: Container(
                              height: 25,
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
                                child: Text( "$orderQuentity",
                                  style: TextStyle(
                                    fontSize: contentTitleFontSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Palette.layoutFont
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          // + button
                          Expanded(
                            flex: 3,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  currentUser.cart[index].quantity = currentUser.cart[index].quantity + 1;
                                });
                              },
                              child: LayoutBuilder(
                                builder: (BuildContext context, BoxConstraints constraints){
                                  return SizedBox(
                                    width: constraints.maxWidth,
                                    child: const Center(
                                      child: Text('+',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Palette.contentTitleFontSize,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: Palette.layoutFont
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ),
                          ),
                        ],
                        ),
                      ),
                      //Price
                      SizedBox(
                        width: size.width > 700 ? 100 : 60,
                        child: Text(
                          (order.food.price * order.quantity).toStringAsFixed(3),
                          style: TextStyle(
                          fontSize: discriptionFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: Palette.layoutFont
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      
                      // Delete Button
                      SizedBox(
                        width: size.width > 700 ? 100 : 50,
                        child: TextButton(
                        onPressed: () {
                          setState(() {
                          });
                        }, 
                        child: const Icon(Icons.delete,color: Palette.bgColorPerple,),
                        ),
                      ),
                      
                    ],
                  ),
                  //Second Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("    Add: ",
                                style: TextStyle(
                                    fontSize: discriptionFontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Palette.layoutFont
                                  ),
                                  overflow: TextOverflow.ellipsis,
                              ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Coca Cola",
                                          style: TextStyle(
                                            fontSize: discriptionFontSize,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Palette.layoutFont
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(5.toStringAsFixed(3),
                                        style: TextStyle(
                                          fontSize: discriptionFontSize,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Palette.layoutFont
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                  if(index == 1 || index == 5)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Extra Cheess",
                                          style: TextStyle(
                                            fontSize: discriptionFontSize,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Palette.layoutFont
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(2.toStringAsFixed(3),
                                        style: TextStyle(
                                          fontSize: discriptionFontSize,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Palette.layoutFont
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width > 700 ? 100 : 50,
                      )
                    ],
                  ),
                ],
              ),
            );
          }
          //for bottom
          return const SizedBox(
            height: 160,
          );
        },
        //separator
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1.0,
            color: Colors.grey,
          );
        },
      ),
      
      //Checkout button
      bottomSheet: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Palette.textColorPurple,width: 1)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //first row
              Row(
                children: [
                  // KN IN full name
                  const Expanded(
                    flex: 6,
                    child: SizedBox(),
                    // Column(
                    //   crossAxisAlignment:CrossAxisAlignment.start,
                    //   children: [
                    //   Text("KN = Kitchen Notes",
                    //       style: TextStyle(
                    //         fontFamily: Palette.layoutFont,
                    //         fontSize: Palette.contentTitleFontSizeL,
                    //         fontWeight: FontWeight.w500,
                    //         color: Palette.textColorLightPurple,
                    //       ),
                    //     ),
                    //     Text("IN = Invoice Notes",
                    //       style: TextStyle(
                    //         fontFamily: Palette.layoutFont,
                    //         fontSize: Palette.contentTitleFontSizeL,
                    //         fontWeight: FontWeight.w500,
                    //         color: Palette.textColorLightPurple,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                  //Amount
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Total
                            const Expanded(
                              flex: 4,
                              child: Text(
                                'Total:',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: Palette.discriptionFontSizeL,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 2,
                              child: Text("BHD",
                                style: TextStyle(
                                  fontSize: Palette.discriptionFontSizeL,
                                  fontWeight: FontWeight.w600,
                                  color: Palette.textColorPurple,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                totalPrice.toStringAsFixed(3),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: Palette.discriptionFontSizeL,
                                  fontWeight: FontWeight.w600,
                                  color: Palette.textColorPurple,
                                ),
                              ),
                            ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Discount
                            const Expanded(
                              flex: 4,
                              child: Text(
                                'Discount:',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: Palette.discriptionFontSizeL,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Expanded(
                            flex: 2,
                             child: Text("BHD",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: Palette.discriptionFontSizeL,
                                  fontWeight: FontWeight.w600,
                                  color: Palette.textColorPurple,
                                ),
                              ),
                           ),
                            Expanded(
                            flex: 3,
                              child: Text(
                                0.toStringAsFixed(3),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: Palette.discriptionFontSizeL,
                                  fontWeight: FontWeight.w600,
                                  color: Palette.textColorPurple,
                                ),
                              ),
                            ),
                            ],
                          ),
                          //VAT
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Discount
                            const Expanded(
                              flex: 4,
                              child: Text(
                                'VAT:',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: Palette.discriptionFontSizeL,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 2,
                              child: Text("BHD",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: Palette.discriptionFontSizeL,
                                  fontWeight: FontWeight.w600,
                                  color: Palette.textColorPurple,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                1.toStringAsFixed(3),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: Palette.discriptionFontSizeL,
                                  fontWeight: FontWeight.w600,
                                  color: Palette.textColorPurple,
                                ),
                              ),
                            ),
                            ],
                          ),
                      ],
                    ),
                  )
                ],
              ),
              
                Palette.sizeBoxVarticalSpace,
                // Row(
                // children: [
                //   const Expanded(
                //       flex: 6,
                //       child: Text(
                //         'NET :',
                //         textAlign: TextAlign.right,
                //         style: TextStyle(
                //           fontSize: Palette.discriptionFontSizeL,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       flex: 3,
                //       child: Text(
                //         'BHD ${(1+totalPrice).toStringAsFixed(3)}',
                //         textAlign: TextAlign.end,
                //         style: TextStyle(
                //           fontSize: Palette.discriptionFontSizeL,
                //           fontWeight: FontWeight.w600,
                //           color: Colors.green[600],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              TextButton(
                onPressed: () {
                  Get.to(const ProceedScreen(),);
                },
                child: CurbButton(
                  buttonPadding: const EdgeInsets.only(left: 0,right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("CONFIRM",
                        style: TextStyle(
                          fontFamily: Palette.layoutFont,
                          fontWeight: Palette.btnFontWeight,
                          fontSize: Palette.btnFontsize,
                          color: Palette.btnTextColor,
                        ),
                      ),
                      Text("BHD ${(1+totalPrice).toStringAsFixed(3)} ",
                        style: const TextStyle(
                          fontFamily: Palette.layoutFont,
                          fontSize: Palette.btnFontsize,
                          fontWeight: Palette.btnFontWeight,
                          color: Colors.white,
                        ),
                      ),
                      const Icon(Icons.add_card,size: 20,color: Colors.white,),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}