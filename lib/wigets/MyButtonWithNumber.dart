import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import '../app_localizations.dart';
import '../constants.dart';

class MyButtonWithNumber extends StatelessWidget {
  String txt;
  Color borderColor;
  Color splashColor;
  double borderWidth;
  TextStyle textStyle;
  VoidCallback press;
  Color buttonColor;
  double raduis;
  int number;
  int id;
  int doneServices;


  MyButtonWithNumber({this.txt,
    this.borderColor=kPrimaryColor,
    this.splashColor=Colors.grey,
    this.borderWidth=0.2,
    this.textStyle=NormalTextWhite,
    this.press,
    this.buttonColor=kPrimaryColor,
    this.raduis=raduisButton,
  this.number,
    this.doneServices,
  this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ press();},
      child: Card(
        clipBehavior: Clip.hardEdge,

        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(raduis),
            borderSide: BorderSide(
                color: borderColor,
                width: borderWidth,
                style: BorderStyle.solid)),

        color: buttonColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                child: Row(


                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            color: IconColor,
                            child: userWorkIcon(id: id),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 4,),
                    Expanded(
                      flex: 2,
                      child: Text(txt,


                          style:textStyle
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(number.toString(),
                          textAlign: TextAlign.center,

                          style:textStyle
                      ),
                    ),


                  ],
                ),
              ),
            ),
           /* Expanded(
              flex: 1,
              child: Container(
                color: kPrimaryLightColor,
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text("${AppLocalizations.of(context).translate("serviceProviders")} $number",style: getTextSyle(10, Colors.black),maxLines: 1,),
                    )),

                  ],

                ),
              ),
            ),*/
            Expanded(
              child: Container(
                color: kPrimaryLightColor,
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    children: [
                      Flexible(child: Text("${AppLocalizations.of(context).translate("dreamsExplained")} $doneServices",style: getTextSyle(13, Colors.black),maxLines: 1,)),
                    ],
                  ),
                ),
              ),
            )

           
          ],
        ),

      ),
    );
  }
}
