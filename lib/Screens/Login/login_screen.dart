


import 'dart:io';

import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/MyServices/MySericesPage.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/Screens/GeneralPageServicesProvider/GeneralPageServicesProvider.dart';
import 'package:faserholmak/Screens/HowAppWork/HowAppWork.dart';

import 'package:faserholmak/Screens/Login/components/body.dart';
import 'package:faserholmak/Screens/Signup/components/or_divider.dart';
import 'package:faserholmak/Screens/Signup/components/social_icon.dart';
import 'package:faserholmak/Screens/Signup/signup_screen.dart';
import 'package:faserholmak/Screens/TabWithImage/TabWithImage.dart';
import 'package:faserholmak/Screens/TabWithImage/TabWithImageHomePage.dart';
import 'package:faserholmak/Screens/TemrsPage/TermsPage.dart';
import 'package:faserholmak/Screens/code/Code.dart';
import 'package:faserholmak/Screens/informationBeforHireMe/InfoBeforHireMe.dart';
import 'package:faserholmak/Screens/privacyPolicy/PrivacyPolicyPage.dart';
import 'package:faserholmak/components/rounded_input_field.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as JSON;
import '../../constants.dart';
import 'components/background.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


 // AppsflyerSdk _appsflyerSdk;
  bool isLoading=false;
  var formKeyValidation = GlobalKey<FormState>();
  //TextEditingController userNameControler=TextEditingController(text: "kinan.3bbas23");
  TextEditingController userNameControler=TextEditingController();
