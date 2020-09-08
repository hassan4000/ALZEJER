import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/SingleServicesModel/SingleServicesModel.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';



class PayByPointDialog extends StatefulWidget {

  SingleServicesModel servicesModel;

  int servicePathId;
  int sericesId;
  int amount;

  PayByPointDialog({this.servicesModel,this.amount});

/*  PayByPointDialog.LocalData(this.servicePathId,this.sericesId){
    servicesModel=new SingleServicesModel();
    servicesModel.servicePathId=this.servicePathId;
    servicesModel.id=this.sericesId;
  }*/


  @override
  _PayByPointDialogState createState() => _PayByPointDialogState();
}

class _PayByPointDialogState extends State<PayByPointDialog> {

  bool isLoading=false;
  Map<String,dynamic> initMap(){

    Map<String,dynamic> data={
    "ServicePathId":widget.servicesModel.servicePathId,
    "ServiceId":widget.servicesModel.id,
    "UseUserPoints":true,
    "NumberOfPoints":widget.amount,
    "PrivateService":widget.servicesModel.privateService};

    return data;

  }

  Future<void> payByPoint() async {
    setState(() {
      isLoading=true;
    });
    var response=await payByPointRQ(initMap());
    Navigator.of(context).pop(response);
    setState(() {
      isLoading=false;
    });


  }



  @override
  void initState() {
    if(mounted)
      payByPoint();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return  AlertDialog(
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
                "ترقية الخطة بالنقاط  ",
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
                        'الرجاء الانتظار ..',
                        style: TextStyle(
                          fontFamily: 'Heading',
                          fontSize: 18.0,
                          color: Colors.black87,
                        ),
                      )),
                ],
              ),
            ):Container(
              height: 120,
              width: width,)

        )


    );
  }
}
