import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AddServices/AddServiceModel.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/ServicePathList/ServicePathList.dart';
import 'package:faserholmak/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:faserholmak/Helper/Content.dart';

import '../app_localizations.dart';
import '../constants.dart';

class SendDreamV2 extends StatefulWidget {
  AddServiceModel addServiceModel;

  SendDreamV2(this.addServiceModel);

  @override
  _SendDreamV2State createState() => _SendDreamV2State();
}

class _SendDreamV2State extends State<SendDreamV2> {

  int  groupRAdioButton=2;
  bool isSwitched=true;
  TextEditingController descControler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("SendRequiredService")),
      ),
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    child: Text(AppLocalizations.of(context).translate("sendDreamsHeader"),style: getTextSyle(16, Colors.black),textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller:descControler ,
                    decoration: getInputDecorationHassan(hint: dreamsText),

                    textAlign: TextAlign.start,
                    minLines: 6,
                    maxLines: 8,
                    maxLength: 500,
                    maxLengthEnforced: true,
                    style: TextStyle(color: kPrimaryColor,fontSize: 20,),
                    keyboardType: TextInputType.text,
                    cursorColor: kPrimaryColor,
                  ),
                  SizedBox(height: 24,),

                  Text(AppLocalizations.of(context).translate("sendDreamCheckBoxHint"),style: getTextSyle(16, kPrimaryColor),
                 ),
                  SizedBox(height: 4,),
                  Row(

                    children: <Widget>[
                      Expanded(
                        child: RadioListTile(

                          groupValue: groupRAdioButton,
                          value: 1,
                          onChanged: (value){
                            setState(() {
                              groupRAdioButton=1;
                              isSwitched=false;
                            });
                          },

                          selected: false,


                          title: Text(AppLocalizations.of(context).translate("no"),style: TextStyle(),textAlign: TextAlign.center,),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          groupValue: groupRAdioButton,
                          value: 2,
                          onChanged: (value){
                            setState(() {
                              groupRAdioButton=2;
                              isSwitched=true;
                            });
                          },




                          title: Text(AppLocalizations.of(context).translate("yes"),style: TextStyle(),textAlign: TextAlign.center,),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24,),
                  RoundedButton(
                    text: next,
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    press: () {

                      if(descControler.text.trim().isEmpty){
                        showToast(addAllEmptyField);
                        return;
                      }

                      widget.addServiceModel.description=descControler.text.toString().trim();
                      widget.addServiceModel.publicServiceAction=isSwitched;


                      print(widget.addServiceModel.toJson());

                      openPage(context, ServicePathList(widget.addServiceModel));
                    /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SendDreamV2();
                          },
                        ),
                      );*/
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
