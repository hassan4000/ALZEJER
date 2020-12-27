import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Model/ALLPaymentToShowModel/AllPaymentToShowModel.dart';
import 'package:faserholmak/Model/AddServices/AddServiceModel.dart';
import 'package:faserholmak/Model/ServicesPathModel.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/PrivetOrPublicService/PrivetOrPublicServicePage.dart';
import 'package:faserholmak/wigets/CardMofaserBalance.dart';
import 'package:faserholmak/wigets/CardTimeDreams.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class PaymentRecordPage extends StatefulWidget {


  @override
  _PaymentRecordPageState createState() => _PaymentRecordPageState();
}

class _PaymentRecordPageState extends State<PaymentRecordPage> {
  bool isLoading=false;
  List<AllPaymentToShowModel> listPath;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();


  Widget dataListView(List<AllPaymentToShowModel> data, context) {
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
            AllPaymentToShowModel item=listPath[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child:CardMofaserBalance(name: emptyString(item.creatorName),
              date: emptyString(item.creationDate),
              txt: emptyString("${AppLocalizations.of(context).translate("AnAmountWasPaid")} ${item.amount} ${item.currency} "),),
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


  void reSetLoading(bool state){
    setState(() {
      isLoading=state;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context).translate("balanceRecord")),
        ),
        body: Background(
          topAlignment: true,
          child: RefreshIndicator(

            key: refreshKey,
            onRefresh: ()async{
              reSetLoading(true);
              var response=await getAllPaymentRecordRQ();
              if(response.statusCode==200){
                List<AllPaymentToShowModel> dataList=response.object;

                setState(() {
                  listPath=dataList;
                });


              }

              reSetLoading(false);


            },
            child: isLoading?
            SingleChildScrollView(

                child: Container(height: MediaQuery.of(context).size.height,)

            ):
            dataListView(listPath,context),
          ),
        ),
      ),
    );
  }
}
