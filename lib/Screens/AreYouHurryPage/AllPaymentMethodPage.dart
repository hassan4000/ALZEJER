import 'dart:convert';

import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AddServices/AddServiceModel.dart';
import 'package:faserholmak/Model/AllPaymentMethodModel/AllPaymentMethodModel.dart';
import 'package:faserholmak/Model/AllPaymentMethodModel/PaymentMethod.dart';
import 'package:faserholmak/Model/PaymentModel/PaymentModel.dart';
import 'package:faserholmak/Model/PrivetOrPublicServiceModel/PrivetOrPublicServiceModel.dart';
import 'package:faserholmak/Model/ServicesPathModel.dart';
import 'package:faserholmak/Model/SingleServicesModel/SingleServicesModel.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/wigets/CardPaymentMethod.dart';
import 'package:faserholmak/wigets/CardTimeDreams.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import '../../app_localizations.dart';

class AllPaymentMethodPage extends StatefulWidget {

  PaymentModel paymentModel;
  AddServiceModel addServiceModel;
  bool formAddSerives;
  String pathPrice;

  AllPaymentMethodPage({this.paymentModel,this.addServiceModel,this.formAddSerives=false,this.pathPrice});

  @override
  _AllPaymentMethodPageState createState() => _AllPaymentMethodPageState();
}

class _AllPaymentMethodPageState extends State<AllPaymentMethodPage> {
  bool isLoading=false;
  bool isLoadingHUD=false;
  List<PaymentMethod> listServices;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();
  String _response = '';


