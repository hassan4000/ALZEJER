

import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/PaymentRecord/PaymentRecordPage.dart';
import 'package:faserholmak/Model/UserInfoModel/UserInfoModel.dart';
import 'package:faserholmak/Screens/ChatForPublic/ChatForPublic.dart';
import 'package:faserholmak/Screens/ChatsForMofaser/ChatForMofaser.dart';
import 'package:faserholmak/Screens/EditProfile/EditProfileMofaser/EditProfileMofaser.dart';
import 'package:faserholmak/Screens/GeneralPageServicesProvider/GeneralPageServicesProvider.dart';
import 'package:faserholmak/Screens/Login/login_screen.dart';
import 'package:faserholmak/Screens/MofaserBalance/MofaserBalance.dart';
import 'package:faserholmak/Screens/SelectUserType/SelectUserType.dart';
import 'package:faserholmak/Screens/ServicesForClient/OnProgressServicesClient/OnProgressServicesClient.dart';
import 'package:faserholmak/Screens/ServicesForServiceProviders/CompletedServiceServiceProviders/CompletedServiceServiceProviders.dart';
import 'package:faserholmak/Screens/ServicesForServiceProviders/OnProgressServiceServiceProviders/OnProgressServiceServiceProviders.dart';
import 'package:faserholmak/Screens/ServicesForServiceProviders/PublicServiceServiceProviders/PublicServiceServiceProviders.dart';
import 'package:faserholmak/Screens/TabWithImage/TabWithImage.dart';
import 'package:faserholmak/Screens/compititionMofaser/compitition_mofaser.dart';
import 'package:faserholmak/Screens/contactWithUs/ContactWithUs.dart';
import 'package:faserholmak/Screens/privacyPolicy/PrivacyPolicyPage.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:faserholmak/wigets/MyCircularImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


import '../../app_localizations.dart';
import '../../constants.dart';
import 'package:faserholmak/Helper/Content.dart';

import '../ServicesForClient/CompletedServicesClient/CompletedServicesClient.dart';


class MyDrawerServicsProvider extends StatefulWidget {
  @override
  _MyDrawerServicsProviderState createState() => _MyDrawerServicsProviderState();
}

class _MyDrawerServicsProviderState extends State<MyDrawerServicsProvider> {
  bool isLoading=false;



  void  setIsLoading(bool state){
    setState(() {
      isLoading=state;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading=false;
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

          child: ModalProgressHUD(
            inAsyncCall: isLoading,
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
                              openPageAndClearPrev(context:context,page: GeneralPageServicesProvider(),route: HomePageRoute2);
                              //   openPage(context, EditProfileMofaser());
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                                ,child: Row(
                              children: <Widget>[
                                IconButton(onPressed: (){},icon: Icon(Icons.home,color:  kPrimaryColor),),
                                Text(AppLocalizations.of(context).translate("homePage"),style: getTextSyle(16, kPrimaryColor),)
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
                              openPage(context, EditProfileMofaser());
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                                ,child: Row(
                              children: <Widget>[
                                IconButton(onPressed: (){},icon: Icon(Icons.mode_edit,color:  kPrimaryColor),),
                                Text(AppLocalizations.of(context).translate("editProfile"),style: getTextSyle(16, kPrimaryColor),)
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
                            onTap: () async {
                              setIsLoading(true);
                              var response=await getSingleUserInfo(id: userInfo.id);
                              if(response.statusCode==200){
                                UserInfoModel item=response.object;
                                openPage(context, TabWithImage(item));
                              }
                              setIsLoading(false);

                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                                ,child: Row(
                              children: <Widget>[
                                IconButton(onPressed: (){},icon: Icon(Icons.info_outline,color:  kPrimaryColor),),
                                Text(AppLocalizations.of(context).translate("moreInfo"),style: getTextSyle(16, kPrimaryColor),)
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
                                Text(AppLocalizations.of(context).translate("servicesInProgress"),style: getTextSyle(16, kPrimaryColor),)
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
                                Text(AppLocalizations.of(context).translate("completedServices"),style: getTextSyle(16, kPrimaryColor),)
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
                                Text(AppLocalizations.of(context).translate("balanceRecord"),style: getTextSyle(16, kPrimaryColor),)
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
                                Text(AppLocalizations.of(context).translate("publicServices"),style: getTextSyle(16, kPrimaryColor),)
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
                                Text(AppLocalizations.of(context).translate("chatProviders"),style: getTextSyle(16, kPrimaryColor),)
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


                  /*        GestureDetector(
                            onTap: () async {


                              openPage(context,CompititionMofaser(normalUser: true,));


                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                                ,child: Row(
                              children: <Widget>[
                                IconButton(onPressed: (){},icon: Icon(Icons.collections_bookmark,color:  kPrimaryColor),),
                                Text(comptiotn,style: getTextSyle(16, kPrimaryColor),)
                              ],
                            )),
                          ),

                          Divider(
                            color:  Colors.grey,
                            thickness: 1,
                          ),*/

                          GestureDetector(
                            onTap: (){

                              openPage(context, MofaserBalance());
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                                ,child: Row(
                              children: <Widget>[
                                IconButton(onPressed: (){},icon: Icon(Icons.account_balance_wallet,color:  kPrimaryColor),),
                                Text(AppLocalizations.of(context).translate("balanceTxt"),style: getTextSyle(16, kPrimaryColor),)
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
                            onTap: () async {
                              await FlutterShare.share(
                                  title: AppLocalizations.of(context).translate("pleaseShareThisLink"),

                                  text:
                                  '${AppLocalizations.of(context).translate("shareHitn1")}\n ${userInfo.userSpecialCode}',
                                  linkUrl:
                                  ' {${AppLocalizations.of(context).translate("linkApp")} \n  ${googlePlayUrl}',
                                  chooserTitle:
                                  'Share');
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0)
                                ,child: Row(
                              children: <Widget>[
                                IconButton(onPressed: (){},icon: Icon(Icons.share,color:  kPrimaryColor),),
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
                                Text(AppLocalizations.of(context).translate("logout"),style: getTextSyle(16, kPrimaryColor),)
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
          ),
        ));
  }


}
