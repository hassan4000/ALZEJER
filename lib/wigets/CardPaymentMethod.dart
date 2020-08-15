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

class CardPaymentMethod extends StatelessWidget {


  PaymentMethod paymentMethod;
  VoidCallback press;

  CardPaymentMethod({this.paymentMethod,this.press});

  @override
  Widget build(BuildContext context) {
   var size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(emptyString(paymentMethod.paymentMethodAr)
                            ,style: getTextSyle(16, Colors.black87,fontWeight: FontWeight.w600),),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(emptyString(paymentMethod.serviceCharge.toString() +"تكلفة الخدمة"),style: getTextSyle(16, Colors.black87,fontWeight: FontWeight.normal),),
                        ),


                      ],
                    ),
                  ),
                  Flexible(flex: 1,child: MyCircularImage(100,100,linkImg: emptyString(paymentMethod.imageUrl),)),

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


