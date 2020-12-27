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

class DeleteServiceDialog extends StatefulWidget {
  String servicesID;

  String txt;


  DeleteServiceDialog(this.servicesID,{this.txt});

  @override
  _DeleteServiceDialogState createState() => _DeleteServiceDialogState();
}



class _DeleteServiceDialogState extends State<DeleteServiceDialog> {



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
          Text( deleteServiceText,
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

                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: MyButton(
                            txt: AppLocalizations.of(context).translate("cancel"),
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
                            txt: AppLocalizations.of(context).translate("deleteText"),
                            raduis: 4,
                            press: () async {

                                setState(() {
                                  isLoading=true;
                                });


                                var response=await deleteService(widget.servicesID);
                                if(response.statusCode==200){
                                  Navigator.of(context).pop(true);
                                }


                                setState(() {
                                  isLoading=false;
                                });

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
