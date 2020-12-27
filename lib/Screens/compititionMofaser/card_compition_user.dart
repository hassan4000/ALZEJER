
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/CompitionUserModel/CompitionListUser.dart';
import 'package:faserholmak/Model/compitionList/Competition.dart';
import 'package:faserholmak/Model/compitionList/CompitionResponse.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:faserholmak/wigets/MyCircularImage.dart';
import 'package:faserholmak/wigets/PersonalProfileContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import 'CompitionUserList.dart';

class CardCompitionUser extends StatelessWidget {

  CompitionListUser item;
  int duration;

  bool end=false;

  CardCompitionUser(this.item,this.duration,{this.end=false});







  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        printWrapped("icon ${item.toJson().toString()}");
    },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
            clipBehavior:  Clip.hardEdge,
            elevation: 4,

            shape: getOutLineBorder(radius: 4,color: Colors.transparent,width: 1),


            child:Padding(
              padding: EdgeInsets.only(bottom: 4,left: 4,right: 4),
              child:
              Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/medal.png",width: 40,height: 40,fit: BoxFit.cover,color: kPrimaryColor,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                        child: Container(

                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryLightColor
                          ),
                          child: Text(emptyString(item.rank.toString()),style: getTextSyle(18, kPrimaryColor),),
                        ),
                      ),
                      Expanded(child: Center(child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child:(item.serviceProvider.pictureId=="null"||item.serviceProvider.pictureId==null)
                            ?LogoIcon(width: 100,height: 100):
                        MyCircularImage(100,100,linkImg: emptyString(imageUrl+item.serviceProvider.pictureId),),
                      ))),


                      SizedBox(width: 60,)
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: Text(emptyString(item.serviceProvider.name),style: getTextSyle(16, kPrimaryColor),),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: Text("$pointTxt ${(100-item.rank)*duration}",style: getTextSyle(16, kPrimaryColor),),)
                    ],
                  ),


                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Flexible(
                     child: Column(
                       children: [
                         Text("$speedTxt",style: getTextSyle(16, kPrimaryColor),),
                         Text("${emptyString(item.speed.toString())}",style: getTextSyle(16, kPrimaryColor),),
                       ],
                     ),
                   ),
                   Container(
                     width: 1,
                       height: 30,
                     color: Colors.grey,
                   ),
                   Flexible(
                     child: Column(
                       children: [
                         Text("$completedServices",style: getTextSyle(14, kPrimaryColor),),
                         Text("${emptyString(item.numberOfDoneServices.toString())}",style: getTextSyle(16, kPrimaryColor),),
                       ],
                     ),
                   ),
                   Container(
                     width: 1,
                     height: 30,
                     color: Colors.grey,
                   ),
                   Flexible(
                     child: Column(
                       children: [
                         Text("$servicesInProgress",style: getTextSyle(14, kPrimaryColor),),
                         Text("${emptyString(item.numberOfActiveServices.toString())}",style: getTextSyle(16, kPrimaryColor),),
                       ],
                     ),
                   ),
                 ],
                  )












                ],
              ) ,
            )

        ),
      ),
    );
  }
}
