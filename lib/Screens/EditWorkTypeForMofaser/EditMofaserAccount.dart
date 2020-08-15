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

class EditMofaserAccount extends StatefulWidget {
  List<Value> userWorks;


  EditMofaserAccount({this.userWorks});

  @override
  _EditMofaserAccountState createState() => _EditMofaserAccountState();
}

class _EditMofaserAccountState extends State<EditMofaserAccount> {
  TextEditingController nameController = TextEditingController();



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

    if(getIndexOfGender()!=-1)
      genderSelected=genderList.elementAt(getIndexOfGender());
    if(getIndexOfSocial()!=-1)
      socialStatusSelected=socialStatusList.elementAt(getIndexOfSocial());
    if(getIndexOfContryName()!=-1)
      countrySelected=myCountry.elementAt(getIndexOfContryName());
    descController=new TextEditingController(text: emptyString(userInfo.personalDescription));
    nameController=new TextEditingController(text: emptyString(userInfo.name));
    workController=new TextEditingController(text: emptyString(userInfo.jobDescription));
    ageController=new TextEditingController(text: emptyString(userInfo.age.toString()));



   // genderSelected=new DropDownItem(userInfo.sex);
   // socialStatusSelected=new DropDownItem(userInfo.socialStatus);
   // countrySelected=new Country(name: userInfo.country);
  }


  
  
  int getIndexOfGender(){
    for(int i=0;i<genderList.length;i++){

      if(userInfo.sex.toLowerCase()==genderList.elementAt(i).name.toLowerCase())
        return i;
    }
    
    return -1;
  }

  int getIndexOfSocial(){
    for(int i=0;i<socialStatusList.length;i++){

      if(userInfo.martialStatus.toLowerCase()==socialStatusList.elementAt(i).name.toLowerCase())
        return i;
    }

    return -1;
  }

  int getIndexOfContryName(){
    for(int i=0;i<myCountry.length;i++){

      if(userInfo.country.toLowerCase()==myCountry.elementAt(i).name.toLowerCase())
        return i;
    }

    return -1;
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






  Map<String,dynamic> initMap(){

       Map<String,dynamic>  item={
      "name":nameController.text.toString().trim(),
      "age":ageController.text.trim().toString(),
      "pictureId":"$picID",
      "id":userInfo.id,
      "country":countrySelected.name,
      "sex":genderSelected.name,
      "martialStatus":socialStatusSelected.name.toString(),
      "jobDescription":workController.text.trim().toString(),
      "personalDescription":descController.text.toString().trim(),


    };
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
          title: Text(editProfile,style: getTextSyle(16, Colors.white),textDirection: TextDirection.rtl,),
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
                            profileImage==null?MyCircularImage(180,180,linkImg:imageUrl+userInfo.pictureId ,):
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
                        text: save,
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        press: () async {
                          if(validationForm(formKeyValidation)){



                             if(genderSelected==null)
                              showToast(genderValidation);
                            else if(socialStatusSelected==null)
                              showToast(socialStatusValidation);

                            else{

                              reSetLoading(true);
                              //     await loginRQ(initMapLogin());
                              var response=await editAccountMofaserRQ(initMap());
                              if(response.statusCode==200){
                                await getUserInfoRQ(token: token).then((onValue){
                                  openPageAndClearPrev(context: context,page: new GeneralPageServicesProvider(),route: HomePageRoute2);
                                });
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
