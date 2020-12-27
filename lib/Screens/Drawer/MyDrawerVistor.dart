import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/Login/login_screen.dart';
import 'package:faserholmak/Screens/SelectUserType/SelectUserType.dart';
import 'package:faserholmak/Screens/ServicesForClient/OnProgressServicesClient/OnProgressServicesClient.dart';
import 'package:faserholmak/Screens/ServicesForVisitor/CompletedServicesVisitor/CompletedServicesVisitor.dart';
import 'package:faserholmak/Screens/ServicesForVisitor/OnProgressServiceVisitor/OnProgressServiceVisitor.dart';
import 'package:faserholmak/Screens/contactWithUs/ContactWithUs.dart';
import 'package:faserholmak/Screens/privacyPolicy/PrivacyPolicyPage.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:flutter/material.dart';


import '../../app_localizations.dart';
import '../../constants.dart';
import 'package:faserholmak/Helper/Content.dart';

import '../ServicesForClient/CompletedServicesClient/CompletedServicesClient.dart';


class MyDrawerVistor extends StatefulWidget {
  @override
  _MyDrawerVistorState createState() => _MyDrawerVistorState();
}

class _MyDrawerVistorState extends State<MyDrawerVistor> {
  bool isExpaded=false;


  @override
  void initState() {
    super.initState();
    isExpaded=false;
  }

  @override
  Widget build(BuildContext context) {


    double width = MediaQuery.of(context).size.width;
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    double height;

    if (aspectRatio >= 1.0) {
      height = width / (aspectRatio * 2);
    } else {
      height = width / 1.5;
    }



    return Theme(
        data: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,

        ),
        child: Drawer(
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  LogoIcon(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                     GestureDetector(
                       onTap: (){
                         showToast(youHaveToLogin);
                         openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page:  LoginScreen());
                       },
                       child: Container(
                          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                          ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.add_box,color:  Colors.grey,),),
                              Text(AppLocalizations.of(context).translate("serviceRequest"),style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                     ),

                     Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),



                        /*completedServices*/
                        GestureDetector(
                          onTap: (){
                            openPage(context, CompletedServiceVisitor());
                           // openPage(context, CompletedServicesClient());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){

                              },icon: Icon(Icons.done,color:  Colors.grey,),),
                              Text(AppLocalizations.of(context).translate("completedServices"),style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),

                        /*servicesInProgress*/
                        GestureDetector(
                          onTap: (){
                            openPage(context, OnProgressServiceVisitor());
                           // openPage(context, OnProgressServicesClient());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.timelapse,color:  Colors.grey,),),
                              Text(AppLocalizations.of(context).translate("servicesInProgress"),style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),
                        /*serviceProviders*/
                        GestureDetector(
                          onTap: (){
                            showToast(youHaveToLogin);
                            openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page:  LoginScreen());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.people,color:  Colors.grey,),),
                              Text(AppLocalizations.of(context).translate("serviceProviders"),style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),
                        /*audienceChat*/
                        GestureDetector(
                          onTap: (){
                            showToast(youHaveToLogin);
                            openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page:  LoginScreen());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.chat_bubble_outline,color:  Colors.grey,),),
                              Text(AppLocalizations.of(context).translate("audienceChat"),style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),

                        GestureDetector(
                          onTap: () async {


                            openPage(context,PrivacyPolicyPage());


                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.collections_bookmark,color:  kPrimaryColor),),
                              Text(AppLocalizations.of(context).translate("privacyPolicy"),style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),

                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),

                        /*shareApp*/
                        GestureDetector(
                          onTap: (){
                            showToast(youHaveToLogin);
                            openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page:  LoginScreen());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.star_half,color:  Colors.grey,),),
                              Text(AppLocalizations.of(context).translate("rateApplication"),style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),


                        /*shareApp*/

                        GestureDetector(
                          onTap: (){
                            showToast(youHaveToLogin);
                            openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page:  LoginScreen());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.share,color:  Colors.grey,),),
                              Text(AppLocalizations.of(context).translate("shareApp"),style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),



                        /*contact with us*/
                        GestureDetector(
                          onTap: () async {
                            openPage(context, ContactWithUs());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.contacts,color: kPrimaryColor,),),
                              Text(AppLocalizations.of(context).translate("cotactWithUsTxt"),style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),

                   /*     *//*logout*//*
                        GestureDetector(
                          onTap: () async {

                             setToken("");
                             setEmail("");
                             setPassword("");
                             openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page: SelectUserType());

                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.account_circle,color:  Colors.grey,),),
                              Text(logout,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),*/




                        /*rateApplication*/
                      ],
                    ),
                  )



                ],
              ),
            ),
          ),
        ));
  }


}
