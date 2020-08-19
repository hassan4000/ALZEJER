
import 'package:faserholmak/Screens/CommentsPage/CommentPage.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/Screens/GeneralPageServicesProvider/GeneralPageServicesProvider.dart';
import 'package:faserholmak/Screens/GeneralPageVisitor/GeneralPageVisitor.dart';
import 'package:faserholmak/Screens/SelectUserType/SelectUserType.dart';
import 'package:faserholmak/Screens/TESTHASSAN/TESTHASSAN.dart';
import 'package:faserholmak/Screens/createAccountMofaser/CreateAccountMofaser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/MofaserBalance/MofaserBalance.dart';
import 'Screens/Signup/signup_screen.dart';
import 'Screens/TESTPAY/TESTPAY.dart';
import 'Screens/Welcome/Launcher.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'constants.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {


  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: kPrimaryColor,
      statusBarBrightness: Brightness.dark
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'الذكر',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,

      ),
      routes: <String,WidgetBuilder>{
        '/HomePage': (BuildContext context) => new GeneralPageClient(),
        '/HomePage2': (BuildContext context) => new GeneralPageServicesProvider(),
        '/HomePage3': (BuildContext context) => new GeneralPageVisitor(),
        '/SelectUserType': (BuildContext context) => new SelectUserType(),
      },
      //home: CommentPage(),
      home: Launcher(),
    //  home: MofaserBalance(),
    //  home: MyHomePage(),
      //home: SelectUserType(),
     // home: SignUpScreen(),
    );
  }
}