import 'package:faserholmak/Screens/Login/login_screen.dart';
import 'package:faserholmak/Screens/Signup/components/background.dart';
import 'package:faserholmak/Screens/Signup/components/or_divider.dart';
import 'package:faserholmak/Screens/Signup/components/social_icon.dart';
import 'package:faserholmak/components/already_have_an_account_acheck.dart';
import 'package:faserholmak/components/rounded_button.dart';
import 'package:faserholmak/components/rounded_input_field.dart';
import 'package:faserholmak/components/rounded_password_field.dart';
import 'package:flutter/material.dart';
/*import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';*/
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 28,),
            Text(
              "انشاء حساب ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/contract.png",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "اسم المستخدم",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "الايميل",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              hintText: "كلمة السر",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              hintText: "تأكيد كلمة السر",
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "انشاء حساب",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
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
            )
          ],
        ),
      ),
    );
  }
}
