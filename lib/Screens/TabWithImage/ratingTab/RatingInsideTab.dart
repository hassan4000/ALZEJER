import 'package:faserholmak/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../app_localizations.dart';
import 'CommentRatingTab.dart';

class RatingInsideTab extends StatelessWidget {

  String idServices;
  String message;
  String date;
  double rating;

  RatingInsideTab({this.idServices, this.message, this.date, this.rating});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Container(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[

            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: kPrimaryColor,

              ),

              padding: EdgeInsets.all(8),
              child: Row(mainAxisSize: MainAxisSize.max,

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: RatingBar(
                      itemSize: 18,
                      initialRating: rating,
                      minRating: 1,

                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      ignoreGestures: true,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onRatingUpdate: (rating) {


                      },
                    ),
                  ),
                  Expanded(child: Text(" ${AppLocalizations.of(context).translate("vision")} $idServices",style: TextStyle(color:Colors.white),
                    textDirection: TextDirection.rtl,),),



              ],),
            ),
            CommentRatingTab(text1: message,text2: "",date: date,),


          ],
        ),
      ) ,
    );
  }
}
