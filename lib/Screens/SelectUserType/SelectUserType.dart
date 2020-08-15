import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/CreateWrokType/CreateWorkType.dart';
import 'package:faserholmak/Screens/GeneralPageVisitor/GeneralPageVisitor.dart';
import 'package:faserholmak/Screens/HowAppWork/HowAppWork.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/Login/login_screen.dart';
import 'package:faserholmak/Screens/Signup/signup_screen.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';

class SelectUserType extends StatefulWidget {
  @override
  _SelectUserTypeState createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends State<SelectUserType> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(

        body: Background(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 28,
                  ),
                  LogoIcon(),

                  /*---------Visitor--------*/
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: MyButton(
                        txt: visitor,
                        buttonColor: kPrimaryColor,
                        press: () {
                          openPage(context, HowAppWork.visitor());
                        },
                      )),
                    ],
                  ),

                  /*---------Create Account--------*/
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: MyButton(
                        txt: createAccount,
                        buttonColor: kPrimaryColor,
                        press: () { openPage(context, SignUpScreen());},
                      )),
                    ],
                  ),

                  /*---------Hire Me--------*/
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: MyButton(
                        txt: hireMe,
                        buttonColor: kPrimaryColor,
                        press: () {openPage(context, HowAppWork.interprete());},
                      )),
                    ],
                  ),

                  /*---------login--------*/
                  SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: MyButton(
                        txt: login,
                        buttonColor: kPrimaryColor,
                        press: () {
                          openPage(context, LoginScreen());
                        },
                      )),
                    ],
                  ),

                  /*   Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(hint1UserTypePage,style:getTextSyle(16,kPrimaryLightColor)),
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
