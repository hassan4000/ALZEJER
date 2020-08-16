import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/wigets/MyButton.dart';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../constants.dart';


class ShareAfterDialog extends StatefulWidget {
  String name;
  String userWorkname;

  ShareAfterDialog(this.name,this.userWorkname);

  @override
  _ShareAfterDialogState createState() => _ShareAfterDialogState();
}

class _ShareAfterDialogState extends State<ShareAfterDialog> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide.none),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 4.0,
          ),
          Text(" مشاركة التطبيق  ",
              style:
              getTextSyle(20, kPrimaryColor, fontWeight: FontWeight.w600)),
        ],
      ),
      content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: isLoading
              ? Container(
            height: 120,
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CircularProgressIndicator(),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Loading ..',
                      style: TextStyle(
                        fontFamily: 'Heading',
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    )),
              ],
            ),
          )
              : SingleChildScrollView(
              child: Container(
                width: width,
                child: Column(
                  textDirection: TextDirection.rtl,

                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(" تقدير لجهود المفسر $name  يرجى مشاركة هذا الرابط واحصل على نقاط لتسريع تفسير حلمك القادم  ",textDirection: TextDirection.rtl,
                        style: getTextSyle(16, kPrimaryColor),),
                    ),


                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(" ${googlePlayUrl} \n رابط التطبيق",textDirection: TextDirection.rtl,style: getTextSyle(16, Colors.blue),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("قم بإدخال الكود التالي عند التسجيل واكسب نقاط لتسريع تفسير حلمك",
                        textDirection: TextDirection.rtl,style: getTextSyle(16, kPrimaryColor),),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("${userInfo.userSpecialCode}",textDirection: TextDirection.rtl,style: getTextSyle(16, Colors.blue),),
                    ),

                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: MyButton(
                            txt: cancel,
                            raduis: 4,
                            press: () {
                              openPageAndClearPrev(context:context,page: GeneralPageClient(),route: HomePageRoute);
                            },
                            borderColor: Colors.transparent,
                            borderWidth: 0,
                            buttonColor: Colors.white,
                            textStyle: getTextSyle(16, kPrimaryColor),
                          ),
                        ),

                        SizedBox(width: 8,),
                        Expanded(
                          child: MyButton(
                            txt:share,
                            raduis: 4,
                            press: () async {

                       var response=     await FlutterShare.share(
                                  title: 'يرجى مشاركة هذا الرابط ',

                                  text:
                                  '  ${serviceProvider}: ${widget.name}\n ${specalist}: ${widget.userWorkname}\n${shareHitn2}\n${userInfo.userSpecialCode}',
                                  linkUrl:
                                  '${linkApp} \n ${googlePlayUrl}',
                                  chooserTitle:
                                  'share');


                       if(response)
                           Navigator.of(context).pop("hassan");




                            },
                            borderColor: Colors.transparent,
                            borderWidth: 0,


                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ))),
    );
  }
}

