import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/order.dart';
import 'package:hitechpos/widgets/curb_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            return Container(
              width: size.width,
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        //First Part
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Name
                                Text(
                                order.food.name,
                                style: const TextStyle(
                                  fontSize: Palette.btnFontsize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Palette.layoutFont
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              //Kitchen Note
                              const Text("KN : Extra Sauce, No Oil",
                                style: TextStyle(
                                  fontSize: Palette.containerButtonFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Palette.layoutFont
                                ),
                              ),
                              //Invoice Note
                              const Text("IN : After 1 Houre",
                                style: TextStyle(
                                  fontSize: Palette.containerButtonFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Palette.layoutFont
                                ),
                              ),
                            ],
                  
                          )
                        ),
                        
                        //Second Part
                        Expanded(
                          flex: 2,
                          child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 96, 137),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              
                              // + button
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    currentUser.cart[index].quantity = currentUser.cart[index].quantity + 1;
                                  });
                                },
                                child: const Text(
                                  '+',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Palette.contentTitleFontSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Palette.layoutFont
                                  ),
                                ),
                              ),
                              
                              // Counter Box
                              Container(
                                height: 20,
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
                                    style: const TextStyle(
                                      fontSize:Palette.contentTitleFontSize,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: Palette.layoutFont
                                    ),
                                  ),
                                ),
                              ),
                              
                              // - button
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    if(currentUser.cart[index].quantity > 1){
                                      currentUser.cart[index].quantity = currentUser.cart[index].quantity - 1;
                                    }
                                  });
                                },
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Palette.contentTitleFontSize,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Palette.layoutFont
                                  ),
                                ),
                              ),
                              
                            ],
                            ),
                          )
                        ),
                        //Price
                        Expanded(
                          flex: 2,
                            child: Center(
                              child: Text(
                                '\$${order.food.price * order.quantity}',
                                style: const TextStyle(
                                fontSize: Palette.containerButtonFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: Palette.layoutFont
                              ),
                              ),
                            ),
                          ),
                        
                        // Delete Button
                        Expanded(
                          flex: 2,
                          child: TextButton(
                          onPressed: () {
                            setState(() {
                            });
                          }, 
                          child: const Icon(Icons.delete),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text("Coca Cola",
                        style: TextStyle(
                          fontSize: Palette.containerButtonFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: Palette.layoutFont
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text("\$5.00",
                          style: TextStyle(
                            fontSize: Palette.containerButtonFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: Palette.layoutFont
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                     Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    ],
                  )
                ],
              ),
              
            );
          }
          //Total cost 
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Cost :',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 90.0,
                ),
              ],
            ),
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
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const CurbButton(
              buttonPadding: EdgeInsets.only(left: 0,right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("CHECKOUT",style: TextStyle(
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
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}