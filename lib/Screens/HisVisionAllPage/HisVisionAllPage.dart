import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/HassanCountry.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AddServices/AddServiceModel.dart';
import 'package:faserholmak/Model/DropDownItem.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/SendDream/SendDreamV2.dart';
import 'package:faserholmak/components/rounded_button.dart';
import 'package:flutter/material.dart';


import '../../app_localizations.dart';
import '../../constants.dart';

class HisVisionAllPage extends StatefulWidget {

  AddServiceModel addServiceModel;

  HisVisionAllPage({this.addServiceModel});

  @override
  _HisVisionAllPageState createState() => _HisVisionAllPageState();
}

class _HisVisionAllPageState extends State<HisVisionAllPage> {


  TextEditingController nameControler=TextEditingController();
  //TextEditingController dreamTimeControler=TextEditingController();

  bool erros=false;




  var formKeyValidation = GlobalKey<FormState>();

  DateTime selectedDate;
  Country countrySelected;
  DropDownItem genderSelected;
  DropDownItem socialStatusSelected;
  DropDownItem workStatusSelected;

  DropDownItem childernSelected;
 // DropDownItem insomniaSelected;
  DropDownItem praySelected;
  DropDownItem religiousSelected;
  DropDownItem exorcismSelected;
  FocusNode myFocusNode;


  bool maleSelected(){
    if(genderSelected==null ||genderSelected.name==null ||genderSelected.name==male)
      return true;
    else return false;

  }
  List<DropDownItem> genderList = <DropDownItem>[
    const DropDownItem("male"),
    const DropDownItem("female"),
  ];

  List<DropDownItem> socialStatusList = <DropDownItem>[
    const DropDownItem("single",),
    const DropDownItem("marred",),
    const DropDownItem("divorcee",),
  ];



  List<DropDownItem> childernList = <DropDownItem>[
    const  DropDownItem("ThereAreChildren",),
    const DropDownItem("ThereIsNoChildren",),

  ];

  List<DropDownItem> workList = <DropDownItem>[
    const   DropDownItem("heHasWork"),
    const   DropDownItem("heHasnotWork"),
    const DropDownItem("studying"),

  ];

  List<DropDownItem> prayList = <DropDownItem>[
    const DropDownItem("yes",state: true),
    const  DropDownItem("no",state: false),
  ];

  List<DropDownItem> religiousList = <DropDownItem>[
    const   DropDownItem("committed",),
    const  DropDownItem("halfCommitted"),
    const  DropDownItem("noCommitted"),

  ];

  List<DropDownItem> insomniaList = <DropDownItem>[
    const DropDownItem("yes",state: true),
    const  DropDownItem("no",state: false),
  ];
  List<DropDownItem> exorcismList = <DropDownItem>[
    const DropDownItem("yes",state: true),
    const  DropDownItem("no",state: false),
  ];


  var date = DateTime.now();
  List<Country>myCountry=List();
  @override
  void initState() {
    myFocusNode=FocusNode();
    setState(() {
    //  myCountry=addCountreisHasssan();
      myCountry=countryList;
    });
    super.initState();

  }

