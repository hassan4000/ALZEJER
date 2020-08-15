import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/ApplicationInfoModel/ApplicationInfoModel.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/ApplicationInfoPage.dart';
import 'package:faserholmak/wigets/PersonalProfileContent.dart';
import 'package:flutter/material.dart';


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
            "تفاصيل  ",
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
                  'Loading ..',
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
                  ApplicationInfoPage(hint:"عدد الجمهور المتصل" ,text:emptyString(data.allActiveClients.toString()) ),
                  ApplicationInfoPage(hint:"المتصلين خلال 3 ايام" ,text:emptyString(data.allActiveClientsInThePastThreeDays.toString()) ),
                  ApplicationInfoPage(hint:"كل العملاء" ,text:emptyString(data.allClients.toString()) ),
                  ApplicationInfoPage(hint:"كل المستخدمين" ,text:emptyString(data.allUsers.toString()) ),

                ],
              ),
            ))

      )


    );
  }
}
