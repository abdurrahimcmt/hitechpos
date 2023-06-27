import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
import 'package:hitechpos/models/order.dart';
import 'package:hitechpos/screens/order/order_screen.dart';
import 'package:hitechpos/widgets/curb_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    double totalQty = 0;
    for (var order in currentUser.cart) {
      totalPrice += order.quantity * order.food.price;
      totalQty += order.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Palette.bgColorPerple,
        title: Text('Cart (${currentUser.cart.length})'),
      ),
      body:Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
            children: [
              Expanded(
                child: Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                spacing: 0,
                runSpacing: 2,
                children: List.generate(currentUser.cart.length, (index) {
                  return TextButton(
                      onPressed: () => Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (_) => OrderScreen(food: currentUser.cart[index].food),
                      ),
                    ), 
                    child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: Palette.bgGradient,
                          borderRadius: Palette.textContainerBorderRadius,
                          border: Border.all(
                            color: Palette.btnBoxShadowColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: Text(modifierList[index].name,
                                        style: const TextStyle(
                                        fontFamily: Palette.layoutFont,
                                          fontSize: Palette.containerButtonFontSize,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.textColorLightPurple,
                                        ),
                                  ),
                                ),
                                FittedBox(
                                  child: Text(currentUser.cart[index].food.discription,
                                        style: const TextStyle(
                                        fontFamily: Palette.layoutFont,
                                          fontSize: Palette.containerButtonFontSize,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.textColorLightPurple,
                                        ),
                                      overflow: TextOverflow.ellipsis,                                 
                                  ),
                                ),
                                FittedBox(
                                  child: Text("(\$${currentUser.cart[index].food.price} X ${currentUser.cart[index].quantity} = \$${currentUser.cart[index].food.price * currentUser.cart[index].quantity})",
                                        style: const TextStyle(
                                        fontFamily: Palette.layoutFont,
                                          fontSize: Palette.containerButtonFontSize,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.textColorLightPurple,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                  ),
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
          ),
      bottomSheet: Container(
        height: 120.0,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Total Qty : $totalQty",
                style: const TextStyle(
                fontFamily: Palette.layoutFont,
                color: Palette.textColorLightPurple,
                fontWeight: FontWeight.w800,
                fontSize: Palette.btnFontsize,
              ),
            ),
            Text("Total Price : $totalPrice",
                style: const TextStyle(
                fontFamily: Palette.layoutFont,
                color: Palette.textColorLightPurple,
                fontWeight: FontWeight.w800,
                fontSize: Palette.btnFontsize,
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
