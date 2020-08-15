import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AboutModel/AboutModel.dart';
import 'package:faserholmak/Screens/honorDeals/HonorDeals.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsPage extends StatefulWidget {
  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {

  bool isLoading=false;
  String txt="";
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();
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
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("شروط الاستخدام",style: getTextSyle(16, Colors.white),),
      ),
        body:SafeArea(
          top: true,
          child: RefreshIndicator(

            key:  refreshKey,
             onRefresh: ()async{

              reSetLoading(true);
              var respose=await getAdditionlInfo(terms: true);
              if(respose.statusCode==200){
                AboutModel item=respose.object;
                setState(() {
                  txt=emptyString(item.value);
                });
              }

              reSetLoading(false);

             },
            child: isLoading?
            Container(height: MediaQuery.of(context).size.height,):
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical:2),
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 4,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[
                      LogoIcon(),
                      Expanded(
                        child: Text("شروط الاستخدام",style: getTextSyle(16, kPrimaryColor,fontWeight: FontWeight.w600),textDirection: TextDirection.rtl,),
                      )
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView
                      (child:
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(txt,style: getTextSyle(14, Colors.black87),textDirection: TextDirection.rtl))
                    ),
                  ),

                  Row(mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MyButton(txt: continueTxt,press: (){Navigator.of(context).pop();},)
                    ],)
                ],
              ),
            ),
          ),
        ),
      );
  }
}
