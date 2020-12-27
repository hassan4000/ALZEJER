import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/reCode/CodeRe.dart';
import 'package:faserholmak/components/rounded_button.dart';
import 'package:faserholmak/components/rounded_input_field.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../app_localizations.dart';
import '../../constants.dart';

class Code extends StatefulWidget {
  const Code({
    Key key,
  }) : super(key: key);

  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
  var formKeyValidation = GlobalKey<FormState>();
  bool isLoading=false;

  TextEditingController emailController=TextEditingController();
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
        title: Text(AppLocalizations.of(context).translate("SendTheCode"),style: getTextSyle(16, Colors.white),),
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
                    Text(
                      AppLocalizations.of(context).translate("SendTheCode"),
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                         // textDirection: TextDirection.rtl,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          cursorColor: kPrimaryColor,
                          decoration: getInputDecorationHassan(label:AppLocalizations.of(context).translate("email"),icon: Icon(Icons.email,color: kPrimaryColor,)),
                          validator: (String item) {
                            if (emailController.text.isEmpty)
                              return AppLocalizations.of(context).translate("emptyValidation");
                            if(!validateEmail(emailController.text.trim()))
                              return  AppLocalizations.of(context).translate("emailValidation");
                            return null;
                          }

                      ),
                    ),
                   SizedBox(height: 10,),
                   MyButton(
                     txt: AppLocalizations.of(context).translate("SendTheCode"),
                     press: () async {
                      if(validationForm(formKeyValidation)){
                        setState(() {
                          erros=false;
                          isLoading=true;
                        });

                        var response=await getCodeFromEmail(emailController.text.toString());

                        if(response.statusCode==200)
                        openPage(context, CodeRe(emailController.text.toString()));

                        setIsLoading(false);
                      }

                      else {
                        setState(() {
                          erros=true;
                        });
                      }
                     },
                   )
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