import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/MyServices/MySericesPage.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/Screens/GeneralPageServicesProvider/GeneralPageServicesProvider.dart';
import 'package:faserholmak/Screens/Login/login_screen.dart';
import 'package:faserholmak/Screens/SelectUserType/SelectUserType.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/TabWithImage/TabWithImage.dart';
import 'package:faserholmak/Screens/TabWithImage/TabWithImageHomePage.dart';
import 'package:faserholmak/Screens/Welcome/welcome_screen.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter_svg/svg.dart';


class Launcher extends StatefulWidget {
  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;



  void getData(String tokenTXT) async {


      var userDataRequest=await getUserInfoRQ(token: tokenTXT);
      if(userDataRequest.statusCode==200){
        var t=await getToken();
        token=t;
        tokenValue=t;
        if(userInfo.type==clientTxt){
        //  openPageAndClearPrev(context:context,page: MySericesPage(),route: MyServicesPageRoute);
          openPageAndClearPrev(context:context,page: GeneralPageClient(),route: HomePageRoute);
          // openPage(context, GeneralPageClient());
        }

        else if(userInfo.type==interpreterTxt){
       //   openPageAndClearPrev(context:context,page: TabWithImageHomePage(userInfo),route: TabWithImageRoute);
          openPageAndClearPrev(context:context,page: GeneralPageServicesProvider(),route: HomePageRoute2);
        }
        

      }else{
        showToast(userDataRequest.object.toString());
        openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page:  LoginScreen());
     //   openPage(context,  LoginScreen());
        Navigator.pop(context);

      }




  }

  void initAuth()async{
    String token=await getToken();
    if(token!=null && token.isNotEmpty){
      getData(token);

    }else{
    //  Navigator.of(context).pop();
      openPageAndClearPrev(context: context,page:  LoginScreen(), route: SelectUserTypeRoute);

    }
  }

  @override
   void  initState()  {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceInOut,
    );

//    animation.addStatusListener((status) async{
//
//
//
//
//    });
    _animationController.forward();

    Future.delayed(new Duration(seconds: 3), () async {
      // here do thing
      if(mounted){
        initAuth();
      }
       /* Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => new SelectUserType()),
            (Route<dynamic> route) => false);*/

    });



  }

  @override
  Widget build(BuildContext context) {
    List<Shadow> shadows = new List();
    Size size = MediaQuery.of(context).size;
    shadows.add(new Shadow(color: Colors.white, blurRadius: 4.0));
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Background(
          child:
          Column(
            children: <Widget>[
              SizedBox(height: 30),
              FadeTransition(
                  opacity: animation,
                  child: Column(
                    children: <Widget>[

                      SizedBox(height: 80,),
                      LogoIcon(),
                      SizedBox(height: 80,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '$logoText',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: MediaQuery.of(context).size.width / 16.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5.0,
                                    shadows: shadows),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
