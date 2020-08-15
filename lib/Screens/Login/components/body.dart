import 'package:faserholmak/Screens/Signup/signup_screen.dart';
import 'package:faserholmak/Screens/code/Code.dart';
import 'package:faserholmak/components/already_have_an_account_acheck.dart';
import 'package:faserholmak/components/rounded_button.dart';
import 'package:faserholmak/components/rounded_input_field.dart';
import 'package:faserholmak/components/rounded_password_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'background.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20,),
            Text(
              "تسجيل دخول",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/login.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "الايميل ",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              hintText: "كلمة المرور",
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "تسجيل دخول",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Code();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
