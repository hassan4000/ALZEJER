import 'package:faserholmak/constants.dart';
import 'package:flutter/material.dart';

class SmallHomeCard extends StatelessWidget {
  final String txt;
  VoidCallback press;

  SmallHomeCard({this.txt,this.press});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){press();},
      splashColor: Colors.grey,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
              color:kPrimaryColor ,
              width: 1.4,
              style: BorderStyle.solid)),

      textColor: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Text(txt,textAlign: TextAlign.center,style:
          TextStyle(color: kPrimaryColor,fontSize: 16,fontWeight:
          FontWeight.w100),maxLines: 1,overflow: TextOverflow.ellipsis,)),
        /*  Icon(Icons.add)*/
        ],
      ),
    );
  }
}
