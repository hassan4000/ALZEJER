import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/Login/login_screen.dart';
import 'package:faserholmak/Screens/SelectUserType/SelectUserType.dart';
import 'package:faserholmak/Screens/TabWithImage/TabWithImage.dart';
import 'package:faserholmak/Screens/rateMofaser/RateMofaser.dart';
import 'package:faserholmak/components/rounded_button.dart';
import 'package:faserholmak/components/rounded_password_field.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../app_localizations.dart';
import '../../constants.dart';

class ResetPass extends StatefulWidget {
  String email;


  ResetPass(this.email);

  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  var formKeyValidation = GlobalKey<FormState>();
  bool isLoading=false;

  TextEditingController passwordController=TextEditingController();
  TextEditingController rePasswordController=TextEditingController();
  bool erros=false;
  bool shildPasswrod = true;
  bool reShildPasswrod = true;

  void  setIsLoading(bool state){

    setState(() {
      isLoading=state;
    });
  }

  void reSetReShild() {
    setState(() {
      reShildPasswrod = !reShildPasswrod;
    });
  }

  void reSetShild() {
    setState(() {
      shildPasswrod = !shildPasswrod;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("newPassword"),style: getTextSyle(16, Colors.white),),
      ),
      body:ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Background(
          topAlignment: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKeyValidation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/password.png",
                      width: size.width * 0.35,
                    ),
                    SizedBox(height: size.height * 0.03),
                    /*SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),*/
                    SizedBox(height: size.height * 0.03),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: erros?Colors.transparent:kPrimaryLightColor
                      ),
                      child: TextFormField(
                          obscureText: shildPasswrod,
                          maxLines: 1,

                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                          ),
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          cursorColor: kPrimaryColor,
                          decoration: getInputDecorationPassword(
                              label: AppLocalizations.of(context).translate("password"),
                              icon: Icon(Icons.remove_red_eye),
                              pressPrifix: reSetShild,
                              obsecure: shildPasswrod),

                          validator: (String item) {
                            if (passwordController.text.isEmpty)
                              return AppLocalizations.of(context).translate("emptyValidation");
                            if(!validatePassWord(passwordController.text.trim()))
                              return passwordLengthValidation;
                            if(passwordController.text.trim()!=rePasswordController.text.trim())
                              return  AppLocalizations.of(context).translate("passwordValidation");

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
                          color: erros?Colors.transparent:kPrimaryLightColor
                      ),
                      child: TextFormField(
                          obscureText: reShildPasswrod,
                        //  textDirection: TextDirection.rtl,
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
                              label: AppLocalizations.of(context).translate("rePassword"),
                              icon: Icon(Icons.remove_red_eye),
                              pressPrifix: reSetReShild,
                              obsecure: reShildPasswrod),
                          validator: (String item) {
                            if (rePasswordController.text.isEmpty)
                              return AppLocalizations.of(context).translate("emptyValidation");
                            if(!validatePassWord(rePasswordController.text.trim()))
                              return AppLocalizations.of(context).translate("passwordLengthValidation");
                            if(passwordController.text.trim()!=rePasswordController.text.toString())
                              return AppLocalizations.of(context).translate("passwordValidation");


                            return null;
                          }
                      ),
                    ),

                    SizedBox(height: 10,),
                    MyButton(
                      txt: AppLocalizations.of(context).translate("okTXT"),
                      press: () async {
                        if(validationForm(formKeyValidation)){
                          setState(() {
                            erros=false;
                            isLoading=true;
                          });


                          var response=await addNewPassword(email: widget.email,
                              password: passwordController.text.toString().trim());
                          if(response.statusCode==200){
                            openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page:  LoginScreen());
                          }
                          setIsLoading(false);
                        }

                        else {
                          setState(() {
                            erros=true;
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
