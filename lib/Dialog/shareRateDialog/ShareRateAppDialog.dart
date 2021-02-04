import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import '../../app_localizations.dart';
import '../../constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareRateAppDialog extends StatefulWidget {


  ShareRateAppDialog();

  @override
  _ShareRateAppDialogState createState() => _ShareRateAppDialogState();
}

class _ShareRateAppDialogState extends State<ShareRateAppDialog> {


  _launchURL() async {
    const url = "$googlePlayUrlV1";
    if (await canLaunch(url)) {
      await launch(url).then((value) {
        print("HHHHHHHHHHHHHHHHHHHHHHHHH$value");
        Navigator.of(context).pop();


      });
    } else {
      throw 'Could not launch $url';
    }
  }

  bool isLoading = false;
  TextEditingController textEditingController = TextEditingController();

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
          Text(AppLocalizations.of(context).translate("sent_successfully"),
              style:
                  getTextSyle(16, kPrimaryColor, fontWeight: FontWeight.w600)),
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
                            AppLocalizations.of(context)
                                .translate("waitLittleBit"),
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
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("supportApplicationHint"),
                              style: getTextSyle(16, Colors.black), textAlign: TextAlign.center
                            ),
                          )
                        ],
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
                              txt: AppLocalizations.of(context)
                                  .translate("rate"),
                              raduis: 4,
                              press: () async {
                                _launchURL();



                              },
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                              buttonColor: Colors.white,
                              textStyle: getTextSyle(16, kPrimaryColor),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: MyButton(
                              txt: AppLocalizations.of(context)
                                  .translate("share"),
                              raduis: 4,
                              press: () async {

                                await FlutterShare.share(
                                    title:
                                    '${AppLocalizations.of(context).translate("pleaseShareThisLink")}',
                                    text:
                                    '${AppLocalizations.of(context).translate("shareHitn1")}\n ${userInfo.userSpecialCode}',
                                    linkUrl:
                                    ' ${AppLocalizations.of(context).translate("linkApp")} \n  ${googlePlayUrl}',
                                    chooserTitle: 'Share').then((value) {  Navigator.of(context).pop();});
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
