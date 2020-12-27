import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/WorkTypeUser/Value.dart';
import 'package:faserholmak/Model/WorkTypeUser/WorkTypeModel.dart';
import 'package:faserholmak/Screens/HowAppWork/HowAppWork.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/Swear/SwearPage.dart';
import 'package:faserholmak/Screens/createAccountMofaser/CreateAccountMofaser.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../app_localizations.dart';
import '../../constants.dart';


class CreateWorkType extends StatefulWidget {
  @override
  _CreateWorkTypeState createState() => _CreateWorkTypeState();
}

class _CreateWorkTypeState extends State<CreateWorkType> {

  List<bool> selectedIndex;

  List<Value> listViewItem;
  bool isLoading=false;


  setIsLoading(bool state){
    setState(() {
      isLoading=state;
    });
  }


  Widget _dataListView(List<Value> data, context) {

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
    else if (data.length > 0){

      //data.removeRange(0, 3);
      return ListView.builder(
          itemCount: data.length,
    //      controller: _controllerScrollRecevier,
          physics: const AlwaysScrollableScrollPhysics(),

          itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyButton(txt: data[index].name.toString(),raduis: 10,
                  borderColor: Colors.transparent,
                  buttonColor: selectedIndex.elementAt(index)?kPrimaryColor:Colors.grey,
                  press: (){
                    setState(() {
                      selectedIndex[index]=!selectedIndex[index];
                    });
                  }
                  ,),
              );
          });
    }
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

  void getWorkData()async{

    setIsLoading(true);
    var response=await getWorkTypeRQ();
    if(response.statusCode==200){
      WorkTypeModel workTypeModel=response.object;


      if(workTypeModel.value.isNotEmpty){

        setState(() {
        
          listViewItem=workTypeModel.value;

          selectedIndex= new List(workTypeModel.value.length);
          selectedIndex.fillRange(0, workTypeModel.value.length,false);

        });




      }
    }

    setIsLoading(false);

  }

  @override
  void initState() {
    super.initState();
    if(mounted)
    getWorkData();


  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      top: true,
      child: Scaffold(
         appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(AppLocalizations.of(context).translate("joinToOutApp"),style: getTextSyle(16, Colors.white)),
      ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Background(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[


                   /*    Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(joinToOutApp,style:getTextSyle(20,kPrimaryColor,fontWeight: FontWeight.w600),
                        textDirection: TextDirection.rtl,),
                    ),*/


                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(AppLocalizations.of(context).translate("hint1CreateWorkTypePage"),style:getTextSyle(20,kPrimaryColor),
                             ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(AppLocalizations.of(context).translate("hint2CreateWorkTypePage"),style:getTextSyle(20,kPrimaryColor),
                              ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(AppLocalizations.of(context).translate("whatSpecializationAreYouGoodAt"),style:getTextSyle(20,kPrimaryColor,fontWeight: FontWeight.w400),
                       ),
                    ),
                    Container(

                      height: MediaQuery.of(context).size.height/2,
                      width: MediaQuery.of(context).size.width,
                      child: isLoading?Container():_dataListView(listViewItem,context),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: MyButton(txt: AppLocalizations.of(context).translate("continueTxt"),
                      press: (){
                        
                        List<Value> item=List();
                        for(int i=0;i<selectedIndex.length;i++){
                          
                          if(selectedIndex.elementAt(i))
                            item.add(listViewItem.elementAt(i));
                        }
                        
                        if(item.isEmpty)
                          showToast(AppLocalizations.of(context).translate("plz_pick_specalist"));
                        else
                          openPage(context, SwearPage.interprete(item));
                        },),
                    )



                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
