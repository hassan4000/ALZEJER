import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/forgetPass/ResetPass.dart';
import 'package:faserholmak/components/rounded_button.dart';
import 'package:faserholmak/components/rounded_password_field.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../app_localizations.dart';
import '../../constants.dart';

class CodeRe extends StatefulWidget {

  String email;

  CodeRe(this.email);



  @override
  _CodeReState createState() => _CodeReState();
}

class _CodeReState extends State<CodeRe> {

  var formKeyValidation = GlobalKey<FormState>();
  bool isLoading=false;

  TextEditingController codeController=TextEditingController();
  bool erros=false;

  void  setIsLoading(bool state){

    setState(() {
      isLoading=state;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("ConfirmTheCode"),style: getTextSyle(16, Colors.white),),
      ),
      body:ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Background(
          topAlignment: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKeyValidation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/password.png",
                      width: size.width * 0.35,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context).translate("codeSendTime"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    /*SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),*/
                    SizedBox(height: size.height * 0.03),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: erros?Colors.transparent:kPrimaryLightColor
                      ),
                      child: TextFormField(
                          maxLines: 1,

                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: codeController,
                          cursorColor: kPrimaryColor,
                          decoration: getInputDecorationHassan(label: code,icon: Icon(Icons.code,color: kPrimaryColor,)),
                          validator: (String item) {
                            if (codeController.text.isEmpty)
                              return AppLocalizations.of(context).translate("emptyValidation");

                            return null;
                          }

                      ),
                    ),
                    SizedBox(height: 10,),
                    MyButton(
                      txt: AppLocalizations.of(context).translate("reSendCode"),
                      press: () async {
                        if(validationForm(formKeyValidation)){
                          setState(() {
                            erros=false;
                            isLoading=true;
                          });



                          var response=await getCodeFromEmail(widget.email);

                        setIsLoading(false);
                        }

                        else {
                          setState(() {
                            erros=true;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10,),
                    MyButton(
                      txt: AppLocalizations.of(context).translate("ConfirmTheCode"),
                      press: () async {
                        if(validationForm(formKeyValidation)){
                          setState(() {
                            erros=false;
                            isLoading=true;
                          });


                          var response=await checkCode(email: widget.email,code: codeController.text.toString().trim());
                          if(response.statusCode==200)
                            openPage(context, ResetPass(widget.email));

                          setIsLoading(false);

                        }

                        else {
                          setState(() {
                            erros=true;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/*
تأكيد الرمز
إعادة الإرسال
ResetPass();*/
