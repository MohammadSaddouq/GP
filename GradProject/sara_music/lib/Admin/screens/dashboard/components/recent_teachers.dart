import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sara_music/Admin/screens/home/home_screen.dart';
import 'package:shape_of_view_null_safe/generated/i18n.dart';

import '../../../core/constants/color_constants.dart';

import '../../../core/utils/colorful_tag.dart';
import '../../../models/recent_user_model.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sara_music/globalss.dart';

class RecentTeacher extends StatefulWidget {
  const RecentTeacher({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentTeacher> createState() => _RecentTeacherState();
}

class _RecentTeacherState extends State<RecentTeacher> {
        List recentUsers2=[];
late Future c;
  late Future N;
  late Future R;
  late Future I;
  late Future E;
      late Future D;
TextEditingController A = TextEditingController();
Future DeleteTeacher(var name) async{
  var body1 = jsonEncode({
   "name":name.toString(),
   

  });
var res= await http.post(Uri.parse(globalss.IP+"/teachers/DeleteTeacher"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
if(mounted){
if(res.statusCode==200) {
  _displayErrorMotionT5(context);

}
else{
    _displayErrorMotionT6(context);

}
}

  }

   void _displayErrorMotionT5(BuildContext context) {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This Teacher is deleted sucessfully'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  void _displayErrorMotionT6(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("This Teacher doesn't exist!"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }


Future UpdateName(var name,var a) async{
  var body1 = jsonEncode({
   "NName":name.toString(),
   "name":a.toString()

  });
var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/UpdateName"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
if(mounted){
if(res.statusCode==200) {
   Navigator.pushAndRemoveUntil(
  			context,
  			MaterialPageRoute(builder: (context) => HomeScreen()), // this mymainpage is your page to refresh
  			(Route<dynamic> route) => false,
		);
  _displayErrorMotionT2(context);

}
else{
    _displayErrorMotionT3(context);

}
}

  }

Future UpdateSalary(var name, var S) async{
  var body1 = jsonEncode({
   "name":name,
   "Salary" :S

  });
var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/UpdateSalary"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);

if(mounted){
if(res.statusCode==200) {
   Navigator.pushAndRemoveUntil(
  			context,
  			MaterialPageRoute(builder: (context) => HomeScreen()), // this mymainpage is your page to refresh
  			(Route<dynamic> route) => false,
		);
  _displayErrorMotionT(context);

}
else{
    _displayErrorMotionT1(context);

}
}

  }

Future UpdateCourse(var name, var coursename) async{
  var body1 = jsonEncode({
   "NName":name,
   "instrument" :coursename

  });
  print(body1);
var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/UpdateCourse"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);

if(mounted){
if(res.statusCode==200) {
  Navigator.pushAndRemoveUntil(
  			context,
  			MaterialPageRoute(builder: (context) => HomeScreen()), // this mymainpage is your page to refresh
  			(Route<dynamic> route) => false,
		);

  
  _displayErrorMotionToast(context);

}
else if(res.body=="Not Exist"){
_displayErrorMotionToast10(context);
}
else {
    _displayErrorMotionToast1(context);

}
}
  }
var  Count="0";
Future StudentsCount() async{
var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/TeachersCount"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });

if(mounted){
if(res.statusCode==200) {
  setState(() {
    Count = res.body;
  });

}
}
return await Count;
  }

   void _displayErrorMotionT2(BuildContext context) {
    MotionToast.success(
      title: Text(
        'Sucess',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('The Name is updated :)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionT3(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This name already userd, try another one!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionToast10(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("This Course Doesn't exist!"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
 void _displayErrorMotionToast(BuildContext context) {
    MotionToast.success(
      title: Text(
        'Sucess',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('The course is updated :)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionToast1(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('The teacher already signed to this course!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  
  }
   void _displayErrorMotionT1(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("The teacher doesn't exist"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionT(BuildContext context) {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("Teacher's salary is updated"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

var Name="";
var arr;
var NameList=[];
  Future StudentName() async{
var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/TeachersNames"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
if(res.statusCode==200) {
  setState(() {
    Name = res.body;
  });

}
}
    var Name1 = Name.toString();
      arr=Name1.split(",");
      for(int i = 0; i<int.parse(Count);i++){
      NameList.add(arr[i]);

}
return await NameList;
  }

  //
var InstrumentName="";
var arrI;
var InstrumentsList=[];
  Future StudentInstrument() async{
var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/TeacherInstrument"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
if(res.statusCode==200) {
  setState(() {
    InstrumentName= res.body;
  });
}
}

    var InstrumentName1 = InstrumentName.toString();
      arrI=InstrumentName1.split(",");
      for(int i = 0; i<int.parse(Count);i++){
      InstrumentsList.add(arrI[i]);

}
return await InstrumentsList;
  }


  //


  //
var Email="";
var arrE;
var EmailsList=[];
  Future StudentEmail() async{
var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/TeacherEmail"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
if(res.statusCode==200) {
  setState(() {
    Email= res.body;
  });
  }

}

    var Email1 = Email.toString();
      arrE=Email1.split(",");
      for(int i = 0; i<int.parse(Count);i++){
      EmailsList.add(arrE[i]);

}
return await EmailsList;
  }

  //


  var Ratings="";
var arrR;
var RatingsList=[];
  Future StudentRating() async{
var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/TeacherRatring"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
if(res.statusCode==200) {
  setState(() {
    Ratings= res.body;
  });

}
}

    var Ratings1 = Ratings.toString();
      arrR=Ratings1.split(",");
      for(int i = 0; i<int.parse(Count);i++){
      RatingsList.add(arrR[i]);

}


return await [RatingsList];
  }

  //
  Future Data() async{
    await StudentsCount();
    await StudentName();
    await StudentEmail();
    await StudentInstrument();
    await StudentRating();
    for(int j =0;j<int.parse(Count);j++){
   recentUsers2.add(
  RecentUser(
    
    icon: "images/icons/xd_file.svg",
    name: NameList[j],
    role: "${InstrumentsList[j]} Course",
    email: EmailsList[j],
    posts: RatingsList[j],
  ),
   );

}

return await [recentUsers2];
  }


  @override
  
  
  String? selectedValue;
  List<String> items = [
    'Teacher name',
    'Course',
    'Salary',
  ];
  @override
    void initState(){
    super.initState(); 
    c= StudentsCount();
      E=StudentEmail();
 
    N=StudentName();
    I=StudentInstrument();
    R=StudentRating();
    D=Data();
        selectedValue = items[0];

     }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Waitforme1()
    );
  }
  Widget Waitforme1() {
  return FutureBuilder( future:Future.wait([c,N,E,I,R,D]), builder:((context,  snapshot)  {

    if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
              print(snapshot.error.toString());
         }
         return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Users",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  horizontalMargin: 0,
                  showCheckboxColumn: true,
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("Teacher name"),
                    ),
                    DataColumn(
                      label: Text("Course"),
                    ),
                    DataColumn(
                      label: Text("E-mail"),
                    ),
                    // DataColumn(
                    //   label: Text("Number Of Students"),
                    // ),
                    DataColumn(
                      label: Text("Average Rate"),
                    ),
                    DataColumn(
                      label: Text("Operation"),
                    ),
                  ],
                  rows: List.generate(
                    recentUsers2.length,
                    (index) => recentUserDataRow(recentUsers2[index], context),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }));
  }

  DataRow recentUserDataRow(RecentUser userInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              TextAvatar(
                size: 35,
                backgroundColor: Colors.white,
                textColor: Colors.white,
                fontSize: 14,
                upperCase: true,
                numberLetters: 1,
                shape: Shape.Rectangle,
                text: userInfo.name!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  userInfo.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: getRoleColor(userInfo.role).withOpacity(.2),
              border: Border.all(color: getRoleColor(userInfo.role)),
              borderRadius: BorderRadius.all(Radius.circular(5.0) //
                  ),
            ),
            child: Text(userInfo.role!))),
        DataCell(Text(userInfo.email!)),
        // DataCell(Text(userInfo.date!)),
        DataCell(Text(userInfo.posts!)),
        DataCell(
          Row(
            children: [          
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.withOpacity(0.5),
                ),
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                         return StatefulBuilder(
                          builder: (BuildContext context, setState) {
                        return AlertDialog(
                            title: Center(
                              child: Text("Edit Teacher Info"),
                            ),
                            content: Container(
                              color: secondaryColor,
                              height: 300,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            Icon(
                                              Icons.list,
                                              size: 22,
                                              color: Color.fromARGB(
                                                  255, 12, 51, 113),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Select',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 66, 66, 66),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: items
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value as String?;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor:
                                            Color.fromARGB(255, 12, 51, 113),
                                        iconDisabledColor: Colors.grey,
                                        buttonHeight: 60,
                                        buttonWidth: 160,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          // borderRadius: BorderRadius.circular(14),
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: Color.fromARGB(
                                              255, 231, 241, 241),
                                        ),
                                        buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 14),
                                        dropdownMaxHeight: 200,
                                        dropdownWidth: 200,
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Color.fromARGB(
                                              255, 231, 241, 241),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 6,
                                        scrollbarAlwaysShow: true,
                                        offset: const Offset(-20, 0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: Form(
                                      child: TextFormField(
                                        controller: A,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.data_array_outlined,
                                            color: Color.fromARGB(
                                                255, 12, 51, 113),
                                          ),
                                          labelText: "$selectedValue",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 4),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 12, 51, 113),
                                                width: 5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.edit,
                                            size: 14,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.blue),
                                          onPressed: () {
                                            if(selectedValue=="Course"){
                                                UpdateCourse(userInfo.name,A.text);
                                            }
                                            else if(selectedValue=="Salary"){
                                              UpdateSalary(userInfo.name,A.text);
                                            }
                                            else if(selectedValue=="Teacher name"){
                             
                                                 UpdateName(userInfo.name,A.text);

                                            }
                                          },
                                          label: Text("Edit")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.close,
                                            size: 14,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.grey),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          label: Text("Cancel")),
                                    ],
                                  )
                                ],
                              ),
                            ));
                      });
                      });
                },
                // edit
                label: Text("Edit"),
              ),
              SizedBox(
                width: 6,
              ),
                ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red.withOpacity(0.5),
                ),
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                            title: Center(
                              child: Text("Confirm Deletion"),
                            ),
                            content: Container(
                              color: secondaryColor,
                              height: 120,
                              child: Column(
                                children: [
                                  Text(
                                      "Are you sure want to delete '${userInfo.name}'?"),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.delete,
                                            size: 14,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red),
                                          onPressed: () {
                                            DeleteTeacher(userInfo.name);
                                          },
                                          label: Text("Delete")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.close,
                                            size: 14,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.grey),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          label: Text("Cancel")),
                                    ],
                                  )
                                ],
                              ),
                            ));
                      });
                },
                // Delete
                label: Text("Delete"),
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}
