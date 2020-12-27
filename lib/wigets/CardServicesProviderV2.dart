import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/UserInfoModel/UserInfoModel.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/wigets/MyCircularImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

class CardServicesProviderV2 extends StatelessWidget {
  UserInfoModel userInfoModel;
  VoidCallback pressShowProviderPage;
  VoidCallback pressShowPath;


  CardServicesProviderV2({this.userInfoModel,this.pressShowProviderPage,this.pressShowPath});

  @override
  Widget build(BuildContext context) {
   var size=MediaQuery.of(context).size;
    return Card(
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
                        child: Text(userInfoModel.name,style: getTextSyle(16, Colors.black87,fontWeight: FontWeight.w600),),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(userInfoModel.type,style: getTextSyle(14, Colors.black87,fontWeight: FontWeight.normal),),
                      ),

                      MyButton(txt: serviceProviderPape,textStyle: getTextSyle(12, Colors.white,fontWeight: FontWeight.w100),
                        press: pressShowProviderPage,)
                    ],
                  ),
                ),
                Flexible(flex: 1,child: MyCircularImage(100,100,linkImg: imageUrl+userInfoModel.pictureId,)),

              ],
            ),
            SizedBox(height: 4,),
            Row(

              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

                Expanded(
                  flex: 2,
                  child: Column(

                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${AppLocalizations.of(context).translate("providedHint")} ${userInfoModel.numberOfDoneServices} ${AppLocalizations.of(context).translate("serviceTxt")}',
                          style: getTextSyle(16, Colors.black,fontWeight: FontWeight.w300),
                        textDirection: TextDirection.rtl,),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                            '${AppLocalizations.of(context).translate("onProgress")} ${userInfoModel.numberOfActiveServices} ${AppLocalizations.of(context).translate("serviceTxt")}',
                          style: getTextSyle(16, Colors.black,fontWeight: FontWeight.w300),
                            textDirection: TextDirection.ltr,textAlign: TextAlign.right,),
                      ),


                    ],
                  ),
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }
}


