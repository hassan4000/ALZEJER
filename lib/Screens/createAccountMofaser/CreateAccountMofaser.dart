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
import 'package:faserholmak/Model/DropDownItem.dart';
import 'package:faserholmak/Model/PostCreatAccountMofaser/PostCreatAccountMofaserModel.dart';
import 'package:faserholmak/Model/WorkTypeUser/Value.dart';

import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/Screens/GeneralPageServicesProvider/GeneralPageServicesProvider.dart';
import 'package:faserholmak/Screens/HomePageForVisitor/HomeVisitor.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/components/rounded_button.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/MyCircularIcon.dart';
import 'package:faserholmak/wigets/MyCircularImage.dart';
import 'package:faserholmak/wigets/MyCountryPicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CreateAccountMofaser extends StatefulWidget {
  List<Value> userWorks;


  CreateAccountMofaser({this.userWorks});

  @override
  _CreateAccountMofaserState createState() => _CreateAccountMofaserState();
}

class _CreateAccountMofaserState extends State<CreateAccountMofaser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  Country selectedCountry;

  List<Country>myCountry=List();
  int picID;
  File profileImage;
  bool erros=false;

  @override
  void initState() {
    super.initState();
    setState(() {
      myCountry=addCountreisHasssan();
    });

    selectedCountry=initCountry("971");
  }


  /*--------------------------------Widget----------------------*/
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

 Widget initAddCountryPrefixIcon(){
    return GestureDetector(
      onTap: () async {
        var item= await openCountryDialog(context,onValuePicked: (country){
          setState(() {
            selectedCountry=country;
          });


        });

      },
      child: MyCountryPicker(country: selectedCountry,padding: 2 ,),
    );
 }


  //final picker = ImagePicker();

  bool shildPasswrod = true;
  bool reShildPasswrod = true;
  bool isLoading = false;

  var formKeyValidation = GlobalKey<FormState>();

  void reSetShild() {
    setState(() {
      shildPasswrod = !shildPasswrod;
    });
  }

  void reSetLoading(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  void reSetReShild() {
    setState(() {
      reShildPasswrod = !reShildPasswrod;
    });
  }

  Country countrySelected;
  DropDownItem genderSelected;
  DropDownItem socialStatusSelected;



  Map<String,dynamic>initMapLogin(){
    Map<String,dynamic> data={
      "username":userNameController.text.trim().toString(),
      //"username":"tes5",
      "password":passwordController.text.trim().toString(),
      //"password":"123456",
      "grant_type":"password"
    };

    return data;
  }
  Future<void> loginRQ(Map<String,dynamic>map) async {

    var loginResponse=await loginNormal(map);
    if(loginResponse.statusCode==200){
      print("-----------------------USERINFO----------------------------");
      var userDataRequest=await getUserInfoRQ(token: loginResponse.object.toString());
      if(userDataRequest.statusCode==200){

        var addUserWorkResponse= await addUserWorkToMofaser(widget.userWorks,userInfo.id);
        if(addUserWorkResponse.statusCode==200)
        openPageAndClearPrev(context: context,page: new GeneralPageServicesProvider(),route: HomePageRoute2);
      }
    }

  }

  PostCreatAccountMofaserModel initMap(){


    PostCreatAccountMofaserModel item=PostCreatAccountMofaserModel(

      name: nameController.text.toString().trim(),
      email: emailController.text.toString().trim(),
      password: passwordController.text.toString().trim(),
      confirmPassword: rePasswordController.text.toString().trim(),
      age:  int.parse(ageController.text.trim().toString()),
      pictureId: picID.toString(),
      sex: genderSelected.name,
      country: countrySelected.name,
      type: interpreterTxt,
      martialStatus: socialStatusSelected.name.toString(),
      jobDescription:workController.text.trim().toString() ,
      phoneNumber: selectedCountry.phoneCode+phoneController.text.toString().trim(),
      username: userNameController.text.toString().trim(),
      personalDescription: descController.text.toString().trim(),
    //  userWork: widget.userWorks

    );

 /*   Map<String,dynamic>  data={
      "name":nameController.text.toString().trim(),
      "email":emailController.text.toString().trim(),
      "password":passwordController.text.toString().trim(),
      "confirmPassword":rePasswordController.text.toString().trim(),
      "age":ageController.text.trim().toString(),
      "pictureId":"$picID",
      "sex":genderSelected.name,
      "country":countrySelected.name,
      "type":interpreterTxt,
      "martialStatus":socialStatusSelected.name.toString(),
      "jobDescription":workController.text.trim().toString(),
      "phoneNumber":selectedCountry.phoneCode+phoneController.text.toString().trim(),
      "username":userNameController.text.toString().trim(),
      "personalDescription":descController.text.toString().trim(),


    };*/
    return item;
  }

  List<DropDownItem> genderList = <DropDownItem>[
    const DropDownItem(
      'ذكر',
    ),
    const DropDownItem(
      'انثى',
    ),
  ];

  List<DropDownItem> socialStatusList = <DropDownItem>[
    const DropDownItem(
      'اعزب',
    ),
    const DropDownItem(
      'متزوج',
    ),
    const DropDownItem(
      'مطلق',
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          title: Text(hireMe,style: getTextSyle(16, Colors.white),textDirection: TextDirection.rtl,),
        ),
          body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Background(
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
                            decoration: getInputDecorationHassan(label: name),
                            validator: (String item) {
                              if (nameController.text.isEmpty)
                                return emptyValidation;
                              else
                                return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        /*userName*/
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
                              controller: userNameController,
                              cursorColor: kPrimaryColor,
                              decoration: getInputDecorationHassan(label: userName),
                              validator: (String item) {
                                if (userNameController.text.isEmpty)
                                  return emptyValidation;

                                  return null;
                              }),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        /*email*/
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
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              cursorColor: kPrimaryColor,
                              decoration: getInputDecorationHassan(label: email,icon: Icon(Icons.email,color: kPrimaryColor,)),
                              validator: (String item) {
                                if (emailController.text.isEmpty)
                                  return emptyValidation;
                                if(!validateEmail(emailController.text.trim()))
                                  return  emailValidation;
                                return null;
                              }

                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        /*phone*/
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
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              cursorColor: kPrimaryColor,
                              decoration: getInputDecorationCountry(myPrefix:initAddCountryPrefixIcon(),label: phone),
                              validator: (String item) {
                                if (phoneController.text.isEmpty)
                                  return emptyValidation;

                                return null;
                              }

                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        /*password*/
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                               color: erros?Colors.transparent:kPrimaryLightColor
                          ),
                          child: TextFormField(
                              obscureText: shildPasswrod,
                              maxLines: 1,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 20,
                              ),
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              cursorColor: kPrimaryColor,
                              decoration: getInputDecorationPassword(
                                  label: password,
                                  icon: Icon(Icons.remove_red_eye),
                                  pressPrifix: reSetShild,
                                  obsecure: shildPasswrod),

                              validator: (String item) {
                                if (passwordController.text.isEmpty)
                                  return emptyValidation;
                                if(!validatePassWord(passwordController.text.trim()))
                                  return passwordLengthValidation;
                                if(passwordController.text.trim()!=rePasswordController.text.trim())
                                  return  passwordValidation;

                                return null;
                              }



                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        /*rePassword*/
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                               color: erros?Colors.transparent:kPrimaryLightColor
                          ),
                          child: TextFormField(
                              obscureText: reShildPasswrod,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 20,
                              ),
                              keyboardType: TextInputType.text,
                              controller: rePasswordController,
                              cursorColor: kPrimaryColor,
                              decoration: getInputDecorationPassword(
                                  label: rePassword,
                                  icon: Icon(Icons.remove_red_eye),
                                  pressPrifix: reSetReShild,
                                  obsecure: reShildPasswrod),
                              validator: (String item) {
                                if (rePasswordController.text.isEmpty)
                                  return emptyValidation;
                                if(!validatePassWord(rePasswordController.text.trim()))
                                  return passwordLengthValidation;
                                if(passwordController.text.trim()!=rePasswordController.text.toString())
                                  return passwordValidation;


                                return null;
                              }
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),

                        /*work*/
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                               color: erros?Colors.transparent:kPrimaryLightColor
                          ),
                          child: TextFormField(
                            controller: workController,
                            decoration: getInputDecorationHassan(label: work,icon: Icon(Icons.work,color: kPrimaryColor,)),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20,
                            ),
                            keyboardType: TextInputType.text,
                            cursorColor: kPrimaryColor,
                              validator: (String item) {
                                if (workController.text.isEmpty)
                                  return emptyValidation;

                                return null;
                              }
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        /*AGE*/
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: erros?Colors.transparent:kPrimaryLightColor
                          ),
                          child: TextFormField(
                              controller: ageController,
                              decoration: getInputDecorationHassan(label: ageTxt,icon: Icon(Icons.perm_contact_calendar,
                                color: kPrimaryColor,)),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 20,
                              ),
                              keyboardType: TextInputType.numberWithOptions(decimal: false,signed: false),
                              cursorColor: kPrimaryColor,
                              validator: (String item) {
                                if (ageController.text.isEmpty)
                                  return emptyValidation;

                                return null;
                              }
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            /*gender*/
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  )),
                              child: DropdownButton<DropDownItem>(
                                hint: Text(gener),
                                value: genderSelected,
                                underline: Container(),
                                onChanged: (DropDownItem Value) {
                                  setState(() {
                                    genderSelected = Value;
                                  });
                                },
                                items: genderList.map((DropDownItem data) {
                                  return DropdownMenuItem<DropDownItem>(
                                    value: data,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          data.name.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            /*social status*/
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  )),
                              child: DropdownButton<DropDownItem>(
                                underline: Container(),
                                elevation: 10,
                                hint: Text(socialStatus),
                                value: socialStatusSelected,
                                onChanged: (DropDownItem Value) {
                                  setState(() {
                                    socialStatusSelected = Value;
                                  });
                                },
                                items: socialStatusList.map((DropDownItem data) {
                                  return DropdownMenuItem<DropDownItem>(
                                    value: data,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          data.name.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        /*country*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: kPrimaryLightColor,
                                    )),
                                child: DropdownButton<Country>(
                                  isExpanded: true,
                                  underline: Container(),
                                  elevation: 10,
                                  hint: Text(country),
                                  value: countrySelected,
                                  onChanged: (Country Value) {
                                    setState(() {
                                      countrySelected = Value;
                                    });
                                  },
                                  items: myCountry.map((Country data) {
                                    return DropdownMenuItem<Country>(
                                      value: data,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              data.name.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        /*desc*/
                        TextFormField(
                          controller: descController,
                          decoration: getInputDecorationHassan(hint: deschint1,icon: Icon(Icons.description,color: kPrimaryColor,)),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.start,
                          minLines: 3,
                          maxLines: 3,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                          ),
                          keyboardType: TextInputType.text,
                          cursorColor: kPrimaryColor,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        RoundedButton(
                          text: createAccount,
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          press: () async {
                            if(validationForm(formKeyValidation)){
                              

                              if(profileImage==null)
                                showToast(picValidation);
                             else if(genderSelected==null)
                                showToast(genderValidation);
                              else if(socialStatusSelected==null)
                                showToast(socialStatusValidation);
                              else if(countrySelected==null)
                                showToast(countryValidation);
                              else{

                                reSetLoading(true);
                           //     await loginRQ(initMapLogin());
                                var response=await createAccountMofaser(initMap());
                                if(response.statusCode==200){
                                 await loginRQ(initMapLogin());
                                }
                                reSetLoading(false);
                              }
                              
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
