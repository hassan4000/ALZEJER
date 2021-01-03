
import 'package:faserholmak/Screens/CommentsPage/CommentPage.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/Screens/GeneralPageServicesProvider/GeneralPageServicesProvider.dart';
import 'package:faserholmak/Screens/GeneralPageVisitor/GeneralPageVisitor.dart';
import 'package:faserholmak/Screens/SelectUserType/SelectUserType.dart';
import 'package:faserholmak/Screens/TESTHASSAN/TESTHASSAN.dart';
import 'package:faserholmak/Screens/createAccountMofaser/CreateAccountMofaser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Screens/MofaserBalance/MofaserBalance.dart';
import 'Screens/Signup/signup_screen.dart';
import 'Screens/TESTPAY/TESTPAY.dart';
import 'Screens/Welcome/Launcher.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'constants.dart';
import 'app_localizations.dart';


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
      supportedLocales: [
        Locale('ar', ''),
        Locale('en', ''),
      ],
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          print("---------------------------${supportedLocale.languageCode}/${locale.languageCode}");
          print("---------------------------${supportedLocale.countryCode}/${locale.countryCode}");
          if (supportedLocale.languageCode == locale.languageCode
           ) {
            return supportedLocales.first;
           // return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).

        return supportedLocales.first;
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