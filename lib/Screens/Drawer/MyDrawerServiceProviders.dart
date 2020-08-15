import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/PaymentRecord/PaymentRecordPage.dart';
import 'package:faserholmak/Screens/ChatForPublic/ChatForPublic.dart';
import 'package:faserholmak/Screens/ChatsForMofaser/ChatForMofaser.dart';
import 'package:faserholmak/Screens/EditProfile/EditProfileMofaser/EditProfileMofaser.dart';
import 'package:faserholmak/Screens/Login/login_screen.dart';
import 'package:faserholmak/Screens/MofaserBalance/MofaserBalance.dart';
import 'package:faserholmak/Screens/SelectUserType/SelectUserType.dart';
import 'package:faserholmak/Screens/ServicesForClient/OnProgressServicesClient/OnProgressServicesClient.dart';
import 'package:faserholmak/Screens/ServicesForServiceProviders/CompletedServiceServiceProviders/CompletedServiceServiceProviders.dart';
import 'package:faserholmak/Screens/ServicesForServiceProviders/OnProgressServiceServiceProviders/OnProgressServiceServiceProviders.dart';
import 'package:faserholmak/Screens/ServicesForServiceProviders/PublicServiceServiceProviders/PublicServiceServiceProviders.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:faserholmak/wigets/MyCircularImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';


import '../../constants.dart';
import 'package:faserholmak/Helper/Content.dart';

import '../ServicesForClient/CompletedServicesClient/CompletedServicesClient.dart';


class MyDrawerServicsProvider extends StatefulWidget {
  @override
  _MyDrawerServicsProviderState createState() => _MyDrawerServicsProviderState();
}

class _MyDrawerServicsProviderState extends State<MyDrawerServicsProvider> {
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
                  SizedBox(height: 100,),
                 MyCircularImage(150,150,linkImg: '$imageUrl${emptyString(userInfo.pictureId)}',),
                  SizedBox(height: 20,),
                  Row(
                    children: <Widget>[
                      Expanded(child: Text(userInfo.name,
                        style: getTextSyle(16, kPrimaryColor,fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                    ],
                  ),
                  Container(


                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        GestureDetector(
                          onTap: (){
                            openPage(context, EditProfileMofaser());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.mode_edit,color:  kPrimaryColor),),
                              Text(editProfile,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),

                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),

                     GestureDetector(
                       onTap: (){
                         openPage(context, OnProgressServiceServiceProviders());
                       },
                       child: Container(
                          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                          ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.timelapse,color:  kPrimaryColor),),
                              Text(servicesInProgress,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                     ),

                     Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),

                        /*myServices*/
                        GestureDetector(
                          onTap: (){
                            openPage(context, CompletedServiceServiceProviders());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.done,color: kPrimaryColor),),
                              Text(completedServices,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),


                        GestureDetector(
                          onTap: (){

                            openPage(context, PaymentRecordPage());
                           //
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.attach_money,color:  kPrimaryColor),),
                              Text(balanceRecord,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),


                        GestureDetector(
                          onTap: (){

                            openPage(context, PublicServiceServiceProviders());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.perm_contact_calendar,color:  kPrimaryColor),),
                              Text(publicServices,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),

                        GestureDetector(
                          onTap: (){

                            openPage(context, ChatForMofaser());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.chat,color:  kPrimaryColor),),
                              Text(chatProviders,style: getTextSyle(16, kPrimaryColor),)
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

                            openPage(context, ChatForPublic());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.chat_bubble_outline,color:  kPrimaryColor),),
                              Text(audienceChat,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),

                        GestureDetector(
                          onTap: (){

                            openPage(context, MofaserBalance());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.account_balance_wallet,color:  kPrimaryColor),),
                              Text(balanceTxt,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),


                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),
                        /*shareApp*/
                        GestureDetector(
                          onTap: () async {

                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.star_half,color:  kPrimaryColor),),
                              Text(rateApplication,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),


                        /*shareApp*/

                        GestureDetector(
                          onTap: () async {
                            await FlutterShare.share(
                                title: 'يرجى مشاركة هذا الرابط ',

                                text:
                                '${shareHitn1}\n ${userInfo.userSpecialCode}',
                                linkUrl:
                                ' {$linkApp} \n  ${googlePlayUrl}',
                                chooserTitle:
                                'Share');
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.share,color:  kPrimaryColor),),
                              Text(shareApp,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),

                        /*logout*/
                        GestureDetector(
                          onTap: () async {
                            await openLogout(context);
                            await logOutFacebook();
                            signOutGoogle();
                            userInfo=null;
                            setToken("");
                            setEmail("");
                            setPassword("");
                            openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page:  LoginScreen());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.assignment_return,color:  kPrimaryColor),),
                              Text(logout,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),




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
