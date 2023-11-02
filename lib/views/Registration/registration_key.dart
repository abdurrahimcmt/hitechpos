import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/views/Registration/login_screen.dart';
import 'package:hitechpos/widgets/curb_button.dart';

import '../../controllers/login_controller.dart';

class RegistrationKeyScreen extends GetView<LoginController> {
 RegistrationKeyScreen({Key? key}) : super(key: key);
 final GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final loginController = Get.find<LoginController>();
      Size size = MediaQuery.of(context).size;
      return Container(
      height: size.height*0.85,
      decoration: Palette.containerCurbBoxdecoration,
       child: Padding(
         padding: const EdgeInsets.all(20.0),
         child: Form(
          key: registrationFormKey,
           child: Column(
             children: [
              const Text("Registration",
                style: TextStyle(
                  fontFamily: Palette.layoutFont,
                  fontSize: Palette.sheetTitleFontsize,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => DropdownButtonFormField(
                  
                  decoration: const InputDecoration(
                    hintText: "Select Schema",
                    prefixIcon: Icon(
                      Icons.schema,
                      color: Color.fromARGB(106, 113, 15, 131),
                    ),
                  ),
                  value: controller.selectedSchema.value,
                  items: controller.schemaValueList.map(
                      (e) => DropdownMenuItem(value: e, child: Text(e))
                  ).toList(), 
                  validator: (value) {
                    if(value! == "Select schema"){
                      controller.registrationSchemaFocus.requestFocus();
                      return "Please select schema";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    controller.setSelectedSchema(val!) ;
                    controller.isRegistrationSuccessfull(false);
                    controller.isSaveRegistrationData.value = false;
                  }
                ),
                
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                focusNode: controller.registrationPortFocus,
                controller: controller.registrationPortController,
                onChanged: (value) {
                  controller.isRegistrationSuccessfull(false);
                  controller.isSaveRegistrationData.value = false;
                },
                decoration: const InputDecoration(
                  hintText: "Enter your port",
                  prefixIcon: Icon(
                    Icons.settings_input_component,
                    color: Color.fromARGB(106, 113, 15, 131),
                  ),
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    controller.registrationPortFocus.requestFocus();
                    return "Please enter port";
                  }
                  return null;
                },
              ),
      
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: controller.registrationDomainFocus,
                controller: controller.registrationDomainController,
                onChanged: (value) {
                  controller.isRegistrationSuccessfull(false);
                  controller.isSaveRegistrationData.value = false;
                },
                decoration: const InputDecoration(
                  hintText: "Enter your domain",
                  prefixIcon: Icon(
                    Icons.domain_add_outlined,
                    color: Color.fromARGB(106, 113, 15, 131),
                  ),
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    controller.registrationDomainFocus.requestFocus();
                    return "Please enter Domain";
                  }
                  return null;
                },
              ),
              
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: controller.registrationKeyFocus,
                controller: controller.registrationKeyController,
                onChanged: (value) {
                  controller.isRegistrationSuccessfull(false);
                  controller.isSaveRegistrationData.value = false;
                },
                decoration: const InputDecoration(
                  hintText: "Enter Your key",
                  prefixIcon: Icon(
                    Icons.key_outlined,
                    color: Color.fromARGB(106, 113, 15, 131),
                  ),
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    controller.registrationKeyFocus.requestFocus();
                    return "Please enter Registration Key";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
               
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: TextButton(
                      onPressed: (){ 
                        if(registrationFormKey.currentState!.validate()){
                          controller.registrationTest(controller.registrationKeyController.text.trim());
                          // if(controller.isRegistrationSuccessfull.value == false){
                          //    Get.snackbar("Invalid", "Please provide valid information",snackPosition: SnackPosition.BOTTOM);
                          // }
                        }
                      }, 
                        child: const CurbButton(
                          buttonPadding: EdgeInsets.only(left: 0,right: 0),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Test",style: TextStyle(
                              fontFamily: Palette.layoutFont,
                              fontWeight: Palette.btnFontWeight,
                              fontSize: Palette.btnFontsize,
                              color: Palette.btnTextColor,
                            ),),
                            Icon(Icons.quiz,size: 20,color: Colors.white,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Obx(
                      () => TextButton(
                        onPressed: controller.isRegistrationSuccessfull.value ? (){ 
                          controller.saveRegistrationInformationInLocal(
                            controller.selectedSchema.value,
                            controller.registrationDomainController.text.trim(),
                            controller.registrationPortController.text.trim(),
                            controller.registrationKeyController.text.trim()
                          );
                        } : null, 
                        child: Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Container(
                                width: size.width,
                                height: 50,
                                decoration:  BoxDecoration(
                                  gradient: controller.isRegistrationSuccessfull.value? Palette.btnGradientColor : Palette.btnGradientColorLight,
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Palette.btnBoxShadowColor,
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Save",style: TextStyle(
                                    fontFamily: Palette.layoutFont,
                                    fontWeight: Palette.btnFontWeight,
                                    fontSize: Palette.btnFontsize,
                                    color: Palette.btnTextColor,
                                  ),),
                                  Icon(Icons.save,size: 20,color: Colors.white,),
                                ],
                              ),
                            ),
                          ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              //const CommonSubmitButton(title: "Continue"),
              Obx(
                () => TextButton(onPressed: controller.isSaveRegistrationData.value == false ? null :   (){
                  Get.to(() => LoginScreen());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: controller.isSaveRegistrationData.value ? Palette.btnGradientColor : Palette.btnGradientColorLight,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: const [
                       BoxShadow(
                        color: Palette.btnBoxShadowColor,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: const Center(
                    child: Text("Continue",
                          style: TextStyle(
                          fontFamily: Palette.layoutFont,
                          fontWeight: Palette.btnFontWeight,
                          fontSize: Palette.btnFontsize,
                          color: Palette.btnTextColor,
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
    );
  }
}