import 'dart:io';

import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/HowAppWork/HowAppWork.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';


import '../app_localizations.dart';

class InfoBeforHireMe extends StatefulWidget {
  @override
  _InfoBeforHireMeState createState() => _InfoBeforHireMeState();
}

class _InfoBeforHireMeState extends State<InfoBeforHireMe> {

  void launchWhatsApp(
      {@required String phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }


  _launchURL({String toMailId, String subject, String body}) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("howAppWork"),style: getTextSyle(16, Colors.white),),
      ),

      body: SafeArea(

        child:SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                Text(AppLocalizations.of(context).translate("CurrentlyAvailableJobs"),style: getTextSyle(20, Colors.black),),
                SizedBox(height: 4,),
                Text(AppLocalizations.of(context).translate("InterpreterDreams"),style: getTextSyle(16, Colors.black),),
                SizedBox(height: 4,),
                Text(AppLocalizations.of(context).translate("LegalMufti"),style: getTextSyle(16, Colors.black),),
                SizedBox(height: 4,),
                Text(AppLocalizations.of(context).translate("LegitClassy"),style: getTextSyle(16, Colors.black),),
                SizedBox(height: 4,),
                Text(AppLocalizations.of(context).translate("MedicalAdvisor"),style: getTextSyle(16, Colors.black),),
                SizedBox(height: 4,),
                Text(AppLocalizations.of(context).translate("Counsel"),style: getTextSyle(16, Colors.black),),
                SizedBox(height: 4,),
                Text(AppLocalizations.of(context).translate("FamilyCounselor"),style: getTextSyle(16, Colors.black),),
                SizedBox(height: 4,),
                Text(AppLocalizations.of(context).translate("hint_1_callUs"),
                  style: getTextSyle(16, Colors.black),textAlign: TextAlign.center,),
                Text(AppLocalizations.of(context).translate("hint_2_callUs"),
                  style: getTextSyle(16, Colors.black),textAlign: TextAlign.center,),


//                <key>LSApplicationQueriesSchemes</key>
//<array>
//  <string>whatsapp</string>
//</array>
              /*  SizedBox(height: 4,),
                Row(
                  children: [
                    MyButton(txt: "تواصل معنا عبر واتس",textStyle: getTextSyle(16, Colors.white),press: (){

                      //+971505018450
                      launchWhatsApp(phone: "+971555661133", message: "مرحبا ");
                    },raduis: 4,),
                    SizedBox(width: 4,),
                    MyButton(txt: "تواصل معنا عبر الايميل",textStyle: getTextSyle(16, Colors.white),press: (){

                      _launchURL(toMailId: "FSRHILMAK@GMAIL.COM",subject: "رسالة من مفسر الى الادارة في تطبيق اهل الذكر",
                      body: "");

                    },raduis: 4,),
                  ],
                ),*/

                SizedBox(height: 20,),
                MyButton(txt:AppLocalizations.of(context).translate("continueTxt"),textStyle: getTextSyle(16, Colors.white),press: (){

                  openPage(context, HowAppWork.interprete());

                },raduis: 4,),


              ],
            ),
          ),
        )

      ),
    );
  }
}
