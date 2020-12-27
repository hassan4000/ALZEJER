import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/SABT.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesModel.dart';
import 'package:faserholmak/Model/UserInfoModel/UserInfoModel.dart';
import 'package:faserholmak/Model/compitionList/Competition.dart';
import 'package:faserholmak/Model/compitionList/CompitionResponse.dart';
import 'package:faserholmak/Screens/Drawer/MyDrawer.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/TabWithImage/SliverAppBarDelegate.dart';
import 'package:faserholmak/Screens/TabWithImage/ratingTab/RatingInsideTab.dart';


import 'package:faserholmak/wigets/CardDreams.dart';
import 'package:faserholmak/wigets/PersonalProfileContent.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../constants.dart';
import 'card_compition.dart';


class CompititionMofaser extends StatefulWidget {



  bool normalUser=false;
  CompititionMofaser({this.normalUser=false});

  @override
  _TabWithImageState createState() => _TabWithImageState();
}

class _TabWithImageState extends State<CompititionMofaser> with TickerProviderStateMixin{

  TabController tabController;




  /*--------------------------notDone-------------------*/

  int notDoneSkipNumber=0;
  int notDoneTopNumber=10;
  int notDoneAllCount=10;
  List<Competition>notDoneListServicesData;
  GlobalKey<RefreshIndicatorState> notDoneRefreshKey=new GlobalKey<RefreshIndicatorState>();
  bool notDoneIsLoadingRefersh=true;
  bool notDoneIsLoadingMore=false;
  var notDoneControllerScroll = ScrollController();
  void notDoneSetMore(bool state){
    setState(() {
      notDoneIsLoadingMore=state;
    });
  }
  void notDoneSetRefresh(bool state){
    setState(() {
      notDoneIsLoadingRefersh=state;
    });
  }





