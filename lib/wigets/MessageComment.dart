import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/constants.dart';
import 'package:flutter/material.dart';

class MessageComment extends StatelessWidget {
  String message;
  bool sendByMe;
  String creationDate;
  String name;

  MessageComment({@required this.message, @required this.sendByMe,@required this.creationDate,this.name});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 20,
          right: sendByMe ? 20 : 0),


      child: Card(

        elevation: 4,
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderRadius: sendByMe ? BorderRadius.only(
          topLeft: Radius.circular(23),
      topRight: Radius.circular(23),
      bottomLeft: Radius.circular(23)):
            BorderRadius.only(
            topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23)),
          borderSide: BorderSide(color: kPrimaryColor)
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            textDirection: TextDirection.rtl,

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(right: 20,left: 10,top: 10,bottom: 0),
                child: Text(emptyString(name),
                    // textAlign: TextAlign.start,

                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 4,),
              Padding(
                padding: EdgeInsets.only(right: 20,left: 10,top: 10,bottom: 0),
                child: Text(emptyString(message),
                   // textAlign: TextAlign.start,

                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300)),
              ),

              SizedBox(height: 4,),
              Padding(
                padding: EdgeInsets.only(right: 10,left: 20,top: 10,bottom: 8),
                child: Text(emptyString(creationDate),
                    // textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}