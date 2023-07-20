import 'package:flutter/material.dart';

class OrderTypeBottomSheet extends StatefulWidget {
  final String orderType; 
  const OrderTypeBottomSheet({Key ? key, required this.orderType}) :super(key: key);

  @override
  State<OrderTypeBottomSheet> createState() => _OrderTypeBottomSheetState();
}

class _OrderTypeBottomSheetState extends State<OrderTypeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xff757575),
        ),
        child:Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Text(widget.orderType),
            ],
          ),
        ),
    );
  }
}