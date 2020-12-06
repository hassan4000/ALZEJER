import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';

import 'package:faserholmak/Model/UserInfoModel/UserInfoModel.dart';
import 'package:faserholmak/Model/UserInfoModel/UserWork.dart';
import 'package:faserholmak/Model/WorkTypeUser/Value.dart';
import 'package:faserholmak/Model/WorkTypeUser/WorkTypeModel.dart';
import 'package:faserholmak/Screens/GeneralPageServicesProvider/GeneralPageServicesProvider.dart';
import 'package:faserholmak/Screens/HowAppWork/HowAppWork.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/createAccountMofaser/CreateAccountMofaser.dart';
import 'package:faserholmak/wigets/LogoIcon.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../constants.dart';


class EditWotkTypeForMofase extends StatefulWidget {
  @override
  _EditWotkTypeForMofaseState createState() => _EditWotkTypeForMofaseState();
}

class _EditWotkTypeForMofaseState extends State<EditWotkTypeForMofase> {

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
      return Container(

        child: Center(
            child: Text(
              failedOpreation,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
    else if (data.length > 0)
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
    else
      return Container(
        child: Center(
            child: Text(
              noSpecaist,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
  }

  void getWorkData()async{

    setIsLoading(true);
    var response=await getWorkTypeRQ();
    if(response.statusCode==200){
      WorkTypeModel workTypeModel=response.object;



      print("size befor ${workTypeModel.value.length}");
      for(int i =0;i<userInfo.userWorks.length;i++) {
        for (int j=0; j < workTypeModel.value.length; j++) {

          print("i=${i}");
          print("j=${j}");
          print("id userWorrk=${userInfo.userWorks.elementAt(i).userWorkId}");
          print("id allWorks=${workTypeModel.value.elementAt(j).id}");
          print("--------------------------------");

          if (workTypeModel.value.elementAt(j).id ==userInfo.userWorks.elementAt(i).userWorkId)
            workTypeModel.value.removeAt(j);
        }
      }



      print("size after ${workTypeModel.value.length}");

      if(workTypeModel.value.isNotEmpty){

        setState(() {
          listViewItem=workTypeModel.value;
          selectedIndex= new List(workTypeModel.value.length);
          selectedIndex.fillRange(0, workTypeModel.value.length,false);

        });




      }else{
        setState(() {
          listViewItem=workTypeModel.value;
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
          title: Text(addUserWork,style: getTextSyle(16, Colors.white),textDirection: TextDirection.rtl,),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Background(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                            child: Text(hint1CreateWorkTypePage,style:getTextSyle(20,kPrimaryColor),
                              textDirection: TextDirection.rtl,),
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
                            child: Text(hint2CreateWorkTypePage,style:getTextSyle(20,kPrimaryColor),
                              textDirection: TextDirection.rtl,),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(whatSpecializationAreYouGoodAt,style:getTextSyle(20,kPrimaryColor,fontWeight: FontWeight.w400),
                        textDirection: TextDirection.rtl,),
                    ),
                    Container(

                      height: MediaQuery.of(context).size.height/2,
                      width: MediaQuery.of(context).size.width,
                      child: isLoading?Container():_dataListView(listViewItem,context),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: MyButton(txt: continueTxt,
                        press: () async {

                          List<Value> item=List();
                          for(int i=0;i<selectedIndex.length;i++){

                            if(selectedIndex.elementAt(i))
                              item.add(listViewItem.elementAt(i));
                          }


                          setIsLoading(true);
                          var addUserWorkResponse= await addUserWorkToMofaser(item,userInfo.id);
                          if(addUserWorkResponse.statusCode==200){

                            var responser= await getUserInfoRQ(token: token);


                            if(responser.statusCode==200){
                              showToast(successfulOpreation);
                                openPageAndClearPrev(context: context,route:HomePageRoute2,page: GeneralPageServicesProvider()) ;

                            }





                          }
                          setIsLoading(false);

                          if(item.isEmpty)
                            showToast(plz_pick_specalist);

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
