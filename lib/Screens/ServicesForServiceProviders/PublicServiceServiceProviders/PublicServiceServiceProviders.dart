import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesModel.dart';
import 'package:faserholmak/Model/WorkTypeUser/Value.dart';
import 'package:faserholmak/Model/WorkTypeUser/WorkTypeModel.dart';
import 'package:faserholmak/Screens/DetailsServiceYouWant/DetailsServiceYouWant.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/wigets/CardDreams.dart';
import 'package:flutter/material.dart';
import 'package:faserholmak/Helper/AppApi.dart';

import '../../../constants.dart';

class PublicServiceServiceProviders extends StatefulWidget {
  @override
  _PublicServiceServiceProvidersState createState() => _PublicServiceServiceProvidersState();
}

class _PublicServiceServiceProvidersState extends State<PublicServiceServiceProviders> {


  /*User work Types*/
/*  List<Value>userWorkList=List();*/
  Value selectedUserWork;


  int skipNumber=0;
  int topNumber=10;
  int allCount=10;
  List<AllServicesData> listServicesData=List();
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();
  bool isLoadingPage=false;
  bool isLoadingRefersh=false;
  bool isLoadingMore=false;

  var controllerScroll = ScrollController();

  void setPage(bool state){
    setState(() {
      isLoadingPage=state;
    });
  }

  void setMore(bool state){
    setState(() {
      isLoadingMore=state;
    });
  }

  void setRefresh(bool state){
    setState(() {
      isLoadingRefersh=state;
    });
  }


  Widget dataListView(List<AllServicesData> data, context) {
    if (data == null)
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            failedOpreation,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    else if (data.length > 0)
      return ListView.builder(
          shrinkWrap: true,

          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            if(isLoadingMore&&index==data.length-1)
              return Center(child: CircularProgressIndicator(),);
            else{  AllServicesData item=listServicesData[index];
            return CardDreams(desc: item.description,likes: item.numberOfLikes,views: item.numberOfViews,
                press: (){ openPage(context, DetailsServiceYouWant(servicesData: item,forPublicPage: true,));});}
          });
    else
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Text(
              noData,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
  }


/*  Future<void> getAllUserWorkRQ() async {
    var responseGetWorks=await getWorkTypeRQ();
    if(responseGetWorks.statusCode==200){
      WorkTypeModel item=responseGetWorks.object;
      setState(() {

        userWorkList=List();
        userWorkList.addAll(item.value);
      });
    }
  }*/


  Future<void> getAllServicesRQ({int skip,int top,bool loadMore=false}) async {
    // var response=await getAllServiceClient(filterUserID: userInfo.id,filterType: DoneTxt);
    var filterUserWork;
    if(selectedUserWork!=null &&selectedUserWork.id!=null)
      filterUserWork=selectedUserWork.id;
    var response=await getAllServicePublic(top: top,skip: skip,filterWorkType: filterUserWork,
       );
    if(response.statusCode==200){
      List<AllServicesData> item=response.object;
      setState(() {
      //  allCount=int.parse(item.odata_count);

        listServicesData=response.object;
     /*   if(!loadMore)
          listServicesData=item.value;
        else listServicesData.addAll(item.value);*/
      });


    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshKey.currentState.show());


    /*controllerScroll.addListener(() async {
      if (controllerScroll.position.atEdge) {
        if (controllerScroll.position.pixels == 0){
          // you are at top position
        }
        else{

          int listSize=listServicesData.length;
          if(listSize<allCount&&!isLoadingRefersh){
            skipNumber=listSize;
            if((allCount-listSize)<10)
              topNumber=(allCount-listSize);
            else topNumber=10;
            setMore(true);
            await getAllServicesRQ(skip: skipNumber,top: topNumber,loadMore: true);
            setMore(false);
          }
          // loadMoreReceiver();
          // you are at bottom position


        }
      }
    });*/

  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("الخدمات العامة"),
        ),
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: ()async{
            setState(() {
              /* selectedUserWork=Value();*/
              //   userWorkList=List();
              //  listServicesData=List();
              isLoadingRefersh=true;
            });
            // setRefresh(true);
           // await getAllUserWorkRQ();
            await getAllServicesRQ(skip: skipNumber,top: topNumber);
            setRefresh(false);
          },
          child: SingleChildScrollView(
            controller: controllerScroll,
            child:isLoadingRefersh?
            Container(

              child: Background(
                child: Container(),
              ),
            ):
            Container(


              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20,),
                  /*Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(

                      padding: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: kPrimaryLightColor,
                          )),
                      child: DropdownButton<Value>(

                        isExpanded: true,
                        underline: Container(),
                        elevation: 10,
                        hint: Text(orderBy,style: getTextSyle(16, Colors.black,fontWeight: FontWeight.w600),
                          textDirection: TextDirection.rtl, textAlign: TextAlign.center,),
                        value: selectedUserWork!=null?selectedUserWork:null,
                        onChanged: (Value value) async {
                          print("-----------------");
                          setState(() {
                            selectedUserWork = value;
                          });
                          setRefresh(true);
                          await getAllServicesRQ(top: 10,skip: 0);
                          setRefresh(false);
                        },
                        items: userWorkList.map((Value data) {
                          return DropdownMenuItem<Value>(
                            value: data,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    data.name.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),*/
                //  SizedBox(height: 10,),

                  dataListView(listServicesData,context),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
