import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/data/data.dart';
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
  @override
  void initState() {
    super.initState();
  }
  int selectedFoodItemSizeIndex = 0;
  int orderQuentity = 1;
  List<String> isSelectedModifier = <String>[];
  double modifierTotalPrice = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double price = foodSizeList[selectedFoodItemSizeIndex].price + modifierTotalPrice;
    
    _buildModiriers() {
    List<Widget> creatModifierList = [];
    for (int i=0; i<modifierList.length; i++) {
      creatModifierList.add(
          Container(
          //width: 320.0,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            border: Border.all(
              width: 1.0, 
              color: Colors.grey.shade200
              ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Using an Expanded widget makes a child of a Row or Column (also for Flex) expand to fill
              //the available space in the main axis ( horizontally for a Row or vertically for a Column).
              // If multiple children are expanded, the available space is divided among them according to
              //the flex factor.
              Expanded(
                child: Row(
                  children: [
                    //The ClipRRect class in Flutter provides us with a widget that clips its child using
                    //a rounded rectangle. The extra R in clipRRect stands for rounded.
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: AssetImage(
                          modifierList[i].imageUrl,
                        ),
                        height: 100,
                        width: size.width > 500 ? 100 : 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              modifierList[i].name,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: Palette.layoutFont
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              modifierList[i].discription,
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: Palette.layoutFont
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              modifierList[i].price.toString(),
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: Palette.layoutFont
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      width: size.width < 500 ?  48.0 : 100.0,
                      height: size.width < 500 ?  48.0 : 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Palette.bgColorPerple,
                      ),
                      child: IconButton(
                        onPressed: () {
                            setState(() {
                              if(!isSelectedModifier.contains(modifierList[i].name)){
                                isSelectedModifier.add(modifierList[i].name);
                                modifierTotalPrice = modifierTotalPrice + modifierList[i].price;
                              }
                              else{
                                isSelectedModifier.remove(modifierList[i].name);
                                modifierTotalPrice = modifierTotalPrice - modifierList[i].price;
                              }
                            });
                        },
                        icon: Icon(!isSelectedModifier.contains(modifierList[i].name) ?
                          Icons.add : Icons.delete,
                          size: size.width < 500? 30.0 : 60.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: creatModifierList,
    );
  }
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
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
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
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "Kitchen Note(s)",
                        prefixIcon: Icon(
                          Icons.kitchen_outlined,
                          color: Color.fromARGB(106, 113, 15, 131),
                        ),
                      ),
                    ),
                    //kitchen Note end
                    //Invoice Note start
                     const SizedBox(
                      height: 30,
                     ),                   
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
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "Invoice Note(s)",
                        prefixIcon: Icon(
                          Icons.note_alt_outlined,
                          color: Color.fromARGB(106, 113, 15, 131),
                        ),
                      ),
                    ),
                    //Invoice Note end
                    //Order buttorn Start
                    const SizedBox(
                      height: 40,
                    ),
                    TextButton(
                      onPressed: (){ 
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (_) => const MenuScreen(),),);}, 
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