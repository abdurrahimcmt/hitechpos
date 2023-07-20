import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/views/dashboard/dashboard_screen.dart';
import 'package:hitechpos/views/settings/categoryforprinter.dart';
import 'package:hitechpos/widgets/curb_button.dart';
class PrinterSettingScreen extends StatefulWidget {
  const PrinterSettingScreen({super.key});

  @override
  State<PrinterSettingScreen> createState() => _PrinterSettingScreenState();
}

class _PrinterSettingScreenState extends State<PrinterSettingScreen> {
  String selectedOption = "len";
  final _branchNameList = ["Select Branch","Kitchen","Invoice"];
  String? _selectedBranch = "Select Branch";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.bgColorPerple,
        centerTitle: true,
        title: const Text(
          "Add Printer",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: (){},
            child: const Image(image: AssetImage("assets/images/save.png"),height: 22,)
          ),
        ],
      ),
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
          gradient: Palette.bgGradient,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            selectedOption = "len";
                          });
                        }, 
                        child: Container(
                          height: 135,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: selectedOption == "len" ? Palette.btnGradientColor : Palette.btnGradientColorLight,
                            borderRadius: const BorderRadius.all(Radius.circular(15))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.wifi,size: 60, color: selectedOption == "len" ? Colors.white : Colors.black),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("LAN / WIFI",
                                  style: TextStyle(
                                    fontFamily: Palette.layoutFont,
                                    fontSize: Palette.btnFontsize,
                                    fontWeight: FontWeight.w600,
                                    color: selectedOption == "len" ? Colors.white : Colors.black
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            selectedOption = "Bluetooth";
                          });
                        }, 
                        child: Container(
                          height: 135,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: selectedOption == "Bluetooth" ? Palette.btnGradientColor : Palette.btnGradientColorLight,
                            borderRadius: const BorderRadius.all(Radius.circular(15))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.bluetooth,size: 60, color: selectedOption == "Bluetooth" ? Colors.white : Colors.black),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Bluetooth",
                                  style: TextStyle(
                                    fontFamily: Palette.layoutFont,
                                    fontSize: Palette.btnFontsize,
                                    fontWeight: FontWeight.w600,
                                    color: selectedOption == "Bluetooth" ? Colors.white : Colors.black
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: (){
                    showModalBottomSheet(
                      context: context, 
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        )
                      ),

                      builder:(context) {
                        return const CategoryforPrinter();
                      },
                    );
                  }, 
                  child: Container(
                    height: 50,
                    width: size.width,
                    decoration: const BoxDecoration(
                      gradient: Palette.btnGradientColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select categories for the printer",
                            style: TextStyle(
                              fontFamily: Palette.layoutFont,
                              fontSize: Palette.btnFontsize,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),
                          ),
                          Icon(Icons.list,size: 25,color: Colors.white,),
                        ],
                      ),
                    ),
                  )
                ),
                const SizedBox(
                  height: 15,
                ),

                const Text("Branch",
                  style: TextStyle(
                    fontFamily: Palette.layoutFont,
                    fontSize: Palette.contentTitleFontSizeL,
                    fontWeight: FontWeight.w700,
                    color: Palette.textColorPurple
                  ),
                ),
                DropdownButtonFormField (
                  hint: const Text("Select Branch"),
                  value: _selectedBranch,
                  items: _branchNameList.map<DropdownMenuItem<String>>(
                      (e) => DropdownMenuItem(value: e, child: Text(e))
                  ).toList(), 
                  onChanged: (val) {
                    setState(() {
                      _selectedBranch = val  ;
                    });
                  }),
                const SizedBox(
                  height: 30,
                ),
                const Text("Printer Name",
                  style: TextStyle(
                    fontFamily: Palette.layoutFont,
                    fontSize: Palette.contentTitleFontSizeL,
                    fontWeight: FontWeight.w700,
                    color: Palette.textColorPurple
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Enter a name for the printer",
                    prefixIcon: Icon(
                      Icons.print,
                      color: Color.fromARGB(106, 113, 15, 131),
                    ),
                  ),
                ),

                
                if(selectedOption == "Bluetooth")
                const Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text("MAC Address",
                        style: TextStyle(
                          fontFamily: Palette.layoutFont,
                          fontSize: Palette.contentTitleFontSizeL,
                          fontWeight: FontWeight.w700,
                          color: Palette.textColorPurple
                        ),
                      ),
                      TextField(
                      decoration: InputDecoration(
                        hintText: "00:1B:44:11:3A:B7",
                        prefixIcon: Icon(
                          Icons.dns,
                          color: Color.fromARGB(106, 113, 15, 131),
                        ),
                      ),
                    ),
                  ],
                ),
                if(selectedOption == "len")
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text("IP Address",
                        style: TextStyle(
                          fontFamily: Palette.layoutFont,
                          fontSize: Palette.contentTitleFontSizeL,
                          fontWeight: FontWeight.w700,
                          color: Palette.textColorPurple
                        ),
                      ),
                      TextField(
                      decoration: InputDecoration(
                        hintText: "192.168.0.100",
                        prefixIcon: Icon(
                          Icons.insert_link_sharp,
                          color: Color.fromARGB(106, 113, 15, 131),
                        ),
                      ),
                    ),
                                        SizedBox(
                      height: 30,
                    ),
                    Text("Port",
                        style: TextStyle(
                          fontFamily: Palette.layoutFont,
                          fontSize: Palette.contentTitleFontSizeL,
                          fontWeight: FontWeight.w700,
                          color: Palette.textColorPurple
                        ),
                      ),
                      TextField(
                      decoration: InputDecoration(
                        hintText: "9100",
                        prefixIcon: Icon(
                          Icons.info,
                          color: Color.fromARGB(106, 113, 15, 131),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: (){
                  // Navigator.push(context,
                  // MaterialPageRoute(builder: (_) => const MenuScreen(),),);
                  Get.to(const DashboardScreen());}, 
                    child: const CurbButton(
                      buttonPadding: EdgeInsets.only(left: 0,right: 0),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Test Printer",style: TextStyle(
                          fontFamily: Palette.layoutFont,
                          fontWeight: Palette.btnFontWeight,
                          fontSize: Palette.btnFontsize,
                          color: Palette.btnTextColor,
                        ),),
                        Icon(Icons.print_rounded,size: 20,color: Colors.white,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}