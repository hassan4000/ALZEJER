import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/HassanCountry.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/ALLPaymentToShowModel/AllPaymentToShowModel.dart';
import 'package:faserholmak/Model/TransactionRecord/TransactionRecordData.dart';
import 'package:faserholmak/Model/TransactionRecord/TransactionRecordModel.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/ApplicationInfoPage.dart';
import 'package:faserholmak/wigets/CardMofaserBalance.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class MofaserBalance extends StatefulWidget {
  @override
  _MofaserBalanceState createState() => _MofaserBalanceState();
}

class _MofaserBalanceState extends State<MofaserBalance> {

  bool isLoading=false;
  List<TransactionRecordData> dataList;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();


  Widget dataListView(List<TransactionRecordData> data, context) {
    if (data == null)
      return ListView(
        shrinkWrap: true,
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
          shrinkWrap: true,
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,
          physics: const NeverScrollableScrollPhysics(),

          itemBuilder: (context, index) {
            TransactionRecordData item=dataList[index];

            return CardMofaserBalance(txt: "${AppLocalizations.of(context).translate("amountHasBeenTransferred")} ${item.amount} ${AppLocalizations.of(context).translate("ByTheBank")} ${emptyString(item.bank)} ",);
          });
    else
      return ListView(
        shrinkWrap: true,
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
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      title: Text(AppLocalizations.of(context).translate("TheBalanceOfTheServiceProvider"),style: getTextSyle(16, Colors.white),),)

      ,
      body: SafeArea(
        top: true,
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: ()async{
            reSetLoading(true);
            var response=await getMofaserBalance(idMofser: userInfo.id);
            if(response.statusCode==200) {
              TransactionRecordModel  dataList1 = response.object;

            setState(() {
            dataList=dataList1.value;
         
            });

            print(dataList.length.toString());
            }
            reSetLoading(false);
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                ApplicationInfoPage(hint:AppLocalizations.of(context).translate("OutstandingBalance") ,text:emptyString(userInfo.suspendedBalance.toString()) ),
                ApplicationInfoPage(hint:AppLocalizations.of(context).translate("theAvailableBalance") ,text:emptyString(userInfo.availableBalance.toString()) ),
                ApplicationInfoPage(hint:AppLocalizations.of(context).translate("TransferredBalance") ,text:emptyString(userInfo.totalBalance.toString()) ),

                Row(
                  children: <Widget>[

                    Expanded(
                      child: Text(AppLocalizations.of(context).translate("RecordPhysicalTransfers"),style: getTextSyle(16, kPrimaryColor),
                      textAlign: TextAlign.center,),
                    )
                  ],
                ),

               isLoading?Container(): dataListView(dataList,context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
