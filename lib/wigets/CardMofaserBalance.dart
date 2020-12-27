import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AllPaymentMethodModel/AllPaymentMethodModel.dart';
import 'package:faserholmak/Model/AllPaymentMethodModel/PaymentMethod.dart';
import 'package:faserholmak/Model/PaymentModel/PaymentModel.dart';
import 'package:faserholmak/Model/UserInfoModel/UserInfoModel.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/wigets/MyCircularImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

class CardMofaserBalance extends StatelessWidget {


  String name;
  String txt;
  String date;


  CardMofaserBalance({this.name,this.date,this.txt});

  @override
  Widget build(BuildContext context) {
   var size=MediaQuery.of(context).size;
    return GestureDetector(

      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 8,

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: <Widget>[
              SizedBox(height: 4,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(

                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(emptyString(txt)
                            ,style: getTextSyle(16, Colors.black87,fontWeight: FontWeight.w600),

                          ),
                        ),

                        name==null?
                        Container()
                      :Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(emptyString(AppLocalizations.of(context).translate("theUser")+name)
                            ,style: getTextSyle(16, Colors.black87,fontWeight: FontWeight.w100),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(emptyString(date),style: getTextSyle(14, Colors.grey.shade400,
                              fontWeight: FontWeight.normal), ),
                        ),


                      ],
                    ),
                  ),


                ],
              ),
              SizedBox(height: 4,),
            ],
          ),
        ),
      ),
    );
  }
}