  Widget notDoneDataListView(List<Competition> data, context) {


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

          controller: notDoneControllerScroll,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            if(notDoneIsLoadingMore&&index==data.length-1)
              return Center(child: CircularProgressIndicator(),);
            else{  Competition  item=notDoneListServicesData[index];
            return CardCompition(item);}
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
//
  Future<void> getAllNotDone({int skip,int top,bool loadMore=false}) async {
    // var response=await getAllServiceClient(filterUserID: userInfo.id,filterType: DoneTxt);



    printWrapped("Skip$skip/top$top");
    var response=await getAllCompition(skip: skip,top: top,);
    if(response.statusCode==200){
      CompitionResponse item=response.object;
      setState(() {
        notDoneAllCount=item.count;
        if(loadMore==null ||!loadMore){
          notDoneIsLoadingRefersh=false;
          notDoneListServicesData=item.competitions;



        }
        else notDoneListServicesData.addAll(item.competitions);
      });


    }
  }






  /*--------------------------------------------------------*/

  /*---------------------------Done-----------------------------*/

  int doneSkipNumber=0;
  int doneTopNumber=10;
  int doneAllCount=10;
  List<Competition>doneListServicesData;
  GlobalKey<RefreshIndicatorState>doneRefreshKey=new GlobalKey<RefreshIndicatorState>();
  bool doneIsLoadingRefersh=false;
  bool doneIsLoadingMore=false;
  var doneControllerScroll = ScrollController();
  void doneSetMore(bool state){
    setState(() {
     doneIsLoadingMore=state;
    });
  }
  void doneSetRefresh(bool state){
    setState(() {
     doneIsLoadingRefersh=state;
    });
  }

  Widget doneDataListView(List<Competition> data, context) {

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

          controller: doneControllerScroll,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            if(doneIsLoadingMore&&index==data.length-1)
              return Center(child: CircularProgressIndicator(),);
            else{  Competition  item=doneListServicesData[index];
            return CardCompition(item,end: true,);}
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

  Future<void> doneGetAllServicesRQ({int skip,int top,bool loadMore=false}) async {
    // var response=await getAllServiceClient(filterUserID: userInfo.id,filterType: DoneTxt);

    printWrapped("Skip$skip/top$top");
    var response=await getAllCompition(skip: skip,top: top,filterType:"Finished");
    if(response.statusCode==200){
      CompitionResponse item=response.object;
      setState(() {
        doneAllCount=item.count;
        if(loadMore==null ||!loadMore){
          doneIsLoadingRefersh=false;
          doneListServicesData=item.competitions;




        }
        else doneListServicesData.addAll(item.competitions);
      });


    }
  }




  @override
 void initState()   {
    super.initState();
    tabController = new TabController( length: 2, vsync: this);
    tabController.index=0;
    initializeDateFormatting();


    getAllNotDone(top: notDoneTopNumber,skip: notDoneSkipNumber);
    tabController.addListener((){
      if (tabController.index == 0 && notDoneListServicesData == null&& notDoneRefreshKey.currentState!=null){
        notDoneRefreshKey.currentState.show();
        printWrapped("done  ${tabController.index}/ $notDoneListServicesData/");
      }

      if (tabController.index == 1 && doneListServicesData == null&& doneRefreshKey.currentState!=null){
        doneRefreshKey.currentState.show();

      }

      else  printWrapped("${tabController.index}/ $notDoneListServicesData/");



/*

      if (tabController.index == 1 && doneListServicesData == null&& doneRefreshKey.currentState!=null)
        doneRefreshKey.currentState.show();*/
    });


    notDoneControllerScroll.addListener(() async {
      if (notDoneControllerScroll.position.atEdge) {
        if (notDoneControllerScroll.position.pixels == 0){
          // you are at top position
        }
        else{


          int listSize=notDoneListServicesData.length;
          if(listSize<notDoneAllCount&&!notDoneIsLoadingRefersh&&!notDoneIsLoadingMore){
            notDoneSkipNumber=listSize;
            if((notDoneAllCount-listSize)<10)
              notDoneTopNumber=(notDoneAllCount-listSize);
            else notDoneTopNumber=10;
            notDoneSetMore(true);
            await getAllNotDone(skip: notDoneSkipNumber,top: notDoneTopNumber,loadMore: true);
            notDoneSetMore(false);
          }



          // loadMoreReceiver();
          // you are at bottom position


        }
      }
    });










   doneControllerScroll.addListener(() async {
      if (doneControllerScroll.position.atEdge) {
        if (doneControllerScroll.position.pixels == 0){
          // you are at top position
        }
        else{


          int listSize=doneListServicesData.length;
          if(listSize<doneAllCount&&!doneIsLoadingRefersh&&!doneIsLoadingMore){
            doneSkipNumber=listSize;
            if((doneAllCount-listSize)<10)
              doneTopNumber=(doneAllCount-listSize);
            else doneTopNumber=10;
            doneSetMore(true);
            await doneGetAllServicesRQ(skip: doneSkipNumber,top: doneTopNumber,loadMore: true);
            doneSetMore(false);
          }
          // loadMoreReceiver();
          // you are at bottom position



        }
      }
    });



  }
  
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(

        body: DefaultTabController(


          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    centerTitle: true,
                    title: SABT(
                        child: Text(comptiotn,
                            style: TextStyle(color: Colors.blue))),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),

                 /*   actions: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                              onTap: () {
                                print(
                                    "inner  " + innerBoxIsScrolled.toString());
                              },
                              child: Icon(
                                Icons.print,
                                color: kPrimaryColor,
                              )))
                    ],*/
                    flexibleSpace: FlexibleSpaceBar(

                        background: Background(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            width: 130,
                            height: 130,
                            child: ClipOval(
                                child: Image.network(
                                  imageUrl+userInfo.pictureId,loadingBuilder:
                                (BuildContext context, Widget child, ImageChunkEvent loadingProgress){
                                  if (loadingProgress == null)
                                    return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                              fit: BoxFit.cover,
                            )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(userInfo.name,style: getTextSyle(16, Colors.black),)
                        ],
                      ),
                    ))),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    TabBar(

                      controller: tabController,
                      isScrollable: false,
                      labelColor: kPrimaryColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: [

                             Tab(icon: Icon(Icons.star), text: compitionNotDone),

                       Tab(icon: Icon(Icons.close), text: compitionDone),

                      ],
                    ),
                  ),
                  pinned: true,

                ),
              ];
            },
            body: TabBarView(
              controller:tabController ,

              children: [
                //PersonalInfo(),
                RefreshIndicator(
                  key: notDoneRefreshKey,
                  onRefresh: ()async{
                    notDoneSetRefresh(true);
                    await getAllNotDone(skip: notDoneSkipNumber,top: notDoneTopNumber);
                    notDoneSetRefresh(false);

                  },
                  child: !notDoneIsLoadingRefersh?  notDoneDataListView(notDoneListServicesData, context):
                  Center(child: Text("$pleazeWait"),),
                ),
                RefreshIndicator(
                  key: doneRefreshKey,
                  onRefresh: ()async{
                    doneSetRefresh(true);
                    await doneGetAllServicesRQ(skip: notDoneSkipNumber,top: notDoneTopNumber);
                    doneSetRefresh(false);

                  },
                  child: !doneIsLoadingRefersh?  doneDataListView(doneListServicesData, context):
                  Center(child: Text("$pleazeWait"),),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
