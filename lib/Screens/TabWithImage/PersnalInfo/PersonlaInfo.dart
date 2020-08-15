import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/wigets/PersonalProfileContent.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[


            PersonalProfileContent(hint:personalDescription ,text: "عنوان فارغ عنوان فارغ"),
            PersonalProfileContent(hint:personalDescription ,text: "عنوان فارغ عنوان فارغ"),
            PersonalProfileContent(hint:socialStatus,text:" عنوان فارغ عنوان فارغ"),
            PersonalProfileContent(hint:country ,text: " عنوان فارغ عنوان فارغ"),
            PersonalProfileContent(hint: work,text: " عنوان فارغ عنوان فارغ"),
            PersonalProfileContent(hint:dreamsDone ,text:" عنوان فارغ عنوان فارغ" ),
            PersonalProfileContent(hint: dreamsPending,text:" عنوان فارغ عنوان فارغ" ),
            PersonalProfileContent(hint: speen,text:" عنوان فارغ عنوان فارغ" ),
            PersonalProfileContent(hint: dreamsPerDay,text:" عنوان فارغ عنوان فارغ" ),

          ],
        ),
      ) ,
    );
  }
}
