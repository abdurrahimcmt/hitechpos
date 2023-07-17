import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/widgets/common_submit_button.dart';
import 'package:hitechpos/widgets/curb_button.dart';

import '../../controllers/login_controller.dart';

class RegistrationKeyScreen extends StatelessWidget {
 const RegistrationKeyScreen({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
      Size size = MediaQuery.of(context).size;
      return SingleChildScrollView(
        child: Container(
        decoration: Palette.containerCurbBoxdecoration,
        height: size.height*0.80,
         child: Padding(
           padding: const EdgeInsets.all(20.0),
           child: Form(
            key: loginController.registrationFormKey,
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
                    value: loginController.selectedSchema.value,
                    items: loginController.schemaValueList.map(
                        (e) => DropdownMenuItem(value: e, child: Text(e))
                    ).toList(), 
                    validator: (value) {
                      if(value! == "Select schema"){
                        loginController.registrationSchemaFocus.requestFocus();
                        return "Please select schema";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      loginController.setSelectedSchema(val!) ;
                      loginController.isRegistrationSuccessfull(false);
                    }
                  ),
                  
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  focusNode: loginController.registrationPortFocus,
                  controller: loginController.registrationPortController,
                  onChanged: (value) {
                    loginController.isRegistrationSuccessfull(false);
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
                      loginController.registrationPortFocus.requestFocus();
                      return "Please enter port";
                    }
                    return null;
                  },
                ),
      
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  focusNode: loginController.registrationDomainFocus,
                  controller: loginController.registrationDomainController,
                  onChanged: (value) {
                    loginController.isRegistrationSuccessfull(false);
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
                      loginController.registrationDomainFocus.requestFocus();
                      return "Please enter Domain";
                    }
                    return null;
                  },
                ),
                
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  focusNode: loginController.registrationKeyFocus,
                  controller: loginController.registrationKeyController,
                  onChanged: (value) {
                    loginController.isRegistrationSuccessfull(false);
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
                      loginController.registrationKeyFocus.requestFocus();
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
                          if(loginController.registrationFormKey.currentState!.validate()){
                            loginController.registrationTest(loginController.registrationKeyController.text);
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
                          onPressed: loginController.isRegistrationSuccessfull.value ? (){ 
                            loginController.saveRegistrationInformationInLocal(
                              loginController.selectedSchema.value,
                              loginController.registrationDomainController.text,
                              loginController.registrationPortController.text,
                              loginController.registrationKeyController.text
                            );
                          } : null, 
                          child: Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0),
                              child: Container(
                                  width: size.width,
                                  height: 50,
                                  decoration:  BoxDecoration(
                                    gradient: loginController.isRegistrationSuccessfull.value? Palette.btnGradientColor : Palette.btnGradientColorLight,
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
                const CommonSubmitButton(title: "Continue"),
              ],
                   ),
           ),
        ),
          ),
      );
  }
}