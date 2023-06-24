import 'package:flutter/material.dart';

class ItemSizeToggleButton extends StatefulWidget {
  const ItemSizeToggleButton({super.key});

  @override
  State<ItemSizeToggleButton> createState() => _ItemSizeToggleButtonState();
}

class _ItemSizeToggleButtonState extends State<ItemSizeToggleButton> {
  List<bool> isSelected = [true, false, false];
  @override
  Widget build(BuildContext context) {
    //bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    Size size = MediaQuery.of(context).size;
    return ToggleButtons(
      direction: size.width < 500 ? Axis.vertical : Axis.horizontal,
      isSelected: isSelected,
      selectedColor: Colors.white,
      color: Colors.black,
      fillColor: Colors.lightBlue.shade900,
      renderBorder: false,
      //splashColor: Colors.red,
      highlightColor: const Color.fromRGBO(255, 152, 0, 1),
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Small', 
            style: TextStyle(fontSize: 18),
            ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text('Large',
          style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text('Extra Large',
          style: TextStyle(fontSize: 18),
          ),
        ),
      ],
      onPressed: (int newIndex) {
        setState(() {
          for (int index = 0; index < isSelected.length; index++) {
            if (index == newIndex) {
              isSelected[index] = true;
            } else {
              isSelected[index] = false;
            }
          }
        });
      },
    );
  }
}