  void executeRegularPayment(PaymentModel data) {
    // The value "1" is the paymentMethodId of KNET payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    //  String paymentMethod = "1";
    String paymentMethod = "8";

    MFExecutePaymentRequest mfExecutePaymentRequest=
    new MFExecutePaymentRequest(data.myPaymnetMethod,data.amount.toString());
    mfExecutePaymentRequest.displayCurrencyIso="USD";
    mfExecutePaymentRequest.customerEmail=emptyString(userInfo.email);
    mfExecutePaymentRequest.customerMobile=emptyString(userInfo.phoneNumber);
    mfExecutePaymentRequest.customerName=emptyString(userInfo.name);
    var request = new MFExecutePaymentRequest(data.myPaymnetMethod, data.amount.toString());

    MFSDK.executePayment(
        context,
        request,
        MFAPILanguage.AR,
            (String invoiceId, MFResult<MFPaymentStatusResponse> result)  async {
          if (result.isSuccess())
            {

              setState(() {
                isLoadingHUD=true;
              });

              if(widget.formAddSerives){
                var  response=await AddServicesRQ(widget.addServiceModel);
                if(response.statusCode==200){
                  int  serivesID=response.object;
                  widget.paymentModel.serviceId=serivesID;
                }
              }

              var respose=await addPaymentToServer(widget.paymentModel);
              if(respose.statusCode==200){
                showToast(AppLocalizations.of(context).translate("PaymentWasSuccessful"));
                openPageAndClearPrev(context:context,page: GeneralPageClient(),route: HomePageRoute);
              }


              setState(() {
                isLoadingHUD=false;
              });


           /*   setState(() {
                printWrapped("SSSSSSSSSSSSSSSSss"+invoiceId);
                printWrapped(jsonEncode(result.response).toString());
                _response = result.response.toJson().toString();
              });*/
            }
          else
            {
              setState(() {
                print(invoiceId);
                print(result.error.toJson());
                _response = result.error.message;
              });
            }
        });


  }
  Widget dataListView(List<PaymentMethod> data, context) {
    if (data == null){

      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  "",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );}
    else if (data.length > 0){


      return ListView.builder(
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,
          physics: const AlwaysScrollableScrollPhysics(),

          itemBuilder: (context, index) {
            PaymentMethod item=listServices[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
           child:CardPaymentMethod(paymentMethod: item,press: (){
             widget.paymentModel.method=item.paymentMethodAr;
             widget.paymentModel.myPaymnetMethod=item.paymentMethodId.toString();
             printWrapped(jsonEncode((widget.paymentModel.toJson())).toString());
             executeRegularPayment(widget.paymentModel);
           },),
         //   child: Text(item.currencyIso),
            );
          });}
    else{

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
      );}
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
    if(item.price=="0"){
//      widget.addServiceModel.privateService=false;

    }else{

      setState(() {
        widget.paymentModel.myMoeny+= double.parse(item.price);
        widget.paymentModel.amount= widget.paymentModel.myMoeny.toString();
      });


    }

    print(jsonEncode(widget.paymentModel.toJson()).toString());

   /* reSetLoadingHUD(true);
    var  response=await AddServicesRQ(widget.addServiceModel);
    if(response.statusCode==200)
      openPageAndClearPrev(context: context,page: GeneralPageClient(),route:  HomePageRoute);
    reSetLoadingHUD(false);*/
  }



 Future<void> initiatePayment() {
    reSetLoading(true);
    MFSDK.init(payUrlRealse, tokenPAY);
    var request = new MFInitiatePaymentRequest(widget.paymentModel.myMoeny, MFCurrencyISO.UNITED_STATE_USD);

    MFSDK.initiatePayment(
        request,
        MFAPILanguage.AR,
            (MFResult<MFInitiatePaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {

                printWrapped(jsonEncode(result.response).toString());
                _response = result.response.toJson().toString();
                AllPaymentMethodModel item=AllPaymentMethodModel.fromJson(result.response.toJson());
                listServices=item.paymentMethods;
              })
            }
          else
            {
              setState(() {
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    reSetLoading(false);


  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshKey.currentState.show());
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context).translate("choosePaymentMethod")),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoadingHUD,
          child: Background(
            topAlignment: true,
            child: RefreshIndicator(

              key: refreshKey,
              onRefresh: ()async{
                reSetLoading(true);
       /*         var response=await getServicePrivatePrice();
                if(response.statusCode==200){
                  List<PrivetOrPublicServiceModel> dataList=List();
                  var price=response.object.toString();


                  setState(() {
                    listServices=dataList.cast<PaymentMethod>();
                  });


                }*/

                await initiatePayment();




              },
              child: isLoading?
              SingleChildScrollView(

                  child: Container(height: MediaQuery.of(context).size.height,)

              ):
              Column(

                children: <Widget>[
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: Text("${AppLocalizations.of(context).translate("yourBalanceByPoint")} ${userInfo.pointsBalance.toString()}"
                        ,style: getTextSyle(16, Colors.grey),
                        textAlign: TextAlign.center,)),
                    ],
                  ),
                  MyButton(txt: AppLocalizations.of(context).translate("payByPointTxt"),press: () async {

                    bool canPayPyPoint=await checkPoint(addPointInPaymnet(widget.paymentModel.amount));

                    if(canPayPyPoint){
                      reSetLoadingHUD(true);
                      var addServiesResponse=await AddServicesRQ(widget.addServiceModel);
                      if(addServiesResponse.statusCode==200){

                        reSetLoadingHUD(false);
                        int serviesID=addServiesResponse.object;
                        widget.paymentModel.serviceId=serviesID;

                        Response response= await openPayByPointDialog(context,
                            new SingleServicesModel(id: widget.paymentModel.serviceId,servicePathId: widget.paymentModel.servicePathId,
                            privateService: widget.paymentModel.privateServices),addPointInPaymnet(widget.paymentModel.amount));
                        if(response.statusCode==200){

                          var  point=response.object;
                          userInfo.pointsBalance=int.parse(point['Modifier']['PointsBalance'].toString());
                          showToast(AppLocalizations.of(context).translate("successfulOpreation"));
                          openPageAndClearPrev(context: context,route:HomePageRoute,page: GeneralPageClient() );

                        }else{
                          showToast(AppLocalizations.of(context).translate("failedToPayOpreation"));
                        }

                      }else
                        showToast(AppLocalizations.of(context).translate("faildToAddService"));
                      reSetLoadingHUD(false);
                    }else{
                      showToast(AppLocalizations.of(context).translate("youDonotHaveEnoughtPoint"));
                    }


                  },textStyle: getTextSyle(18, Colors.white),
                    raduis: 4,),
                  Flexible(child: dataListView(listServices,context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
