import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sara_music/Screens/Profile.dart';
import 'package:sara_music/Screens/bottom_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as file;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart' as Path;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sara_music/Teacher/Tbottom_bar.dart';
import 'package:sara_music/globalss.dart';


import '../Screens/Settings_Page.dart';


class TEdit_Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TEdit_ProfileState();
  }
}

class TEdit_ProfileState extends State<TEdit_Profile> {
     late TextEditingController About = TextEditingController(text:"${About1}");
    late TextEditingController Education = TextEditingController(text: "${Education1}");
        late TextEditingController Name = TextEditingController(text: "${NAME1}");
   late file.File imagepicker;
     late Future upload = Upload(imagepicker);
     late Future img;
     late Future N;
     late Future A;
     late Future E;
     late Future all;
  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagepicker = image;
                    Upload(imagepicker);

    });
  }
   var NAME1="";
  Future  SETNAME1() async{
    
    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/name"),headers: {
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
  


    var About1="";
  Future  SETABOUT1() async{
    
    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/About"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
     print(res.statusCode);
  if(res.statusCode==201){
    if(mounted){
 setState(() {
     About1=res.body;
    });
    }
   
  }
   
    return About1;
  }


      var Education1="";
  Future  SETEDUCATION1() async{
    
    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/Education"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
     print(res.statusCode);
  if(res.statusCode==201){
    if(mounted){
 setState(() {
     Education1=res.body;
    });
    }
   
  }
   
    return Education1;
  }

  Future ALL() async{
await SETNAME1();
await SETABOUT1();
await SETEDUCATION1();

  }
 void initState(){
    super.initState();
    N=SETNAME1();
    A=SETABOUT1();
    E=SETEDUCATION1();
    img=image2();
    all =ALL();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: InkWell(
                    child: Image.asset(
                      'images/icons-back.png',
                      height: 30,
                    ),
                    onTap: () {
                      Navigator.pop(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          alignment: Alignment.topCenter,
                          child: bottom_bar(),
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                  child: Text(
                    'Edit Profile',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.black),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 15, left: 130),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Settings_Page()));
                      },
                      icon: Icon(Icons.settings),
                      alignment: Alignment.centerRight,
                      iconSize: 30,
                    )),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Waitforme(),
          
            SizedBox(
              height: 40,
            ),
            Center(
              child: Waitforme1()
            ),
          ],
        ),
      ),
    );
    
  }
   Widget Waitforme() {
  
  return FutureBuilder( future: img, builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
          Center(
              child: CircleAvatar(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => getImageFromGallery(),
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 46, 23, 172),
                      radius: 25,
                      child: Icon(Icons.edit,color: Colors.white,),
                    ),
                  ),
                ),
                radius: 90,
                backgroundImage: MemoryImage(base64Decode(image1))
              ),
            );
  

  }));
}

 Widget Waitforme1() {
  
  
  return FutureBuilder(future: Future.wait([all]), builder:((context, snapshot)  {
    if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
              print(snapshot.error.toString());
         }      
     return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: Name,
                            
                            decoration: InputDecoration(
                              
                              labelText: "Username",
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 4),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 46, 23, 172), width: 5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: About,
                            decoration: InputDecoration(
                              labelText: "About",
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 4),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 46, 23, 172), width: 5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: Education,
                            decoration: InputDecoration(
                              labelText: "Education",
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 4),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 46, 23, 172), width: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      RaisedButton(
                        onPressed: () {save();},
                        color: Color.fromARGB(255, 46, 23, 172),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              );

  }));
}
 void _displayErrorMotionToast3() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please Fill Up All Fields !'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

 void _displayErrorMotionToast4() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Username is already used!!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

   void _displayErrorMotionToast1() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Profile Updated!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  Future<void> save() async{
   

      var body1 = jsonEncode({
    'name': Name.text,    
  'About': About.text,
  'Education':Education.text,
     });
              
    var res= await http.patch(Uri.parse(globalss.IP+"/Ttasks/me"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globalss.authToken 

  }, body: body1);
    
          Map<String,dynamic> DB = jsonDecode(res.body);
          print(res.body);
         
    
     if(Name.text.isNotEmpty&&About.text.isNotEmpty&&Education.text.isNotEmpty){

        if(res.statusCode==400){
 

           return _displayErrorMotionToast4();
           
           }

           if(res.statusCode==200){
                          globalss.TeacherName=Name.text;

                    
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Tbottom_bar()),
            );
              return _displayErrorMotionToast1();
     }
     else{
       print(res.body);
     }
 
    }
    else{
        return _displayErrorMotionToast3();
    }
 
  }
   Future Upload(File imageFile) async {    
  var stream  = new http.ByteStream(imageFile.openRead());
stream.cast();
      var length = await imageFile.length();

      var uri = Uri.parse(globalss.IP+"/teachers/avatar");

     var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile('upload', stream, length,
          filename: Path.basename(imageFile.path));
          Map<String, String> headers = {
             'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 
          };
                      request.headers["token"]=globalss.authToken;
                      request.headers["Content-Type"]='application/json; charset=UTF-8';


request.headers.addAll(headers);

      request.files.add(multipartFile);
      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
      });
    }
var image1="";
      Future image2() async{
var body1 = jsonEncode({
  "name": globalss.TeacherName
});

var res= await http.post(Uri.parse(globalss.IP+"/teachers/avatar1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  }, body: body1);

if(res.statusCode==200) {
  setState(() {
    image1 = res.body;
  });

}
return await image1;
  }

}
