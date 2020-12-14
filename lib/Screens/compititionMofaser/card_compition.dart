
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/compitionList/Competition.dart';
import 'package:faserholmak/Model/compitionList/CompitionResponse.dart';
import 'package:faserholmak/wigets/PersonalProfileContent.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CardCompition extends StatelessWidget {

  Competition competition;


  CardCompition(this.competition);

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior:  Clip.hardEdge,
        elevation: 4,

        shape: getOutLineBorder(radius: 4,color: Colors.transparent,width: 1),


        child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
          child:
          Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(emptyString(competition.name),style:getTextSyle(16, kPrimaryColor,fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(height: 10,),
             /* Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/medal.png",width: 50,height: 50,fit: BoxFit.cover,),

                  Container(
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(8),

                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("1000"),
                    ),
                  )
                ],
              ),SizedBox(height: 10,),*/

              PersonalProfileContent(hint: "$typeCompition",text: emptyString(competition.userWork.adjectiveName),),
              PersonalProfileContent(hint: "$prizeCompition",text: emptyString(competition.firstPlacePrice.toString()),),
              PersonalProfileContent(hint: "$endCompition",text: competition.endDate,)
            ],
          ) ,
        )

    );
  }
}
