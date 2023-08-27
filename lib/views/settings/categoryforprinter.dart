import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/menu_controller.dart';
import 'package:hitechpos/models/categoryInfo.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';

class CategoryforPrinter extends StatefulWidget {
  const CategoryforPrinter({super.key});

  @override
  State<CategoryforPrinter> createState() => _CategoryforPrinterState();
}

class _CategoryforPrinterState extends State<CategoryforPrinter> {
  final menuController = Get.find<MenuScreenController>();
  bool isSelectedCategory = false;
  List<bool> selectedCategory =[];
  late Future<CategoryInfo> categoryInfoList;
  //late Map<int,bool> selectedCategory;
  @override
  void initState(){
    isSelectedCategory = false;
    selectedCategory =[];
    super.initState();
    categoryInfoList = menuController.fatchCategoryInfo();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(

      decoration: Palette.containerCurbBoxdecoration,
      height: MediaQuery.of(context).size.height*0.80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Categories",
              style: TextStyle(
                fontFamily: Palette.layoutFont,
                fontSize: Palette.sheetTitleFontsize,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("All",
                    style: TextStyle(
                      fontFamily: Palette.layoutFont,
                      fontSize: Palette.contentTitleFontSizeL,
                      fontWeight: FontWeight.w700,
                      color: Palette.textColorPurple
                    ),
                  ),
                  Switch(
                    value: isSelectedCategory, 
                    onChanged: (value) {
                      setState(() {
                        isSelectedCategory = value;
                        if(selectedCategory.isNotEmpty){
                          for (var i = 0; i < selectedCategory.length; i++) {
                            selectedCategory[i] = isSelectedCategory;
                          }
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<CategoryInfo>(
                future: menuController.categoryInfoList,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return SizedBox(
                      child: ListView.builder(
                        itemCount: snapshot.data!.categoryList.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 5.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                        CategoryList foodCategory = snapshot.data!.categoryList[index];
                        selectedCategory.add(false);
                          return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(foodCategory.vCategoryName,
                              style: const TextStyle(
                                fontFamily: Palette.layoutFont,
                                fontSize: Palette.contentTitleFontSizeL,
                                fontWeight: FontWeight.w700,
                                color: Palette.textColorPurple
                              ),
                            ),
                            Switch(
                              value: selectedCategory[index], 
                              onChanged:   isSelectedCategory ? null : (value) {
                                setState(() {
                                  selectedCategory[index] = value;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
                else{
                  return const Center(child: CircularProgressIndicator());
                }
              }),
            ),
            //Add Button
              const SizedBox(
                height: 20,
              ),
              const CommonSubmitButton(title: "Add"),
          ],
        ),
      ),
    );
  }
}