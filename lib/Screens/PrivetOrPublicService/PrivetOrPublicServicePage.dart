
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
import 'package:faserholmak/Screens/AreYouHurryPage/AllPaymentMethodPage.dart';

import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/wigets/CardTimeDreams.dart';
import 'package:faserholmak/wigets/CardTimeDreamsV2.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PrivetOrPublicServicePage extends StatefulWidget {
  AddServiceModel addServiceModel;


  PrivetOrPublicServicePage(this.addServiceModel);



  @override
  _PrivetOrPublicServicePageState createState() => _PrivetOrPublicServicePageState();
}

class _PrivetOrPublicServicePageState extends State<PrivetOrPublicServicePage> {
  bool isLoading=false;
  bool isLoadingHUD=false;
  List<PrivetOrPublicServiceModel> listServices;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();



  Future<void> addServicesFun(PrivetOrPublicServiceModel item) async {
    PaymentModel paymentModel=PaymentModel(myMoeny: double.parse(widget.addServiceModel.privateServicePrice),
      servicePathId: widget.addServiceModel.servicePathId,serviceId:0,);
    double cost= double.parse(widget.addServiceModel.privateServicePrice);
    if(item.name==publicTxt||item.name=="0"||item.price=="0.0"){
      widget.addServiceModel.privateService=false;
      paymentModel.privateServices=false;

    }else{
      widget.addServiceModel.privateService=true;
      double cost2=  double.parse(item.price);
      cost+=cost2;
      paymentModel.privateServices=true;
      widget.addServiceModel.privateServicePrice=item.price.toString();
    }

    print(widget.addServiceModel.toJson());

 //   reSetLoadingHUD(true);
 //   var  response=await AddServicesRQ(widget.addServiceModel);
  //  if(response.statusCode==200){


      print("thePrice ${double.parse(widget.addServiceModel.privateServicePrice)}");
      if(double.parse(item.price.toString())<=0.0) {

          reSetLoadingHUD(true);
          var  response=await AddServicesRQ(widget.addServiceModel);
          reSetLoadingHUD(false);
          if(response.statusCode==200){
        showToast(successfulOpreation);
        openPageAndClearPrev(context:context,page: GeneralPageClient(),route: HomePageRoute);}
      }

      else{

        //int  serivesID=response.object;
       /* PaymentModel paymentModel=PaymentModel(myMoeny: double.parse(widget.addServiceModel.privateServicePrice),
          servicePathId: widget.addServiceModel.servicePathId,serviceId:0,);*/
        paymentModel.currency="\$";
        paymentModel.amount= item.price;
        print(jsonEncode(paymentModel.toJson()).toString());
        print(jsonEncode(widget.addServiceModel.toJson()).toString());

        openPage(context,
            AllPaymentMethodPage(paymentModel:paymentModel,
              addServiceModel: widget.addServiceModel,formAddSerives: true,pathPrice: item.orginalPrice,));


/*        openPage(context, PrivetOrPublicAfterAreYouHurry(paymentModel: paymentModel,
          formAddsericesPage: true,addServiceModel:widget.addServiceModel,));*/
      }

    //  openPageAndClearPrev(context: context,page: GeneralPageClient(),route:  HomePageRoute);
   // reSetLoadingHUD(false);
  }


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
                  double oldPrice=double.parse(widget.addServiceModel.privateServicePrice);
                  double allPrice=oldPrice+newPrice;

                 dataList.add(PrivetOrPublicServiceModel(orginalPrice:"${widget.addServiceModel.privateServicePrice}" ,price: "${widget.addServiceModel.privateServicePrice}",desc: publicServicesHint,name: publicTxt));
                 dataList.add(PrivetOrPublicServiceModel(orginalPrice:"${widget.addServiceModel.privateServicePrice}",price: allPrice.toString(),desc: privateServicesHint,name: privateTxt));

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
              Column(
                children: <Widget>[
                /*  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: Text("رصيدك من النقاط ${userInfo.pointsBalance.toString()}"
                        ,style: getTextSyle(16, Colors.grey),
                        textDirection: TextDirection.rtl,textAlign: TextAlign.center,)),
                    ],
                  ),
                  MyButton(txt: "الدفع باستخدام النقاط",press: () async {

                    bool canPayPyPoint=await checkPoint();

                    if(canPayPyPoint){
                      reSetLoadingHUD(true);
                      widget.addServiceModel.privateService=false;
                      var addServiesResponse=await AddServicesRQ(widget.addServiceModel);
                      if(addServiesResponse.statusCode==200){

                        reSetLoadingHUD(false);
                        int serviesID=addServiesResponse.object;

                        Response response= await openPayByPointDialog(context,
                            new SingleServicesModel(id: serviesID,servicePathId: widget.addServiceModel.servicePathId));
                        if(response.statusCode==200){

                          var  point=response.object;
                          userInfo.pointsBalance=int.parse(point['Modifier']['PointsBalance'].toString());
                          showToast("تمت العملية بنجاح");
                          openPageAndClearPrev(context: context,route:HomePageRoute,page: GeneralPageClient() );

                        }else{
                          showToast("فشلت عملية الدفع  حاولا لاحقا");
                        }

                      }else
                        showToast("فشلت عملية اضفة خدمة");
                      reSetLoadingHUD(false);
                    }else{
                      showToast("عذرا انت لاتملك رصيد كافي ");
                    }


                  },textStyle: getTextSyle(18, Colors.white),
                    raduis: 4,),*/


                  Flexible(flex: 1, child: dataListView(listServices,context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
