import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardDreams extends StatelessWidget {
  String likes;
  String views;
  String desc;
  String explantaion;
  bool showComment;
  bool showExplnationButton;
  bool showRating;
  bool showExplanationText;
  bool showToAnotherMofaser;
  VoidCallback press;
  VoidCallback commentPress;
  VoidCallback explanationPress;
  VoidCallback ratingPress;
  VoidCallback toAnotherMofaserPress;


  CardDreams({this.toAnotherMofaserPress,this.showToAnotherMofaser=false,this.likes, this.views, this.desc,this.showComment=false,this.explantaion,
    this.press,this.commentPress,this.explanationPress,this.ratingPress,this.showRating=false,this.showExplnationButton=false,this.showExplanationText=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Card(
//                color: Colors.blue,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                color: Colors.indigo,

              ),


              child: Row(

                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  showExplnationButton? Expanded(
                   child: InkWell(
                     onTap: explanationPress,
                     child: Padding(
                       padding: EdgeInsets.all(4),
                       child: Text(addExplanation,style: getTextSyle(16, Colors.white),textDirection: TextDirection.rtl,
                       textAlign: TextAlign.center,),
                     ),
                   ),
                 ):Container(),
                  showRating? Expanded(
                    child: InkWell(
                      onTap: ratingPress,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(addRating,style: getTextSyle(16, Colors.white),textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,),
                      ),
                    ),
                  ):Container(),
                  showToAnotherMofaser? Expanded(
                    child: InkWell(
                      onTap: toAnotherMofaserPress,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(receive,style: getTextSyle(16, Colors.white),textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,),
                      ),
                    ),
                  ):Container(),
                ],
              ),
            ),
            Text(visionText),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$desc",
              textDirection: TextDirection.rtl,style: getTextSyle(16, Colors.black),overflow: TextOverflow.ellipsis,
              ),
            ),

            showExplanationText?Column(
              children: <Widget>[
                SizedBox(height: 4,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(height: 1,color: Colors.grey.shade400),
                ),
                SizedBox(height: 4,),
                Text(explanation),

                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(emptyString(explantaion), textDirection: TextDirection.rtl,style: getTextSyle(16, Colors.black),overflow: TextOverflow.ellipsis,),
                )
              ],
            ):Container(),




            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10) ),
                color: Colors.indigo,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset("assets/images/heart.png"),
                  SizedBox(width:5),
                  Text("$likes",  style: TextStyle(color: Colors.white),),
                  SizedBox(width:20),
                  Image.asset("assets/images/eye.png"),
                  SizedBox(width:10),
                  Text("$views",  style: TextStyle(color: Colors.white),),
                  SizedBox(width:65),
                  showComment?Image.asset("assets/images/comment.png"):Container(),
                  SizedBox(width:5),
                  showComment?GestureDetector(
                    onTap: commentPress,
                      child: Text("اضف تعليق", style: TextStyle(color: Colors.white),)):Container(),
                ],
              ),
            ),
          ],
        ),

      ),
    );
}
}
