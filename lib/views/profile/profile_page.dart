import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  // ignore: unused_field
  final double _drawerIconSize = 24;
  // ignore: unused_field
  final double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.bgColorPerple,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
              Container(
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
                'Jafor'.toUpperCase(),
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: Palette.layoutFont),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Admin'.toUpperCase(),
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
                      child: const Text(
                        "Contacts",
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
                                    // const ListTile(
                                    //   leading: Icon(Icons.email),
                                    //   title: Text("Email"),
                                    //   subtitle:
                                    //       Text("abdurrahimcmt@gmail.com"),
                                    // ),
                                    const ListTile(
                                      leading: Icon(Icons.phone,color: Palette.bgColorPerple,),
                                      title: Text("Phone Number",
                                        style: TextStyle(
                                          fontFamily: Palette.layoutFont,
                                          fontWeight: FontWeight.w600,
                                          color: Palette.textColorLightPurple
                                        ),
                                      ),
                                      subtitle: Text("0888948"),
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
      ),
    );
  }
}