//  TextEditingController passwordControler=TextEditingController(text:"123456");
  TextEditingController passwordControler=TextEditingController();
  bool erros=false;
  bool shildPasswrod = true;
  Map userProfileFacebook;

  void reSetShild() {
    setState(() {
      shildPasswrod = !shildPasswrod;
    });
  }

  Future<void> _loginWithGooleSignIn() async {

    signOutGoogle();
    try {
      setState(() {
        isLoading = true;
      });
      await googleSignIn.signIn();



      if(googleSignIn.currentUser != null){
        Response res = await createAccountSocial(initMapSocial(
            googleSignIn.currentUser.displayName,
            googleSignIn.currentUser.email, GOOGLE,
            googleSignIn.currentUser.id,
            googleSignIn.currentUser.photoUrl));


        if(res.statusCode == 200){
          loginPressSocila(initMapSocialLogin(
              password:googleSignIn.currentUser.id,
              email: googleSignIn.currentUser.displayName )
              ,social: true);
        }

        setState(() {
          isLoading = false;
        });

      }




    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error);
    }
  }
  _loginWithFB() async {

    await  logOutFacebook();
    try {
      final result = await facebookLogin.logIn(['email']);

      print(result.errorMessage);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final token = result.accessToken.token;
          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,picture.width(600).height(600),email&access_token=${token}');

          final profile = JSON.jsonDecode(graphResponse.body);


          userProfileFacebook = profile;
          print("--------------------------");
          print(userProfileFacebook);
          print("--------------------------");
          print(profile);

          String id = profile['id'];
          print(id);
          String email = profile['email'];
          print(email);
          String name = profile['name'];
          print(name);
          String imagePath = profile['picture']['data']['url'];
          print(imagePath);

          if (email == null) {
            email = id + '@gmail.com';
          }

             setState(() {
            isLoading = true;
          });
           Response res = await createAccountSocial(initMapSocial(name, email, FACEBOOK, id, imagePath));



          if(res.statusCode == 200){


            loginPressSocila(initMapSocialLogin(password:id,email: name ),social: true);




          }

          setState(() {
            isLoading = false;
          });


          break;

        case FacebookLoginStatus.cancelledByUser:
        /*  showMessage(context,
              'You can access TrussT by login with FB or by create new account');*/
          break;
        case FacebookLoginStatus.error:
          showToast( 'Some thing error, please try again');
          break;
      }
    } catch (exceptopn) {

      print('error');
      /*  setState(() {
        _isLoading = false;
      });*/

      showToast('Some thing error, please try again');
    }
  }

  Map<String,dynamic> initMapSocial(String name,String email,String type,String password,String image){
    Map<String,dynamic> data={
      "name":name,
      "email":email,
      "password":password,
      "confirmPassword":password,
    /*  "phoneNumber":selectedCountry.phoneCode+phoneController.text.toString().trim(),*/
      "username":name,
      "type":clientTxt,
      "SocialToken":password,
      "imageUrl":image,
      "SocialState":type,
      //"UserRegistrationCode":codeController.text.toString().trim()
    };
    return data;
  }

  Map<String,dynamic> initMap(){
    Map<String,dynamic> data={
      "username":userNameControler.text.trim().toString(),
      "password":passwordControler.text.trim().toString(),
      "grant_type":"password"
    };

    return data;
  }


  Map<String,dynamic> initMapSocialLogin({String password,String email}){
    Map<String,dynamic> data={
      "username":email,
      "password":password,
      "grant_type":"password"
    };

    return data;
  }

  Future<void> loginPress(Map<String,dynamic> map,{bool social=false}) async {

    if(validationForm(formKeyValidation)){

      setState(() {
        isLoading=true;
        erros=false;
      });

      var loginResponse=await loginNormal(map,social: social);
      if(loginResponse.statusCode==200){
        var userDataRequest=await getUserInfoRQ(token: loginResponse.object.toString());
        if(userDataRequest.statusCode==200){
          var t=await getToken();


         if(userInfo.type==clientTxt) {



         //  openPageAndClearPrev(context:context,page: MySericesPage(),route: MyServicesPageRoute);

         openPageAndClearPrev(context: context, page: GeneralPageClient(),route: HomePageRoute);
         }
         else if(userInfo.type==interpreterTxt){

          // openPage(context, GeneralPageServicesProvider());
           openPageAndClearPrev(context:context,page: GeneralPageServicesProvider(),route: HomePageRoute2);
         //  openPageAndClearPrev(context:context,page: TabWithImageHomePage(userInfo),route: TabWithImageRoute);
         }
        }else{
       //   showToast(userDataRequest.object.toString());
        }

      }else{
      // showToast(loginResponse.object.toString());


      }

      setState(() {
        isLoading=false;
      });

    }else{
      setState(() {
        erros=true;
      });
    }
  }

  Future<void> loginPressSocila(Map<String,dynamic> map,{bool social=false}) async {



      setState(() {
        isLoading=true;

      });

      var loginResponse=await loginNormal(map,social: social);
      if(loginResponse.statusCode==200){
        var userDataRequest=await getUserInfoRQ(token: loginResponse.object.toString());
        if(userDataRequest.statusCode==200){
          var t=await getToken();


          if(userInfo.type==clientTxt){
          //  openPageAndClearPrev(context:context,page: MySericesPage(),route: MyServicesPageRoute);


         openPageAndClearPrev(context:context,page: GeneralPageClient(),route: HomePageRoute);


            }
          else if(userInfo.type==interpreterTxt){
         //   openPageAndClearPrev(context:context,page: TabWithImageHomePage(userInfo),route: TabWithImageRoute);


            openPageAndClearPrev(context:context,page: GeneralPageServicesProvider(),route: HomePageRoute2);
          }
        }else{
          //   showToast(userDataRequest.object.toString());
        }

      }else{
        // showToast(loginResponse.object.toString());


      }

      setState(() {
        isLoading=false;
      });


  }

  @override
  void initState() {
    super.initState();





  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      right: true,

      child: Scaffold(
        body: ModalProgressHUD(

          inAsyncCall: isLoading,
            child: Form(
              key: formKeyValidation,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,

                    children: <Widget>[


                      LogoIcon(),
                      SizedBox(height: 30,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: erros?Colors.transparent:kPrimaryLightColor
                        ),
                        child: TextFormField(
                            maxLines: 1,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: userNameControler,
                            cursorColor: kPrimaryColor,
                            decoration: getInputDecorationHassan(label: usernameOrEmail),
                            validator: (String item) {
                              if (userNameControler.text.isEmpty)
                                return emptyValidation;
                          /*    if(!validateEmail(userNameControler.text.trim()))
                                return  emailValidation;*/
                              return null;
                            }

                        ),
                      ),
                      SizedBox(height: 20,),


                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: erros?Colors.transparent:kPrimaryLightColor
                        ),
                        child: TextFormField(
                            obscureText: shildPasswrod,
                            maxLines: 1,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                            ),
                            keyboardType: TextInputType.text,
                            controller: passwordControler,
                            cursorColor: kPrimaryColor,
                            decoration: getInputDecorationPassword(
                                label: password,
                                icon: Icon(Icons.remove_red_eye),
                                pressPrifix: reSetShild,
                                obsecure: shildPasswrod),

                            validator: (String item) {
                              if (passwordControler.text.isEmpty)
                                return emptyValidation;
                              if(!validatePassWord(passwordControler.text.trim()))
                                return passwordLengthValidation;


                              return null;
                            }



                        ),
                      ),
                      SizedBox(height: 10,),

                      MyButton(txt: login,press:(){
                        loginPress(initMap());
                      },),

                      SizedBox(height: 10,),

                      OrDivider(),
                      /*VISITOR AND CREATE ACCUNT*/
                      Row(children: <Widget>[
                        /*-------VISistor*/
                        Expanded(
                          child: MyButton(
                            txt: visitor,
                            raduis: 4,
                            buttonColor: kPrimaryColor,
                            press: () {
                              openPage(context, HowAppWork.visitor());
                            },
                          ),
                        ),

                        SizedBox(width: 4,),
                        /*Create account*/
                        Expanded(
                          child:
                          MyButton(
                            raduis: 4,
                            txt: createAccount,
                            buttonColor: kPrimaryColor,
                            press: () { openPage(context, SignUpScreen());},
                          ) ,
                        ),
                      ],),

                      SizedBox(height: 10,),
                      Row(
                        textDirection: TextDirection.rtl,

                        children: <Widget>[
                          Expanded(
                            child: InkWell(child: Text("هل نسيت كلمة المرور؟",
                              style: getTextSyle(16, Colors.grey.shade500),
                              textDirection: TextDirection.rtl,textAlign: TextAlign.right,),
                              onTap: (){
                                openPage(context, Code());
                              },),
                          )
                        ],
                      ),


                      OrDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SocalIcon(
                            iconSrc: "assets/icons/facebook.svg",
                            press: () async {

                             await _loginWithFB();
                            },
                          ),
                        /*  SocalIcon(
                            iconSrc: "assets/icons/twitter.svg",
                            press: () {},
                          ),*/
                          SocalIcon(
                            iconSrc: "assets/icons/google-plus.svg",
                            press: () async {
                              await _loginWithGooleSignIn();
                            },
                          ),
                        ],
                      ),


                      SizedBox(height: 10,),







                      OrDivider(),
                     /* Row(
                        textDirection: TextDirection.rtl,

                        children: <Widget>[
                          Expanded(
                            child: InkWell(child: Text(hireMe,
                              style: getTextSyle(16, Colors.grey.shade500),
                              textDirection: TextDirection.rtl,textAlign: TextAlign.right,),
                              onTap: (){openPage(context, HowAppWork.interprete());},),
                          )
                        ],
                      ),*/


                      //  HIREME
                      Row(children: <Widget>[
                        //  ------HIR MEr
                        Expanded(
                          child:MyButton(
                            txt: hireMe,
                            textStyle: TextStyle(color: kPrimaryColor,fontSize: 16),
                            buttonColor:kPrimaryLightColor,
                            raduis: 4,
                            press: () {

                             // openPage(context, HowAppWork.interprete());
                              openPage(context, InfoBeforHireMe());


                              },
                          ),
                        ),



                      ],),

                      SizedBox(height: 20,),

                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisSize: MainAxisSize.max,


                        children: <Widget>[
                          Expanded(
                            child: Container(

                              child: RichText(
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                text: TextSpan(text: loginHint1,style: getTextSyle(14, Colors.black87),
                                children: <TextSpan>[
                                  TextSpan(text: acceptPrivacy,style: getTextSyle(14, kPrimaryColor,underLine: true),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {

                                    openPage(context,PrivacyPolicyPage());
                                    }),
                                  TextSpan(text: acceptTerms,style: getTextSyle(14, kPrimaryColor,underLine: true),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {

                                          openPage(context,TermsPage());
                                        }),
                                ]),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )


        ),
      ),
    );
  }
}
