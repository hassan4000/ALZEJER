import 'dart:convert';

import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/PaymentModel/PaymentModel.dart';
import 'package:faserholmak/Model/ServicesPathModel.dart';
import 'package:faserholmak/Model/SingleServicesModel/SingleServicesModel.dart';
import 'package:faserholmak/Screens/ImproveYourPlanPages/ServiesTypeForImprovePlan.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/wigets/CardTimeDreams.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../app_localizations.dart';



class AreYouHarryPage extends StatefulWidget {

  int servicesID;
  String providerID;




  AreYouHarryPage({this.servicesID,this.providerID});

  @override
  _AreYouHarryPageState createState() => _AreYouHarryPageState();
}

class _AreYouHarryPageState extends State<AreYouHarryPage> {

  bool isLoading=false;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();
  List<ServicesPathModel> listPath;
  void reSetLoading(bool state){
    setState(() {
      isLoading=state;
    });
  }


  String getAvg(String txt){
    if(emptyString(txt)=="") return AppLocalizations.of(context).translate("soonTxt");
    else return emptyString(txt);
  }
  Widget dataListView(List<ServicesPathModel> data, context) {
    if (data == null)
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  AppLocalizations.of(context).translate("failedOpreation"),
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );
    else if (data.length > 0)
      return ListView.builder(
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,
          physics: const AlwaysScrollableScrollPhysics(),

          itemBuilder: (context, index) {
            ServicesPathModel item=listPath[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child:CardTimeDreams(price: item.cost.toString(),
                name: item.name,
                textAboveLine: item.numberOfPeopleWaiting.toString(),
                textUnderLine: getAvg(emptyString(item.avgWaitingTime)),
                press: (){


                PaymentModel paymentModel=PaymentModel(myMoeny: item.cost,
                    servicePathId: item.id,serviceId: widget.servicesID);

                print(jsonEncode(paymentModel.toJson()).toString());
                openPage(context, ServiesTypeForImprovePlan(paymentModel: paymentModel,));
             /*     widget.addServiceModel.servicePathId=item.id;
                  widget.addServiceModel.privateServicePrice=item.cost.toString();
                  print(widget.addServiceModel.toJson());*/

                //  openPage(context, PrivetOrPublicServicePage(widget.addServiceModel));
                },),
            );
          });
    else
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  AppLocalizations.of(context).translate("noData"),
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );
  }


  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshKey.currentState.show());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("UrgentService"),style: getTextSyle(16, Colors.white),),
      ),

      body: SafeArea(
        top: true,
        child:Background(
          topAlignment: true,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                MyButton(txt: AppLocalizations.of(context).translate("ShareTheApp"),press: () async {


                  await FlutterShare.share(
                      title: AppLocalizations.of(context).translate("pleaseShareThisLink"),

                      text:
                      '${AppLocalizations.of(context).translate("shareHitn1")}\n ${userInfo.userSpecialCode}',
                      linkUrl:
                      ' {${AppLocalizations.of(context).translate("linkApp")} \n  ${googlePlayUrl}',
                      chooserTitle:
                      'Share');
                },textStyle: getTextSyle(18, Colors.white),
                raduis: 4,),

                ListTile(
                  title: Text(AppLocalizations.of(context).translate("pointDesc"),style: getTextSyle(16, Colors.black)),
                  selected: true,
                  trailing: Icon(Icons.info),
                ),

                SizedBox(height: 10,),

                Expanded(
                  child: RefreshIndicator(

                    key: refreshKey,
                    onRefresh: ()async{
                      reSetLoading(true);
                      var response=await getServicePath(widget.providerID.toString());
                      if(response.statusCode==200){
                        List<ServicesPathModel> dataList=response.object;
                        setState(() {
                          listPath=dataList;

                        });


                      }
                      reSetLoading(false);
                    },
                    child:isLoading?  SingleChildScrollView(

                        child: Container(height: MediaQuery.of(context).size.height,)

                    ):   dataListView(listPath,context),
                  ),
                )
              ],
            ),
          ),
        ) ,
      ),
    );
  }
}
