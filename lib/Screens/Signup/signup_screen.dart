import 'package:country_pickers/country.dart';
import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/DatabaseMethods.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/Login/login_screen.dart';
import 'package:faserholmak/Screens/Signup/components/body.dart';
import 'package:faserholmak/components/already_have_an_account_acheck.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/wigets/MyCountryPicker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../constants.dart';
import 'components/or_divider.dart';
import 'components/social_icon.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool shildPasswrod = true;
  bool reShildPasswrod = true;
  bool isLoading = false;


  bool erros=false;
  var formKeyValidation = GlobalKey<FormState>();

  Country selectedCountry;


  void reSetShild() {
    setState(() {
      shildPasswrod = !shildPasswrod;
    });
  }

  void reSetLoading(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  void reSetReShild() {
    setState(() {
      reShildPasswrod = !reShildPasswrod;
    });
  }

  Map<String,dynamic>initMapLogin(){
    Map<String,dynamic> data={
      "username":userNameController.text.trim().toString(),
      "password":passwordController.text.trim().toString(),
      "grant_type":"password"
    };

    return data;
  }

  Map<String,dynamic> initMap(){
    Map<String,dynamic> data={
      "name":nameController.text.toString().trim(),
      "email":emailController.text.toString().trim(),
      "password":passwordController.text.toString().trim(),
      "confirmPassword":rePasswordController.text.toString().trim(),
      "phoneNumber":selectedCountry.phoneCode+phoneController.text.toString().trim(),
      "username":userNameController.text.toString().trim(),
      "type":clientTxt,
      "SocialState":"Normal",
      "UserRegistrationCode":codeController.text.toString().trim()
    };
    return data;
  }

  Map<String,dynamic> initMapChat(){
    Map<String,dynamic> data={
      "name":nameController.text.toString().trim(),
      "Email":emailController.text.toString().trim(),
      "phoneNumber":selectedCountry.phoneCode+phoneController.text.toString().trim(),
      "userName":userNameController.text.toString().trim(),
      "Type":clientTxt,
      "SocialState":"Normal",
      "PictureId":""

    };
    return data;
  }


  Future<void> loginRQ(Map<String,dynamic>map) async {

    var loginResponse=await loginNormal(map);
    if(loginResponse.statusCode==200){
      var userDataRequest=await getUserInfoRQ(token: loginResponse.object.toString());
      if(userDataRequest.statusCode==200){
        openPageAndClearPrev(context: context,page: new GeneralPageClient(),route: HomePageRoute);
      }
    }

  }


  Future<void> createAccountRQ() async {
    if(validationForm(formKeyValidation)){
      setState(() {
        erros=false;
      isLoading=true;
      });


      var createAccountResponse=await createAccountNormal(initMap());
      if(createAccountResponse.statusCode==200){


        await addUserInfo(initMapChat());
        await loginRQ(initMapLogin());

        reSetLoading(false);
      }else{
        showToast(createAccountResponse.object.toString());
        reSetLoading(false);
      }

    }





    else{
      setState(() {
        erros=true;
        isLoading=false;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    selectedCountry=initCountry("971");
  }

  Widget initAddCountryPrefixIcon(){
    return GestureDetector(
      onTap: () async {
        var item= await openCountryDialog(context,onValuePicked: (country){
          setState(() {
            selectedCountry=country;
          });


        });

      },
      child: MyCountryPicker(country: selectedCountry,padding: 2 ,),
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(createAccount,style: NormalTextWhite,),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Background(
            topAlignment: true,
            child: SingleChildScrollView(
              child: Form(
                key: formKeyValidation,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[


                      Image.asset(
                        "assets/images/contract.png",
                        height: size.height * 0.25,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      /*name*/
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
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          cursorColor: kPrimaryColor,
                          decoration: getInputDecorationHassan(label: name),
                          validator: (String item) {
                            if (nameController.text.isEmpty)
                              return emptyValidation;
                            else
                              return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      /*userName*/
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:  erros?Colors.transparent:kPrimaryLightColor
                        ),
                        child: TextFormField(
                            maxLines: 1,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                            ),
                            keyboardType: TextInputType.text,
                            controller: userNameController,
                            cursorColor: kPrimaryColor,
                            decoration: getInputDecorationHassan(label: userName),
                            validator: (String item) {
                              if (userNameController.text.isEmpty)
                                return emptyValidation;

                              return null;
                            }),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      /*email*/
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:  erros?Colors.transparent:kPrimaryLightColor
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
                            controller: emailController,
                            cursorColor: kPrimaryColor,
                            decoration: getInputDecorationHassan(label: email,icon: Icon(Icons.email,color: kPrimaryColor,)),
                            validator: (String item) {
                              if (emailController.text.isEmpty)
                                return emptyValidation;
                              if(!validateEmail(emailController.text.trim()))
                                return  emailValidation;
                              return null;
                            }

                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      /*phone*/
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:  erros?Colors.transparent:kPrimaryLightColor
                        ),
                        child: TextFormField(
                            maxLines: 1,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                            ),
                            keyboardType: TextInputType.number,
                            controller: phoneController,
                            cursorColor: kPrimaryColor,
                            decoration: getInputDecorationCountry(myPrefix:initAddCountryPrefixIcon(),label: phone),
                            validator: (String item) {
                              if (phoneController.text.isEmpty)
                                return emptyValidation;

                              return null;
                            }

                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      /*password*/
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:  erros?Colors.transparent:kPrimaryLightColor
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
                            controller: passwordController,
                            cursorColor: kPrimaryColor,
                            decoration: getInputDecorationPassword(
                                label: password,
                                icon: Icon(Icons.remove_red_eye),
                                pressPrifix: reSetShild,
                                obsecure: shildPasswrod),

                            validator: (String item) {
                              if (passwordController.text.isEmpty)
                                return emptyValidation;
                              if(!validatePassWord(passwordController.text.trim()))
                                return passwordLengthValidation;
                              if(passwordController.text.trim()!=rePasswordController.text.trim())
                                return  passwordValidation;

                              return null;
                            }



                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      /*rePassword*/
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:  erros?Colors.transparent:kPrimaryLightColor
                        ),
                        child: TextFormField(
                            obscureText: reShildPasswrod,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                            ),
                            keyboardType: TextInputType.text,
                            controller: rePasswordController,
                            cursorColor: kPrimaryColor,
                            decoration: getInputDecorationPassword(
                                label: rePassword,
                                icon: Icon(Icons.remove_red_eye),
                                pressPrifix: reSetReShild,
                                obsecure: reShildPasswrod),
                            validator: (String item) {
                              if (rePasswordController.text.isEmpty)
                                return emptyValidation;
                              if(!validatePassWord(rePasswordController.text.trim()))
                                return passwordLengthValidation;
                              if(passwordController.text.trim()!=rePasswordController.text.toString())
                                return passwordValidation;


                              return null;
                            }
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      SizedBox(height: 24,),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:  kPrimaryLightColor
                        ),
                        child: TextFormField(

                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                            ),
                            keyboardType: TextInputType.text,
                            controller: codeController,
                            cursorColor: kPrimaryColor,
                            decoration: getInputDecorationHassan(
                                label: code,
                                icon: Icon(Icons.code),

                              ),

                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyButton(txt: createAccount,press: createAccountRQ,),
                      SizedBox(
                        height: 10,
                      ),

                       Row(
                        textDirection: TextDirection.rtl,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: <Widget>[
                          Expanded(
                            child: Container(

                              child: RichText(
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                text: TextSpan(text: alreadyHaveAccount,style: getTextSyle(14, Colors.black87),
                                    children: <TextSpan>[
                                      TextSpan(text: login,style: getTextSyle(14, kPrimaryColor,fontWeight: FontWeight.w600),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {

                                              Navigator.pop(context);
                                            }),
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),

                     /* OrDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SocalIcon(
                            iconSrc: "assets/icons/facebook.svg",
                            press: () {},
                          ),
                          SocalIcon(
                            iconSrc: "assets/icons/twitter.svg",
                            press: () {},
                          ),
                          SocalIcon(
                            iconSrc: "assets/icons/google-plus.svg",
                            press: () {},
                          ),
                        ],
                      ),
*/
                      SizedBox(
                        height: 10,
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
