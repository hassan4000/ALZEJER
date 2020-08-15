import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/Login/login_screen.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HonorDeals extends StatefulWidget {
  @override
  _HonorDealsState createState() => _HonorDealsState();
}

class _HonorDealsState extends State<HonorDeals> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body:Padding(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
          child: Column(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              SizedBox(height: 4,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  LogoIcon(),
                  Expanded(
                    child: Text(honorDeals,style: getTextSyle(16, kPrimaryColor,fontWeight: FontWeight.w600),textDirection: TextDirection.rtl,),
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView
                  (child:
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text("ص نص ص  ",style: getTextSyle(14, Colors.black87),textDirection: TextDirection.rtl))
                ),
              ),

              Row(mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MyButton(txt: continueTxt,press: (){openPage(context, LoginScreen());},)
                ],)
            ],
          ),
        ),
      ),
    );
  }
}
