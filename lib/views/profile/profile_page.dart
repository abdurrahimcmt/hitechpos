import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/userdetails_controller.dart';

class ProfilePage extends GetView<UserDetailsController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.bgColorPerple,
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: controller.userInfoList.value.vFullName.isNotEmpty ? SingleChildScrollView(
          child: Container(
            height: size.height,
            decoration: const BoxDecoration(
              gradient: Palette.bgGradient,
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                if(controller.userInfoList.value.vUserImage != "0")
                Container(
                height: 200.0,
                width: 200.0,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(controller.userInfoList.value.vUserImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 5, color: Colors.white),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                ),
                if(controller.userInfoList.value.vUserImage == "0")
                Container(
                height: 200.0,
                width: 200.0,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 5, color: Colors.white),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 80,
                    color: Palette.iconBackgroundColorPurple,
                  ),
                ),
                
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.userInfoList.value.vFullName.toUpperCase(),
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: Palette.layoutFont),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  controller.userInfoList.value.vRoleName.toUpperCase(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding:
                        const EdgeInsets.only(left: 8.0, bottom: 4.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          controller.userInfoList.value.vUserTypeName,
                            style: TextStyle(
                            fontFamily: Palette.layoutFont,
                            fontSize: Palette.contentTitleFontSizeL,
                            fontWeight: FontWeight.w700,
                            color: Palette.textColorPurple
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ...ListTile.divideTiles(
                                    color: Colors.grey,
                                    tiles: [
                                      // const ListTile(
                                      //   contentPadding: EdgeInsets.symmetric(
                                      //       horizontal: 12, vertical: 4),
                                      //   leading: Icon(Icons.my_location),
                                      //   title: Text("Location"),
                                      //   subtitle: Text("Bangladesh"),
                                      // ),
                                      ListTile(
                                        leading: Icon(Icons.phone,color: Palette.bgColorPerple,),
                                        title: Text("Phone Number",
                                          style: TextStyle(
                                            fontFamily: Palette.layoutFont,
                                            fontWeight: FontWeight.w600,
                                            color: Palette.textColorLightPurple
                                          ),
                                        ),
                                        subtitle: Text(controller.userInfoList.value.vMobileNo),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.email),
                                        title: Text("Email",
                                            style: TextStyle(
                                            fontFamily: Palette.layoutFont,
                                            fontWeight: FontWeight.w600,
                                            color: Palette.textColorLightPurple
                                          ),
                                        ),
                                        subtitle:
                                            Text(controller.userInfoList.value.vEmailId),
                                      ),
                                      // const ListTile(
                                      //   leading: Icon(Icons.person),
                                      //   title: Text("About Me"),
                                      //   subtitle: Text(
                                      //       "This is a about me link and you can khow about me in this section."),
                                      // ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ) : Center(
          child: SpinKitCircle(
            size: 140,
            color: Colors.purpleAccent,
          ),
        ),
      ),
    );
  }
}
