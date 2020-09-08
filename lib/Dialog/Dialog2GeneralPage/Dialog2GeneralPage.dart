import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/ApplicationInfoModel/ApplicationInfoModel.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/ApplicationInfoPage.dart';
import 'package:faserholmak/wigets/PersonalProfileContent.dart';
import 'package:flutter/material.dart';


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
            "احصائيات التطبيق",
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

                  ApplicationInfoPage(hint:"مجموع مقدمي الخدمات" ,text:emptyString(data.allServiceProviders.toString()) ),
                  ApplicationInfoPage(hint:"عدد مفسرين الاحلام" ,text:emptyString(data.allDreamUsers.toString()) ),
                  ApplicationInfoPage(hint:"عدد الرقاة الشرعيين" ,text:emptyString(data.allRouqiaUsers.toString()) ),
                  ApplicationInfoPage(hint:"عدد المستشارين الاسريين" ,text:emptyString(data.allIstasharaUsers.toString()) ),
                  ApplicationInfoPage(hint:"عدد المستشارين الطبيين" ,text:emptyString(data.allMedicalUsers.toString()) ),


                  ApplicationInfoPage(hint:"عدد الخدمات القيد التنفيذ" ,text:emptyString(data.allActiveServices.toString()) ),
                  ApplicationInfoPage(hint:"عدد الخدمات المنفذة" ,text:emptyString(data.allDoneServices.toString()) ),
                  ApplicationInfoPage(hint:"عدد المفتين" ,text:emptyString(data.allIftaaUsers.toString()) ),

                  ApplicationInfoPage(hint:"عدد الجمهور المتصل" ,text:emptyString(data.allActiveClients.toString()) ),
                  ApplicationInfoPage(hint:"عدد  الزيارات" ,text:emptyString(data.allActiveClientsInThePastThreeDays.toString()) ),
                  ApplicationInfoPage(hint:"كل العملاء" ,text:emptyString(data.allClients.toString()) ),
                  ApplicationInfoPage(hint:"كل المستخدمين" ,text:emptyString(data.allUsers.toString()) ),

                ],
              ),
            ))

      )


    );
  }
}
