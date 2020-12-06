import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/PaymentRecord/PaymentRecordPage.dart';
import 'package:faserholmak/MyServices/MySericesPage.dart';
import 'package:faserholmak/Screens/AllProvidersPage/AllProvidersPage.dart';
import 'package:faserholmak/Screens/ChatForPublic/ChatForPublic.dart';
import 'package:faserholmak/Screens/EditProfile/EditProfileClient/EditProfileClient.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/Screens/Login/login_screen.dart';
import 'package:faserholmak/Screens/SelectUserType/SelectUserType.dart';
import 'package:faserholmak/Screens/ServicesForClient/OnProgressServicesClient/OnProgressServicesClient.dart';
import 'package:faserholmak/Screens/ServicesYouWant/ServiceYouWant.dart';
import 'package:faserholmak/Screens/contactWithUs/ContactWithUs.dart';
import 'package:faserholmak/Screens/privacyPolicy/PrivacyPolicyPage.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:faserholmak/wigets/MyCircularImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';


import '../../constants.dart';
import 'package:faserholmak/Helper/Content.dart';

import '../ServicesForClient/CompletedServicesClient/CompletedServicesClient.dart';


class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isExpaded=false;


  @override
  void initState() {
    super.initState();
    isExpaded=false;
  }



  Widget showImage(){

    if(emptyString(userInfo.socialStatus)==FACEBOOK||emptyString(userInfo.socialStatus)==GOOGLE)
      return Container();
    else{
      if(userInfo.pictureId==null||userInfo.pictureId=='null') return LogoIcon();
          else return
      MyCircularImage(150,150,linkImg: '$imageUrl${emptyString(userInfo.pictureId)}',);}
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

                  SizedBox(height: 40,),
                   showImage(),
                  SizedBox(height: 20,),
                  Row(
                    children: <Widget>[
                      Expanded(child: Text(userInfo.name,
                        style: getTextSyle(16, kPrimaryColor,fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                    ],
                  ),
                 // SizedBox(height: 20,),
                 // LogoIcon(),
                  Container(


                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[



                        GestureDetector(
                          onTap: (){
                            openPageAndClearPrev(context:context,page: GeneralPageClient(),route: HomePageRoute);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.home,color:  kPrimaryColor),),
                              Text(homePage,style: getTextSyle(16, kPrimaryColor),)
                            ],
                          )),
                        ),

                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),


                        (emptyString(userInfo.socialStatus)==GOOGLE||emptyString(userInfo.socialStatus)==FACEBOOK)?
                            Container():
                        GestureDetector(
                          onTap: (){
                            openPage(context, EditProfileClient());
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
                        (emptyString(userInfo.socialStatus)==GOOGLE||emptyString(userInfo.socialStatus)==FACEBOOK)?
                        Container():
                        Divider(
                          color:  Colors.grey,
                          thickness: 1,
                        ),
                     GestureDetector(
                       onTap: (){
                         openPage(context, ServiceYouWant());
                       },
                       child: Container(
                          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                          ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){

                              },icon: Icon(Icons.add_box,color: kPrimaryColor,),),
                              Text(serviceRequest,style: getTextSyle(16, kPrimaryColor),)
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

                            openPage(context, MySericesPage());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.account_circle,color: kPrimaryColor),),
                              Text(myServices,style: getTextSyle(16, kPrimaryColor),)
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

                            openPage(context, CompletedServicesClient());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.done,color: kPrimaryColor,),),
                              Text(completedServices,style: getTextSyle(16, kPrimaryColor),)
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
                            openPage(context, OnProgressServicesClient());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.timelapse,color: kPrimaryColor,),),
                              Text(servicesInProgress,style: getTextSyle(16, kPrimaryColor),)
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

                        /*serviceProviders*/
                        GestureDetector(
                          onTap: (){
                            openPage(context,AllProvidersPage());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.people,color: kPrimaryColor,),),
                              Text(serviceProviders,style: getTextSyle(16, kPrimaryColor),)
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
                              Text(privacyPolicy,style: getTextSyle(16, kPrimaryColor),)
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

                            openPage(context,ChatForPublic());
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.chat,color:  kPrimaryColor),),
                              Text(audienceChat,style: getTextSyle(16, kPrimaryColor),)
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

                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.rate_review,color:  kPrimaryColor),),
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
                              IconButton(onPressed: (){},icon: Icon(Icons.share,color: kPrimaryColor,),),
                              Text(shareApp,style: getTextSyle(16, kPrimaryColor),)
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
                              Text(cotactWithUsTxt,style: getTextSyle(16, kPrimaryColor),)
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
                             openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page: LoginScreen());

                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                              ,child: Row(
                            children: <Widget>[
                              IconButton(onPressed: (){},icon: Icon(Icons.assignment_return,color: kPrimaryColor,),),
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