  @override
  void dispose() {
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      top: true,
      child: GestureDetector(

        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppLocalizations.of(context).translate("ServiceOwner")),
          ),
          body: Background(

            child: SingleChildScrollView(
              child: Form(
                key: formKeyValidation,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 24,),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: erros?Colors.transparent:kPrimaryLightColor
                        ),
                        child: TextFormField(

                            maxLines: 1,
                          //  textDirection: TextDirection.rtl,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: kPrimaryColor,fontSize: 20,),
                            keyboardType: TextInputType.text,
                            controller: nameControler,
                            focusNode: myFocusNode,

                            cursorColor: kPrimaryColor,
                            decoration:getInputDecorationHassan(label: AppLocalizations.of(context).translate("name")),
                            validator: (String item) {
                              if (nameControler.text.isEmpty)
                                return AppLocalizations.of(context).translate("emptyValidation");
                              else
                                return null;
                            }


                        ),
                      ),
                      SizedBox(height: 20,),
                     /* GestureDetector(
                        onTap: (){
                   *//*       showDatePicker(
                            context: context,
                            initialDate: date == null ? DateTime.now() : date,
                              firstDate: DateTime(DateTime.now().year-1,11),
                              lastDate: DateTime(DateTime.now().year+1,1)

                          ).then((onValue){
                            setState(() {
                              date=onValue;

                            });
                            dreamTimeControler.text='${onValue.year}-${getZeroWithNumber(date.month)}-${getZeroWithNumber(date.day)}';
                          });*//*
                      *//*    showMaterialDatePicker(
                            context: context,
                            selectedDate: date,
                            onCancelled: (){},
                            cancelButtonLabel: "",
                            onChanged: (value) {

                            },
                          );*//*
                       *//* .then((onValue){

                            selectedDate=onValue;
                            setState(() {
                              dreamTimeControler.text='${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                            });

                          });*//*
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: erros?Colors.transparent:kPrimaryLightColor
                          ),
                          child: TextFormField(


                              maxLines: 1,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.start,
                              style: TextStyle(color: kPrimaryColor,fontSize: 20,),
                              keyboardType: TextInputType.text,
                              controller: dreamTimeControler,
                              cursorColor: kPrimaryColor,
                              decoration:getInputDecorationHassan(label: whenWasTheDream,
                                icon:Icon(Icons.timelapse,color: kPrimaryColor,), ),
                              validator: (String item) {
                                if (dreamTimeControler.text.isEmpty)
                                  return emptyValidation;
                                else
                                  return null;
                              }


                          ),
                        ),
                      ),
                      SizedBox(height: 24,),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[

                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                  border:Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  )
                              ),
                              child: DropdownButton<DropDownItem>(
                                isExpanded: true,
                                underline: Container(),
                                elevation: 10,

                                hint:  Text(AppLocalizations.of(context).translate("gener")),
                                value: genderSelected,

                                onChanged: (DropDownItem Value) {


                                  setState(() {

                                   // FocusScope.of(context).unfocus();
                                    genderSelected = Value;
                                  });
                                },
                                items: genderList.map((DropDownItem data) {
                                  return  DropdownMenuItem<DropDownItem>(
                                    value: data,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[


                                        Text(
                                    AppLocalizations.of(context).translate(data.name.toString()),
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                  border:Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  )
                              ),
                              child: DropdownButton<DropDownItem>(
                                isExpanded: true,
                                underline: Container(),
                                elevation: 10,

                                hint:  Text(AppLocalizations.of(context).translate("socialStatus")),
                                value: socialStatusSelected,
                                onChanged: (DropDownItem Value) {
                                  setState(() {
                                    socialStatusSelected = Value;
                                  });
                                },
                                items: socialStatusList.map((DropDownItem data) {
                                  return  DropdownMenuItem<DropDownItem>(
                                    value: data,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[


                                        Text(
                                    AppLocalizations.of(context).translate(data.name.toString()),
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(color: Colors.black),
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
                      SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                  border:Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  )
                              ),
                              child: DropdownButton<DropDownItem>(
                                isExpanded: true,
                                hint:  Text(AppLocalizations.of(context).translate("workStatus")),
                                value: workStatusSelected,
                                underline: Container(),
                                onChanged: (DropDownItem Value) {
                                  setState(() {
                                    workStatusSelected = Value;
                                  });
                                },
                                items: workList.map((DropDownItem data) {
                                  return  DropdownMenuItem<DropDownItem>(
                                    value: data,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[


                                        Text(
                                    AppLocalizations.of(context).translate(data.name.toString()),
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                       /*   Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                  border:Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  )
                              ),
                              child: DropdownButton<DropDownItem>(
                                isExpanded: true,
                                underline: Container(),
                                elevation: 10,

                                hint:  Text(doYouHaveinsomnia),
                                value: insomniaSelected,
                                onChanged: (DropDownItem Value) {
                                  setState(() {
                                    insomniaSelected = Value;
                                  });
                                },
                                items: insomniaList.map((DropDownItem data) {
                                  return  DropdownMenuItem<DropDownItem>(
                                    value: data,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[


                                        Text(
                                          data.name.toString(),
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                      SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(

                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                  border:Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  )
                              ),
                              child: DropdownButton<Country>(
                                isExpanded: true,
                                hint:  Text(AppLocalizations.of(context).translate("country")),
                                value: countrySelected,
                                underline: Container(),
                                onChanged: (Country Value) {
                                  setState(() {
                                    countrySelected = Value;
                                  });
                                },
                                items: myCountry.map((Country data) {
                                  return  DropdownMenuItem<Country>(
                                    value: data,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[


                                        Flexible(
                                          child: Text(
                                            data.name.toString(),
                                            textAlign: TextAlign.center,
                                            style:  TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          maleSelected()?Container():Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                  border:Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  )
                              ),
                              child: DropdownButton<DropDownItem>(
                                isExpanded: true,
                                hint:  Text(AppLocalizations.of(context).translate("doYouhaveChildern")),
                                value: childernSelected,
                                underline: Container(),
                                onChanged: (DropDownItem Value) {
                                  setState(() {
                                    childernSelected = Value;
                                  });
                                },
                                items: childernList.map((DropDownItem data) {
                                  return  DropdownMenuItem<DropDownItem>(
                                    value: data,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[


                                        Text(
                                          data.name.toString(),
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(color: Colors.black),
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
                      SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                         /* Expanded(

                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                  border:Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  )
                              ),
                              child: DropdownButton<DropDownItem>(
                                isExpanded: true,
                                hint:  Text(didYouExorcism),
                                value: exorcismSelected,
                                underline: Container(),
                                onChanged: (DropDownItem Value) {
                                  setState(() {
                                    exorcismSelected = Value;
                                  });
                                },
                                items: exorcismList.map((DropDownItem data) {
                                  return  DropdownMenuItem<DropDownItem>(
                                    value: data,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[


                                        Text(
                                          data.name.toString(),
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),*/
                         /* Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                  border:Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  )
                              ),
                              child: DropdownButton<DropDownItem>(
                                isExpanded: true,
                                underline: Container(),
                                elevation: 10,

                                hint:  Text(religiousState),
                                value: religiousSelected,
                                onChanged: (DropDownItem Value) {
                                  setState(() {
                                    religiousSelected = Value;
                                  });
                                },
                                items: religiousList.map((DropDownItem data) {
                                  return  DropdownMenuItem<DropDownItem>(
                                    value: data,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[


                                        Text(
                                          data.name.toString(),
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                   //   SizedBox(height: 24,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[

                        /*  Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                  border:Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  )
                              ),
                              child: DropdownButton<DropDownItem>(
                                isExpanded: true,
                                underline: Container(),
                                elevation: 10,

                                hint:  Text(didYouPrayBeforeDreams),
                                value: praySelected,
                                onChanged: (DropDownItem Value) {
                                  setState(() {
                                    praySelected = Value;
                                  });
                                },
                                items: prayList.map((DropDownItem data) {
                                  return  DropdownMenuItem<DropDownItem>(
                                    value: data,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[


                                        Text(
                                          data.name.toString(),
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),*/
                        ],
                      ),

                      RoundedButton(
                        text: AppLocalizations.of(context).translate("next"),
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        press: () {

                          if(validationForm(formKeyValidation)){

                            List<DropDownItem> dataList=List();
                            if(maleSelected()){ childernSelected=DropDownItem("");}

                            dataList.add(socialStatusSelected);
                            dataList.add(genderSelected);
                          //  dataList.add(insomniaSelected);
                            dataList.add(workStatusSelected);
                            dataList.add(childernSelected);

                        //    dataList.add(religiousSelected);
                       //     dataList.add(exorcismSelected);
                          //  dataList.add(praySelected);

                            for(DropDownItem item in dataList){
                              if(item==null ||item.name==null){
                                showToast(addAllEmptyField);
                                return;
                              }
                            }

                            if(countrySelected==null ||countrySelected.name==null) {
                              showToast(addAllEmptyField);
                              return;
                            }

                            widget.addServiceModel.socialStatus=socialStatusSelected.name;
                            widget.addServiceModel.sex=genderSelected.name;
                            //widget.addServiceModel.isThereWakefulness=insomniaSelected.state;
                            widget.addServiceModel.isThereWakefulness=false;
                           widget.addServiceModel.jobStatus=workStatusSelected.name;
                            widget.addServiceModel.kidsStatus=childernSelected.name;
                            widget.addServiceModel.name=nameControler.text.toString();
                            widget.addServiceModel.dreamDate='2020-01-01T00:00:00';
                           // widget.addServiceModel.dreamDateText=dreamTimeControler.text.toString();
                            widget.addServiceModel.dreamDateText="";


                            widget.addServiceModel.country=countrySelected.name;
                           // widget.addServiceModel.regligionStatus=religiousSelected.name;
                            widget.addServiceModel.regligionStatus="";
                          //  widget.addServiceModel.didYouExorcism=exorcismSelected.state;
                            widget.addServiceModel.didYouExorcism=false;
                           // widget.addServiceModel.didYouExorcism=false;
                           // widget.addServiceModel.haveYouPrayedBeforeTheDream=praySelected.state;
                            widget.addServiceModel.haveYouPrayedBeforeTheDream=false;


                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SendDreamV2(widget.addServiceModel);
                                },
                              ),
                            );
                          }else{

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
      ),
    );
  }
}
