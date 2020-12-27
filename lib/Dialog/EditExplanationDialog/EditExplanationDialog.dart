import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/Helper/Content.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';
import '../../constants.dart';

class EditExplanationDialog extends StatefulWidget {
  String servicesID;

  String txt;


  EditExplanationDialog(this.servicesID,this.txt);

  @override
  _EditExplanationDialogState createState() => _EditExplanationDialogState();
}



class _EditExplanationDialogState extends State<EditExplanationDialog> {

  Map<String,dynamic> initMap(){
    Map<String,dynamic> data={
      "Explanation":textEditingController.text.toString().trim(),
      "id":"${widget.servicesID}",
    };

    return data;
  }

  @override
  void initState() {
    textEditingController=TextEditingController(text: widget.txt);
    super.initState();
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
          Text(AppLocalizations.of(context).translate("editExplnation"),
              style:
              getTextSyle(20, kPrimaryColor, fontWeight: FontWeight.w600)),
        ],
      ),
      content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: isLoading
              ? Container(
            height: MediaQuery.of(context).size.height/2,
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
                  children: <Widget>[
                    TextFormField(
                      controller: textEditingController,
                      decoration: getInputDecorationHassan(
                          hint:AppLocalizations.of(context).translate("sendComments"),
                          icon: Icon(
                            Icons.description,
                            color: kPrimaryColor,
                          )),
                   //   textDirection: TextDirection.rtl,
                      textAlign: TextAlign.start,
                      minLines: 6,
                      maxLines: 10,
                      autocorrect: false,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                      ),
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
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
                            txt:  AppLocalizations.of(context).translate("cancel"),
                            raduis: 4,
                            press: () {
                              Navigator.of(context).pop();
                            },
                            borderColor: Colors.transparent,
                            borderWidth: 0,
                            buttonColor: Colors.white,
                            textStyle: getTextSyle(16, kPrimaryColor),
                          ),
                        ),

                        SizedBox(width: 10,),
                        Expanded(
                          child: MyButton(
                            txt:  AppLocalizations.of(context).translate("editTxt"),
                            raduis: 4,
                            press: () async {
                              if(textEditingController.text.toString().isEmpty)
                                showToast(AppLocalizations.of(context).translate("addAllEmptyField"));
                              else{
                                setState(() {
                                  isLoading=true;
                                });


                                var response=await EditTextClientRQ(initMap());
                                if(response.statusCode==200){
                                  Navigator.of(context).pop(textEditingController.text.toString().trim());
                                }

                                setState(() {
                                  isLoading=false;
                                });
                              }
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
