import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_localizations.dart';

class CardDreams extends StatelessWidget {
  String likes;
  String views;
  String desc;
  String provierName;
  String explantaion;
  bool showComment;
  bool showExplnationButton;
  bool showRating;
  bool showEditText;
  bool showDelete;
  bool showExplanationText;
  bool showToAnotherMofaser;
  bool indexServices;
  VoidCallback press;
  VoidCallback commentPress;
  VoidCallback editTextPress;
  VoidCallback explanationPress;
  VoidCallback ratingPress;
  VoidCallback sharePress;
  VoidCallback lovePress;
  VoidCallback deletePress;
  VoidCallback toAnotherMofaserPress;
  bool showLove;


  CardDreams({this.indexServices=false,this.deletePress,this.showDelete=false,this.showEditText=false,this.editTextPress,this.showLove=false,this.lovePress,this.provierName,this.sharePress,this.toAnotherMofaserPress,this.showToAnotherMofaser=false,this.likes, this.views, this.desc,this.showComment=false,this.explantaion,
    this.press,this.commentPress,this.explanationPress,this.ratingPress,this.showRating=false,this.showExplnationButton=false,this.showExplanationText=false});



  _launchURL() async {
    const url = "$googlePlayUrlV1";
    if (await canLaunch(url)) {
      await launch(url).then((value) {




      });
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {

    return  Card(
//                color: Colors.blue,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[



          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(

              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
              color: Colors.indigo,

            ),


            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[


                Row(

                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[

                    

                    showExplnationButton? Expanded(
                     child: InkWell(
                       onTap: explanationPress,
                       child: Padding(
                         padding: EdgeInsets.all(4),
                         child: Text(AppLocalizations.of(context).translate("addExplanation"),style: getTextSyle(16, Colors.white),
                         textAlign: TextAlign.center,),
                       ),
                     ),
                   ):Container(),






                    /*showRating? Expanded(
                      child: InkWell(
                        onTap: ratingPress,
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(addRating,style: getTextSyle(16, Colors.white),textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,),
                        ),
                      ),
                    ):Container(),*/
                    showToAnotherMofaser? Expanded(
                      child: InkWell(
                        onTap: toAnotherMofaserPress,
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(AppLocalizations.of(context).translate("receive"),
                            style: getTextSyle(16, Colors.white),textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ):Container(),



                    showEditText?Flexible(
                      child: IconButton(icon: Icon(Icons.edit,color: Colors.white,),
                        splashColor: Colors.black,onPressed:editTextPress,),
                    ):Container(),


                    showDelete?Flexible(
                      child: IconButton(icon: Icon(Icons.delete,color: Colors.white,),
                        splashColor: Colors.black,onPressed:deletePress,),
                    ):Container(),
                  ],
                ),



                showRating?InkWell(
                  onTap: sharePress,
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      AppLocalizations.of(context).translate("shareForMofaserHint"),style: getTextSyle(16, Colors.red,fontWeight: FontWeight.w600),
                    ),
                  ),
                ):Container()
              ],
            ),
          ),
          showLove?Container(
                height: 100,
                child: Lottie.asset('assets/love.json')):InkWell(
            onTap: press,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate("visionText"),textAlign: TextAlign.center,),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text("$desc",
                      textDirection: TextDirection.rtl,style: getTextSyle(16, Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),

          showExplanationText?Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 4,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(height: 1,color: Colors.grey.shade400),
              ),
              SizedBox(height: 4,),
              Text("${AppLocalizations.of(context).translate("explanation")} ${AppLocalizations.of(context).translate("byUser")}  ${emptyString(provierName)}",
                style: getTextSyle(16, Colors.black),
              textAlign: TextAlign.center,),

              Padding(
                padding: EdgeInsets.all(10),
                child: Text(emptyString(explantaion), textDirection: TextDirection.rtl,style: getTextSyle(16, Colors.black),
                maxLines: 100,),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                InkWell(onTap: lovePress,child: Image.asset("assets/images/heart.png",width: 20,height: 20,)),

                Flexible(child: Text("$likes",  style: TextStyle(color: Colors.white,fontSize: 12),)),

                Image.asset("assets/images/eye.png",width: 20,height: 20,),

                Flexible(child: Text("$views",  style: TextStyle(color: Colors.white,fontSize: 12),)),
              //  SizedBox(width:65),
                showComment?Image.asset("assets/images/comment.png",width: 20,height: 20,):Container(),

                showComment?Flexible(
                  child: GestureDetector(
                    onTap: commentPress,
                      child: Text(AppLocalizations.of(context).translate("sendComments"),
                        style: TextStyle(color: Colors.white,fontSize: 12),)),
                ):Container(),

                showRating?Icon(Icons.star_half,color:Colors.white,size: 20,):Container(),
                showRating? Expanded(
                  child: InkWell(
                    onTap: ratingPress,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(AppLocalizations.of(context).translate("addRating"),
                        style: getTextSyle(12, Colors.white),textAlign: TextAlign.center,
                       ),
                    ),
                  ),
                ):Container(),


                indexServices?
                Flexible(
                  child: InkWell(
                    onTap: (){
                      _launchURL();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(AppLocalizations.of(context).translate("addRating"),
                        style: getTextSyle(12, Colors.white),textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ):Container(),

                indexServices?
                Flexible(
                  child: InkWell(
                    onTap: () async {
                      await FlutterShare.share(
                          title:
                          '${AppLocalizations.of(context).translate("pleaseShareThisLink")}',
                          text:
                          '${AppLocalizations.of(context).translate("shareHitn1")}\n ${userInfo.userSpecialCode}',
                          linkUrl:
                          ' ${AppLocalizations.of(context).translate("linkApp")} \n  ${googlePlayUrl}',
                          chooserTitle: 'Share');
                    },
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(AppLocalizations.of(context).translate("shareApp"),
                        style: getTextSyle(12, Colors.white),textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ):Container()

              ],
            ),
          ),
        ],
      ),

    );
}
}
