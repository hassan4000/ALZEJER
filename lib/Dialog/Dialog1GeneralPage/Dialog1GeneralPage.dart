import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/ApplicationInfoModel/ApplicationInfoModel.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/ApplicationInfoPage.dart';
import 'package:faserholmak/wigets/PersonalProfileContent.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';


class Dialog1GeneralPage extends StatefulWidget {
  @override
  _Dialog1GeneralPageState createState() => _Dialog1GeneralPageState();
}

class _Dialog1GeneralPageState extends State<Dialog1GeneralPage> {


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
              AppLocalizations.of(context).translate("details"),
            style: getTextSyle(20, kPrimaryColor,fontWeight: FontWeight.w600)
          ),
        ],

      ),

      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
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
                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("TheNumberConnectedAudience") ,text:emptyString(data.allActiveClients.toString()) ),
                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("numberVisits") ,text:emptyString(data.allActiveClientsInThePastThreeDays.toString()) ),
                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("EveryCustomer"),text:emptyString(data.allClients.toString()) ),
                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("AllUsers"),text:emptyString(data.allUsers.toString()) ),

                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("TotalServiceProviders") ,text:emptyString(data.allServiceProviders.toString()) ),
                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("TheNumberOfInterpretersDreams") ,text:emptyString(data.allDreamUsers.toString()) ),
                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("TheNumberLegitimatePromotions") ,text:emptyString(data.allRouqiaUsers.toString()) ),
                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("NumberOfFamilyCounselors"),text:emptyString(data.allIstasharaUsers.toString()) ),
                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("NumberMedicalAdvisors"),text:emptyString(data.allMedicalUsers.toString()) ),


                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("NumberOfServicesUnderImplementation"),text:emptyString(data.allActiveServices.toString()) ),
                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("NumberServicesImplemented"),text:emptyString(data.allDoneServices.toString()) ),
                  ApplicationInfoPage(hint:AppLocalizations.of(context).translate("TheNumberOfMuftis"),text:emptyString(data.allIftaaUsers.toString()) ),

                ],
              ),
            ))

      )


    );
  }
}
