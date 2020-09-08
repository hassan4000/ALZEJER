import 'dart:convert';

import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AddServices/AddServiceModel.dart';
import 'package:faserholmak/Model/PaymentModel/PaymentModel.dart';
import 'package:faserholmak/Model/PrivetOrPublicServiceModel/PrivetOrPublicServiceModel.dart';
import 'package:faserholmak/Model/ServicesPathModel.dart';
import 'package:faserholmak/Model/SingleServicesModel/SingleServicesModel.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/wigets/CardTimeDreams.dart';
import 'package:faserholmak/wigets/CardTimeDreamsV2.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


import 'AllPaymentMethodToImprovePlan.dart';

class ServiesTypeForImprovePlan extends StatefulWidget {

  PaymentModel paymentModel;
  bool formAddsericesPage=false;



  ServiesTypeForImprovePlan({this.paymentModel,this.formAddsericesPage=false});



  @override
  _ServiesTypeForImprovePlanState createState() => _ServiesTypeForImprovePlanState();
}

class _ServiesTypeForImprovePlanState extends State<ServiesTypeForImprovePlan> {
  bool isLoading=false;
  bool isLoadingHUD=false;
  List<PrivetOrPublicServiceModel> listServices;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();


  Widget dataListView(List<PrivetOrPublicServiceModel> data, context) {
    if (data == null)
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  failedOpreation,
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
            PrivetOrPublicServiceModel item=listServices[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child:CardTimeDreamsV2(price: item.price.toString(),
                line: false,
                name: item.name,
                textAboveLine: item.desc.toString(),
                textUnderLine:"",
                press: ()  {
                  addServicesFun(item);
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
                  noData,
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
  void reSetLoadingHUD(bool state){
    setState(() {
      isLoadingHUD=state;
    });
  }


  Future<bool> checkPoint(int amount) async {
    //  reSetLoadingHUD(true);



    //  Response response=await getServicePricePerPoints(amount);
    //reSetLoadingHUD(false);
    // if(response.statusCode==200){
    // }
    int result=userInfo.pointsBalance-amount;
    if(result>0) return true;

    return false;

  }

  Future<void> addServicesFun(PrivetOrPublicServiceModel item) async {
    double cost=widget.paymentModel.myMoeny;
    widget.paymentModel.currency="\$";
    if(item.name==publicTxt||item.price=="0"||item.price=="0.0"){
     // widget.paymentModel.amount= widget.paymentModel.myMoeny.toString();
      widget.paymentModel.amount= item.price;
      widget.paymentModel.privateServices=false;
//      widget.addServiceModel.privateService=false;

    }else{
     // widget.paymentModel.myMoeny+= double.parse(item.price);
     // widget.paymentModel.amount= widget.paymentModel.myMoeny.toString();

      widget.paymentModel.amount= item.price;
      widget.paymentModel.privateServices=true;

    }

    print(jsonEncode(widget.paymentModel.toJson()).toString());

    if(double.parse(widget.paymentModel.amount)<=0){
      showToast("يجب اختيار مبلغ للدفع");
    }
    else
    openPage(context,
        AllPaymentMethodToImprovePlan(paymentModel: widget.paymentModel,formAddSerives: widget.formAddsericesPage,
          pricePath:item.orginalPrice ,));

   /* reSetLoadingHUD(true);
    var  response=await AddServicesRQ(widget.addServiceModel);
    if(response.statusCode==200)
      openPageAndClearPrev(context: context,page: GeneralPageClient(),route:  HomePageRoute);
    reSetLoadingHUD(false);*/
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshKey.currentState.show());
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
       // return !widget.formAddsericesPage;
        return true;
      },
      child: SafeArea(
        top: true,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('اختر نوع الخدمة'),
          ),
          body: ModalProgressHUD(
            inAsyncCall: isLoadingHUD,
            child: Background(
              topAlignment: true,
              child: RefreshIndicator(

                key: refreshKey,
                onRefresh: ()async{
                  reSetLoading(true);
                  var response=await getServicePrivatePrice();
                  if(response.statusCode==200){
                    List<PrivetOrPublicServiceModel> dataList=List();
                    var price=response.object.toString();
                    double newPrice=double.parse(price);
                    double oldPrice=double.parse(widget.paymentModel.myMoeny.toString());
                    double allPrice=oldPrice+newPrice;
                    dataList.add(PrivetOrPublicServiceModel(orginalPrice: widget.paymentModel.myMoeny.toString(),price: widget.paymentModel.myMoeny.toString(),desc: publicServicesHint,name: publicTxt));
                    dataList.add(PrivetOrPublicServiceModel(orginalPrice: widget.paymentModel.myMoeny.toString(),price: allPrice.toString(),desc: privateServicesHint,name: privateTxt));

                    setState(() {
                      listServices=dataList;
                    });


                  }

                  reSetLoading(false);


                },
                child: isLoading?
                SingleChildScrollView(

                    child: Container(height: MediaQuery.of(context).size.height,)

                ):
                Container(

                  child: Column(
                    children: <Widget>[
                      Flexible(flex: 1,child: dataListView(listServices,context)),
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
