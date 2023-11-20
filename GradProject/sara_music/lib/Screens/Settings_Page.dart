import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sara_music/Screens/About.dart';
import 'package:sara_music/Screens/Change_Password.dart';
import 'package:sara_music/globalss.dart';
import 'dart:convert';
import 'package:sara_music/authi/login.dart';

import 'package:http/http.dart' as http;

import 'Help.dart';

class Settings_Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Settings_PageState();
  }
}

class Settings_PageState extends State<Settings_Page> {
  @override
     var NAME1="";
  
   late Future N;
 
   late Future all;
   late Future Img;

     Future  SETNAME1() async{
    
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/name"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
     print(res.statusCode);
  if(res.statusCode==201){
    if(mounted){
 setState(() {
     NAME1=res.body;
    });
    }
   
  }
   
    return NAME1;
  }
  Future  logout() async{
    
    var res= await http.post(Uri.parse(globalss.IP+"/users/logout"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
  if(res.statusCode==200){
    if(mounted){
     print(res.statusCode);

 Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                               Login ()));
    }
   
  }
   
  }

    var image1="";
Future image2() async{
  try{
var body1 = jsonEncode({
  "name": globalss.StudentName
});

var res= await http.post(Uri.parse(globalss.IP+"/users/avatar1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  }, body: body1);

if(res.statusCode==200) {
  setState(() {
    image1 = res.body;
  });

}

  }catch(e){
    print(e);
  }

return await image1;

  }
    Future All() async{
    await SETNAME1();

    await image2();
    
  }
  void initState(){
    super.initState();
      N=SETNAME1();

    Img=image2();
    all =All();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.94),
      appBar: AppBar(
        leading: InkWell(
          child: Image.asset(
            'images/icons-back.png',
            scale: 1.5,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Settings",
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SimpleUserCard(
              userName: "${NAME1}",
              userProfilePic: MemoryImage(base64Decode(image1)),
            ),
            SettingsGroup(
              items: [ 
                
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Help()));
                  },
                  icons: FontAwesomeIcons.solidComment,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.yellow,
                  ),
                  title: 'Help & Supports',
                  subtitle: "Contact us",
                ),                                 
                SettingsItem(
                  onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => About()));
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about Do Re Mi Music Center",
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {
                    logout();
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                SettingsItem(
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>ChangePassword()));},
                  icons: Icons.repeat,
                  title: "Change password",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.delete_rounded,
                  title: "Delete account",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
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
