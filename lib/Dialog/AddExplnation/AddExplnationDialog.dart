import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/Helper/Content.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class AddExplnationDialog extends StatefulWidget {
  String servicesID;
  bool fromPublicPage=false;
  String clientToken;

  AddExplnationDialog({this.servicesID,this.fromPublicPage=false,this.clientToken});

  @override
  _AddExplnationDialogState createState() => _AddExplnationDialogState();
}

class _AddExplnationDialogState extends State<AddExplnationDialog> {
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
          Text("اضف تفسير  ",
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
                            'الرجاء الانتظار ..',
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
                            hint: "اضف تفسير",
                            icon: Icon(
                              Icons.description,
                              color: kPrimaryColor,
                            )),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.start,
                        minLines: 4,
                        maxLines: 6,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
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
                              txt: cancel,
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

                          SizedBox(width: 4,),
                          Expanded(
                            child: MyButton(
                              txt: add,
                              raduis: 4,
                              press: () async {
                                if(textEditingController.text.toString().isEmpty)
                                  showToast(addAllEmptyField);
                                else{
                                  setState(() {
                                    isLoading=true;
                                  });


                                  var response=await addExplanationRQ(
                                      id: widget.servicesID,
                                      txt: textEditingController.text.toString(),
                                      fromPublicPage: widget.fromPublicPage,
                                  providerID: userInfo.id);
                                  if(response.statusCode==200){

                                    await sendAndRetrieveMessage(body: "${userInfo.name}  تم التفسير من قبل المفسر ",
                                    title: " تم التفسير بنجاح ",clientToken: widget.clientToken).then((onValue){
                                      Navigator.of(context).pop("hassan");
                                    });

                                    //showToast(successfulAddExplnation);

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
