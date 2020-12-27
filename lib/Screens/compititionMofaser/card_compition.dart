
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/CompitionUserModel/CompitionListUser.dart';
import 'package:faserholmak/Model/compitionList/Competition.dart';
import 'package:faserholmak/Model/compitionList/CompitionResponse.dart';
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

class CardCompition extends StatelessWidget {

  Competition competition;

  bool end=false;

  CardCompition(this.competition,{this.end=false});




  Widget getDate(String sDate){


    var time =competition.endDate.split('.');

    var time2=time[0].replaceAll(new RegExp(r'T'), ' ');
    printWrapped("time2=$time2");

    var year=competition.endDate.substring(0,4);
    var month=competition.endDate.substring(5,7);
    var day=competition.endDate.substring(8,10);
    var houre=competition.endDate.substring(11,13);
    var minue=competition.endDate.substring(14,16);
    DateTime t=new DateFormat("yyyy-MM-dd HH:mm:ss").parse('$year-${getZeroWithNumber(int.parse(month))}-${getZeroWithNumber(int.parse(day))} ${getZeroWithNumber(int.parse(houre))}:${getZeroWithNumber(int.parse(minue))}:00',true);


    t=t.toLocal();
    printWrapped(year.toString());
    printWrapped(month.toString());
    printWrapped(day.toString());
    printWrapped(houre.toString());
    printWrapped(minue.toString());
    DateTime nowTime=DateTime.now();
    printWrapped("----------------------------------------------------");
    printWrapped(t.year.toString());
    printWrapped(t.month.toString());
    printWrapped(t.day.toString());
    printWrapped(t.hour.toString());

    printWrapped("----------------------------------------------------");

    printWrapped(nowTime.year.toString());
    printWrapped(nowTime.month.toString());
    printWrapped(nowTime.day.toString());
    printWrapped(nowTime.hour.toString());

    int showTime=t.millisecondsSinceEpoch-nowTime.millisecondsSinceEpoch;
    Duration duration=t.difference(nowTime);
    printWrapped("show time now ${nowTime.millisecondsSinceEpoch}");
    printWrapped("show time f ${t.millisecondsSinceEpoch}");
    printWrapped("show time f ${t.millisecondsSinceEpoch-nowTime.millisecondsSinceEpoch}");



    DateTime ddd=DateTime.fromMillisecondsSinceEpoch(showTime);
    printWrapped('in days ${duration.inDays.toString()}');
    printWrapped(ddd.millisecondsSinceEpoch.toString());
    printWrapped(duration.inMinutes.toString());
    printWrapped(duration.inHours.toString());
    printWrapped(duration.inDays.toString());


    CountdownController countdownController = CountdownController(duration: Duration(minutes: 1));
    countdownController.start();
    return  Padding(

      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
            /*  Expanded(flex:2,child: Center(
                child: CountdownTimer(
                  endTime: duration.inMilliseconds+DateTime.now().millisecondsSinceEpoch,
                  textStyle: TextStyle(fontSize: 10, color: Colors.black,),
                  widgetBuilder: (_, CurrentRemainingTime time) {
                    return Text(
                        '${time.days} :${getZeroWithNumber(time.hours)} '
                            ':${getZeroWithNumber(time.min)} : ${getZeroWithNumber(time.sec)}');
                  },
                ),
              ),),*/
              Expanded(flex:1,child: Text("$endCompition",style: getTextSyle(16, Colors.black),textAlign: TextAlign.right,),
              ),


            ],
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){getDate(competition.endDate);

      openPage(context, CompitionListUserPage(competition.id.toString(),competition.duration,end: end  ,));
      },
      child: Card(
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
                end?Container():getDate(competition.endDate)

             
              ],
            ) ,
          )

      ),
    );
  }
}
