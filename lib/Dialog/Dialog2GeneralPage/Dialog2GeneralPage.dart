import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/ApplicationInfoModel/ApplicationInfoModel.dart';
import 'package:faserholmak/constants.dart';

import 'package:faserholmak/wigets/PersonalProfileContent.dart';
import 'package:faserholmak/wigets/list_title_dialog_info.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';


class Dialog2GeneralPage extends StatefulWidget {
  @override
  _Dialog2GeneralPageState createState() => _Dialog2GeneralPageState();
}

class _Dialog2GeneralPageState extends State<Dialog2GeneralPage> {


  bool isLoading=false;

  ApplicationInfoModel data;

  void getAllDataRQ()async{
    setState(() {
      isLoading=true;
    });

    var response=await getApplicationInfo();
    if(response.statusCode==200){
      setState(() {
        data=response.object;
      });
    }

    setState(() {
      isLoading=false;
    });
  }

  @override
  void initState() {
    if(mounted)
      getAllDataRQ();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          borderSide: BorderSide.none),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          SizedBox(
            width: 4.0,
          ),
          Text(
              AppLocalizations.of(context).translate("ApplicationStats"),
            style: getTextSyle(20, kPrimaryColor,fontWeight: FontWeight.w600)
          ),
        ],

      ),

      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: isLoading?Container(
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
                  AppLocalizations.of(context).translate("waitLittleBit"),
                  style: TextStyle(
                    fontFamily: 'Heading',
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                )),
          ],
        ),
      ):SingleChildScrollView(

            child: Container(

              width: width,
              child: Column(
                children: <Widget>[


                  /*المفذة
عدد مقدمي الخدمات
شيل العدد
شيل العملاء
                شيل كل*/
                  ListTitleDialogInfo(number:AppLocalizations.of(context).translate("NumberServicesImplemented"),text:emptyString(data.allDoneServices.toString()),image: "checklist.png"),
                  ListTitleDialogInfo(number:AppLocalizations.of(context).translate("TotalServiceProviders") ,text:emptyString(data.allServiceProviders.toString()),image: "provider.png", ),
                  ListTitleDialogInfo(number:AppLocalizations.of(context).translate("AllUsers"),text:emptyString(data.allUsers.toString()),image: "crm.png"),
                  ListTitleDialogInfo(number:AppLocalizations.of(context).translate("numberVisits") ,text:emptyString(data.allActiveClientsInThePastThreeDays.toString()),image: "visitors.png"),
                  ListTitleDialogInfo(number:AppLocalizations.of(context).translate("TheNumberConnectedAudience") ,text:emptyString(data.allActiveClients.toString()),image: "wireless_symbol.png"),
                  ListTitleDialogInfo(number:AppLocalizations.of(context).translate("TheNumberOfInterpretersDreams") ,text:emptyString(data.allDreamUsers.toString()) ,image: "ahlam.png"),
                  ListTitleDialogInfo(number:AppLocalizations.of(context).translate("TheNumberLegitimatePromotions") ,text:emptyString(data.allRouqiaUsers.toString()),image: "raki.png"),
                  ListTitleDialogInfo(number:AppLocalizations.of(context).translate("NumberOfFamilyCounselors"),text:emptyString(data.allIstasharaUsers.toString()),image: "famely.png"),
                  ListTitleDialogInfo(number:AppLocalizations.of(context).translate("NumberMedicalAdvisors"),text:emptyString(data.allMedicalUsers.toString()),image: "doctor.png"),



                  ListTitleDialogInfo(number:AppLocalizations.of(context).translate("NumberOfServicesUnderImplementation"),text:emptyString(data.allActiveServices.toString()),image: "waiting.png"),

                  ListTitleDialogInfo(number:AppLocalizations.of(context).translate("TheNumberOfMuftis"),text:emptyString(data.allIftaaUsers.toString()),image: "mofte.png"),





                 // ListTitleDialogInfo(number:AppLocalizations.of(context).translate("EveryCustomer"),text:emptyString(data.allClients.toString()),image: "alzeker_logo.png"),



                ],
              ),
            ))

      )


    );
  }
}
