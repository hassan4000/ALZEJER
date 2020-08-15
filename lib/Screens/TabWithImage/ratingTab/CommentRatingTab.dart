import 'package:flutter/material.dart';

class CommentRatingTab extends StatelessWidget{
  String text1;
  String text2;
  String date;


  CommentRatingTab({this.text1, this.text2, this.date});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),side: BorderSide.none),
      child: Padding(

        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              Text(text1,),
              Text(text2,),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(date),
              )
            ],
          ),
        ),
      ),
    );
  }

}
