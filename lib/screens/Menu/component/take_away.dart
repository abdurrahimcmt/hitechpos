import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';

class TakeAwayScreen extends StatefulWidget {
  const TakeAwayScreen({super.key});

  @override
  State<TakeAwayScreen> createState() => _TakeAwayScreenState();
}

class _TakeAwayScreenState extends State<TakeAwayScreen> {
  late TextEditingController customerTextController;
  List<String> customerNames= <String>[
    'Ali',
    'Ahmed',
    'Kumar',
    'Hassan',
    'Khan',
    'Hussain',
    'Mohamed',
    'Abdulla',
    'Yousif',
    'Ebrahim',
    'Janahi',
    'Salman',
    'Nair',
    'Saleh',
    'Mahmood',
    'Mathew'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Palette.containerCurbBoxdecoration,
        height: MediaQuery.of(context).size.height*0.80,
        child:  Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Take Away",
                  style: TextStyle(
                    fontFamily: Palette.layoutFont,
                    fontSize: Palette.sheetTitleFontsize,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Autocomplete <String>(
                  optionsBuilder: (TextEditingValue textEditingValue){
                    if(textEditingValue.text == ''){
                      return const Iterable<String>.empty();
                    }
                    return customerNames.where((String customer){
                      return customer.contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onEditingComplete: onFieldSubmitted,
                      decoration: InputDecoration(
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
                const CommonSubmitButton(title: "Submit"),
              ],
            ),
          ),
        ),
      );
  }
}