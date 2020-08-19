import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/Helper/Content.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class AddCommentDialog extends StatefulWidget {
  String servicesID;
  List<String> clinetToken;
  List<String>  prividerToken;


  AddCommentDialog(this.servicesID,this.clinetToken,this.prividerToken);

  @override
  _AddCommentDialogState createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {

  Map<String,dynamic> initMap(){
    Map<String,dynamic> data={
      "Text":textEditingController.text.toString().trim(),
      "ServiceId":"${widget.servicesID}",
    };

    return data;
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
          Text( sendComments,
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
                      'انتظر قليلا ..',
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
                          hint: sendComments,
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

                        SizedBox(width: 10,),
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


                                var response=await AddCommentRQ(initMap());
                                if(response.statusCode==200){
                                  textEditingController.text="";
                                  CommentModel item=response.object;

                                  if(userInfo.type==interpreterTxt)
                                    await sendAndRetrieveMessage(body: " على خدمة لك  ${userInfo.name} علق   ",
                                        title: "${textEditingController.text.toString().trim()}",clientToken: widget.clinetToken).then((onValue){

                                      //    showToast(widget.clinetToken);
                                      Navigator.of(context).pop(item);
                                    });



                                  else if(userInfo.type==clientTxt)
                                      await sendAndRetrieveMessage(body: " على خدمة لك  ${userInfo.name} علق المستخدم  ",
                                          title: "${textEditingController.text.toString().trim()}",
                                          providerToken: widget.prividerToken).then((onValue){
                                        Navigator.of(context).pop(item);
                                      });

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
