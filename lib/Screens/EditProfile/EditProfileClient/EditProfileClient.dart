import 'dart:io';

import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:faserholmak/Dialog/DialogCode/MyCountryPickerDialog.dart';
import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/HassanCountry.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';

import 'package:faserholmak/Model/WorkTypeUser/Value.dart';

import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';

import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/components/rounded_button.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/MyCircularIcon.dart';
import 'package:faserholmak/wigets/MyCircularImage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../../app_localizations.dart';

class EditProfileClient extends StatefulWidget {
  List<Value> userWorks;


  EditProfileClient({this.userWorks});

  @override
  _EditProfileClientState createState() => _EditProfileClientState();
}

class _EditProfileClientState extends State<EditProfileClient> {
  TextEditingController nameController = TextEditingController();






  int picID;
  File profileImage;
  bool erros=false;

  @override
  void initState() {
    super.initState();
    nameController=new TextEditingController(text: userInfo.name);

  }





  bool isLoading = false;

  var formKeyValidation = GlobalKey<FormState>();



  void reSetLoading(bool state) {
    setState(() {
      isLoading = state;
    });
  }


  Widget initAddIconButton(){

    return IconButton(
      splashColor: Colors.grey,
      icon: Icon(Icons.add),
      padding: EdgeInsets.all(0),

      onPressed:() async {
        File i=await getImageFromGallery(quality: 40);
        reSetLoading(true);
        var response=await uploadUserImage(i.path);
        reSetLoading(false);

        if(response.statusCode==200)
          setState(() {
            picID=response.object;
            profileImage=i;
          });
        else showToast(response.object.toString());

      },);
  }



  Map<String,dynamic> initMap(){


    Map<String,dynamic>  item={
      "name":nameController.text.toString().trim(),

      "pictureId":"$picID",
      "id":userInfo.id,


    };
    return item;
  }




  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text(AppLocalizations.of(context).translate("editProfile"),style: getTextSyle(16, Colors.white),textDirection: TextDirection.rtl,),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Background(
            topAlignment: true,
            child: SingleChildScrollView(
              child: Form(
                key: formKeyValidation,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),

                      Container(

                        child: Stack(
                          children: <Widget>[
                            profileImage==null?MyCircularImage(180,180,linkImg:imageUrl+emptyString(userInfo.pictureId) ,):
                            MyCircularImage(180,180,fileImg: profileImage,),
                            Positioned(child:MyCircularIcon(30,30,icon: initAddIconButton()),
                              top: 120,left: 130,)
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 50,
                      ),
                      /*name*/
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: erros?Colors.transparent:kPrimaryLightColor
                        ),
                        child: TextFormField(
                          maxLines: 1,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                          ),
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          cursorColor: kPrimaryColor,
                          decoration: getInputDecorationHassan(label: AppLocalizations.of(context).translate("name")),
                          validator: (String item) {
                            if (nameController.text.isEmpty)
                              return AppLocalizations.of(context).translate("emptyValidation");
                            else
                              return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      RoundedButton(
                        text: AppLocalizations.of(context).translate("save"),
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        press: () async {
                          if(validationForm(formKeyValidation)){




                              reSetLoading(true);
                              //     await loginRQ(initMapLogin());
                              var response=await editAccountMofaserRQ(initMap());
                              if(response.statusCode==200){
                                await getUserInfoRQ(token: token).then((onValue){
                                  openPageAndClearPrev(context: context,route:HomePageRoute,page: GeneralPageClient() );

                                });
                              }
                              reSetLoading(false);


                            setState(() {
                              erros=false;
                            });

                          }else{
                            setState(() {
                              erros=true;
                            });
                          }

                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomeVisitor();
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
        ),
      ),

    );
  }
}
