import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/wigets/MyButton.dart';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../app_localizations.dart';
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
          Text(AppLocalizations.of(context).translate("ShareTheApp"),
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
                      AppLocalizations.of(context).translate("waitLittleBit"),
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
                  //textDirection: TextDirection.rtl,

                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("  ${AppLocalizations.of(context).translate("share_hint3")} \n  ${widget.name} ${AppLocalizations.of(context).translate("AppreciationTheProviderEfforts")}   ",
                        style: getTextSyle(16, kPrimaryColor),),
                    ),


                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(" ${googlePlayUrl} \n ${AppLocalizations.of(context).translate("linkApp")}",style: getTextSyle(16, Colors.blue),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(AppLocalizations.of(context).translate("share_hint4"),
                        style: getTextSyle(16, kPrimaryColor),),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("${userInfo.userSpecialCode}",style: getTextSyle(16, Colors.blue),),
                    ),

                    SizedBox(
                      height: 8,
                    ),


                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(AppLocalizations.of(context).translate("rateUsOnStore"),style: getTextSyle(16, Colors.blue),),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: MyButton(
                            txt:  AppLocalizations.of(context).translate("cancel"),
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
                                  title:AppLocalizations.of(context).translate("pleaseShareThisLink"),

                                  text:
                                  '  ${AppLocalizations.of(context).translate("serviceProvider")}: ${widget.name}\n ${AppLocalizations.of(context).translate("specalist")}: ${widget.userWorkname}\n${AppLocalizations.of(context).translate("shareHitn2")}\n${userInfo.userSpecialCode}',
                                  linkUrl:
                                  '${AppLocalizations.of(context).translate("linkApp")} \n ${googlePlayUrl}',
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

