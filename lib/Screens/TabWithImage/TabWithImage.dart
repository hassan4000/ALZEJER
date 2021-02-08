import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/SABT.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesModel.dart';
import 'package:faserholmak/Model/UserInfoModel/UserInfoModel.dart';
import 'package:faserholmak/Screens/Drawer/MyDrawer.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/TabWithImage/SliverAppBarDelegate.dart';
import 'package:faserholmak/Screens/TabWithImage/ratingTab/RatingInsideTab.dart';
import 'package:faserholmak/wigets/CardDreams.dart';
import 'package:faserholmak/wigets/PersonalProfileContent.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:faserholmak/Helper/AppApi.dart';

import '../../app_localizations.dart';
import '../../constants.dart';
import 'PersnalInfo/PersonlaInfo.dart';

class TabWithImage extends StatefulWidget {

  UserInfoModel item;

  bool normalUser=false;
  TabWithImage(this.item,{this.normalUser=false});

  @override
  _TabWithImageState createState() => _TabWithImageState();
}

class _TabWithImageState extends State<TabWithImage> with TickerProviderStateMixin{

  TabController tabController;

  /*-------------------Personal-----------------------*/
  Widget personalInfoWidget(UserInfoModel userInfoModel){
    return SingleChildScrollView(
      child:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[

            PersonalProfileContent(hint:AppLocalizations.of(context).translate("personalDescription") ,text:emptyString(userInfoModel.personalDescription) ),
         //   PersonalProfileContent(hint:AppLocalizations.of(context).translate("socialStatus"),text: emptyString(userInfoModel.socialStatus)),
            PersonalProfileContent(hint:AppLocalizations.of(context).translate("country") ,text:emptyString(userInfoModel.country)),
         //   PersonalProfileContent(hint:AppLocalizations.of(context).translate("work"),text: emptyString(userInfoModel.jobDescription)),
            PersonalProfileContent(hint:AppLocalizations.of(context).translate("dreamsiInterpreted") ,text: emptyString(userInfoModel.numberOfDoneServices.toString())),
            PersonalProfileContent(hint:AppLocalizations.of(context).translate("dreamsPending"),text:  emptyString(userInfoModel.numberOfActiveServices.toString())),
            PersonalProfileContent(hint:AppLocalizations.of(context).translate("speen"),text:  emptyString(userInfoModel.speed.toString())),
            PersonalProfileContent(hint:AppLocalizations.of(context).translate("dreamsPerDay"), text:emptyString(userInfoModel.avgServicesInOneDay.toString())),

          ],
        ),
      ) ,
    );
  }


  /*--------------------------Rating-------------------*/

  int rateSkipNumber=0;
  int rateTopNumber=10;
  int rateAllCount=10;
  List<AllServicesData>rateListServicesData;
  //List<AllServicesData>rateListServicesData=List();
  GlobalKey<RefreshIndicatorState> rateRefreshKey=new GlobalKey<RefreshIndicatorState>();
  bool rateIsLoadingRefersh=false;
  bool rateIsLoadingMore=false;
  var rateControllerScroll = ScrollController();
  void rateSetMore(bool state){
    setState(() {
      rateIsLoadingMore=state;
    });
  }
  void rateSetRefresh(bool state){
    setState(() {
      rateIsLoadingRefersh=state;
    });
  }





  Widget rateDataListView(List<AllServicesData> data, context) {
    if (data == null)
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            AppLocalizations.of(context).translate("failedOpreation"),
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    else if (data.length > 0)
      return ListView.builder(
          shrinkWrap: true,

          controller: rateControllerScroll,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            if(rateIsLoadingMore&&index==data.length-1)
              return Center(child: CircularProgressIndicator(),);
            else{  AllServicesData item=rateListServicesData[index];
            if(item.ratingMessage==null) return Container();
            return RatingInsideTab(date: emptyString(item.ratingDate),
            idServices: item.id.toString(),
            message: emptyString(item.ratingMessage),
                rating: double.parse(item.userRating.toString()),);}
          });
    else
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Text(
              AppLocalizations.of(context).translate("noData"),
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
  }

  Future<void> getAllRatingRQ({int skip,int top,bool loadMore=false}) async {
    // var response=await getAllServiceClient(filterUserID: userInfo.id,filterType: DoneTxt);

    var response=await getAllServiceServicesProvider(filterUserID: widget.item.id,top: top,skip: skip,filterType: DoneTxt);
    if(response.statusCode==200){
      AllServicesModel item=response.object;
      setState(() {
        rateAllCount=int.parse(item.odata_count);


        if(!loadMore){
         // rateListServicesData.clear();
          if(rateListServicesData!=null) rateListServicesData.clear();
       //  rateListServicesData=item.value;
        }
       // else rateListServicesData.addAll(item.value);


        for (var i in item.value){
          if(i.ratingMessage!=null)
            rateListServicesData.add(i);
        }

        if(rateListServicesData==null)
          rateListServicesData=List<AllServicesData>();


      });


    }
  }


  /*-----------------------onProgressData----------------------------------*/


  int onProgessSkipNumber=0;
  int onProgessTopNumber=10;
  int onProgessAllCount=10;
  List<AllServicesData> onProgessListServicesData;
  GlobalKey<RefreshIndicatorState> onProgessRefreshKey=new GlobalKey<RefreshIndicatorState>();
  bool onProgessIsLoadingRefersh=false;
  bool onProgessIsLoadingMore=false;
  var onProgessControllerScroll = ScrollController();
  void onProgessSetMore(bool state){
    setState(() {
      onProgessIsLoadingMore=state;
    });
  }
  void onProgessSetRefresh(bool state){
    setState(() {
      onProgessIsLoadingRefersh=state;
    });
  }
  Widget onProgressDataListView(List<AllServicesData> data, context) {
    if (data == null)
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            AppLocalizations.of(context).translate("failedOpreation"),
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    else if (data.length > 0)
      return ListView.builder(
          shrinkWrap: true,

          controller: onProgessControllerScroll,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            if(onProgessIsLoadingMore&&index==data.length-1)
              return Center(child: CircularProgressIndicator(),);
            else{  AllServicesData item=onProgessListServicesData[index];
            if(!widget.normalUser){
            return CardDreams(desc: emptyString(item.description),likes: item.numberOfLikes,views: item.numberOfViews,
              showExplanationText: showExplnationText(
                  explnation: item.explanation),
              explantaion:
              emptyString(item.explanation),
       
            );}

            else {

              if(item.privateService==null||!item.privateService)
                 return CardDreams(desc: emptyString(item.description),likes: item.numberOfLikes,views: item.numberOfViews,
                showExplanationText: showExplnationText(
                    explnation: item.explanation),
                explantaion:
                emptyString(item.explanation),

              );

              else return  Container();
            }






            }
          });
    else
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Text(
              AppLocalizations.of(context).translate("noData"),
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
  }

  Future<void> onProgressGetAllServicesRQ({int skip,int top,bool loadMore=false}) async {
    // var response=await getAllServiceClient(filterUserID: userInfo.id,filterType: DoneTxt);

    var response=await getAllServiceServicesProvider(filterUserID: widget.item.id,top: top,skip: skip,);
    if(response.statusCode==200){
      AllServicesModel item=response.object;
      setState(() {
        onProgessAllCount=int.parse(item.odata_count);
        if(!loadMore)
          onProgessListServicesData=item.value;
        else onProgessListServicesData.addAll(item.value);
      });


    }
  }



  /*--------------------------------------------------------*/

  /*---------------------------Done-----------------------------*/

  int doneSkipNumber=0;
  int doneTopNumber=10;
  int doneAllCount=10;
  List<AllServicesData>doneListServicesData;
  GlobalKey<RefreshIndicatorState>doneRefreshKey=new GlobalKey<RefreshIndicatorState>();
  bool doneIsLoadingRefersh=true;
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

  Widget doneDataListView(List<AllServicesData> data, context) {
    if (data == null)
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            AppLocalizations.of(context).translate("failedOpreation"),
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    else if (data.length > 0)
      return ListView.builder(
          shrinkWrap: true,

         // controller:doneControllerScroll,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            if(doneIsLoadingMore&&index==data.length-1)
              return Center(child: CircularProgressIndicator(),);
            else{  AllServicesData item=doneListServicesData[index];

            if(!widget.normalUser)
            return CardDreams(
              indexServices: true,
              desc: emptyString(item.description),likes: item.numberOfLikes,views: item.numberOfViews,
              showExplanationText: showExplnationText(
                  explnation: item.explanation),
              explantaion:
              emptyString(item.explanation),);


            else{

              if(item.privateService==null||!item.privateService)
                return CardDreams(desc: emptyString(item.description),likes: item.numberOfLikes,views: item.numberOfViews,
                  showExplanationText: showExplnationText(
                      explnation: item.explanation),
                  explantaion:
                  emptyString(item.explanation),);
              else   return Container();



            }





            }
          });
    else
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Text(
                 AppLocalizations.of(context).translate("noData"),
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
  }

  Future<void> doneGetAllServicesRQ({int skip,int top,bool loadMore=false}) async {
    // var response=await getAllServiceClient(filterUserID: userInfo.id,filterType: DoneTxt);

    var response=await getAllServiceServicesProvider(filterUserID: widget.item.id,top: top,skip: skip,filterType: DoneTxt);
    if(response.statusCode==200){
      AllServicesModel item=response.object;
      setState(() {
        doneIsLoadingRefersh=false;
       doneAllCount=int.parse(item.odata_count);
        if(!loadMore)
         doneListServicesData=item.value;
        else doneListServicesData.addAll(item.value);
      });


    }
  }




  @override
  void initState() {
    super.initState();
    tabController = new TabController( length: 3, vsync: this);
    tabController.index=0;

    doneGetAllServicesRQ(skip: doneSkipNumber,top: doneTopNumber);
    tabController.addListener((){
      if (tabController.index == 1 && rateListServicesData == null&& rateRefreshKey.currentState!=null)
        rateRefreshKey.currentState.show();
      if (tabController.index == 2 && onProgessListServicesData == null&& onProgessRefreshKey.currentState!=null)
        onProgessRefreshKey.currentState.show();

      if (tabController.index == 0 && doneListServicesData == null&& doneRefreshKey.currentState!=null)
        doneRefreshKey.currentState.show();
    });




    rateControllerScroll.addListener(() async {
      if (rateControllerScroll.position.atEdge) {
        if (rateControllerScroll.position.pixels == 0){
          // you are at top position
        }
        else{

          int listSize=rateListServicesData.length;
          if(listSize<rateAllCount&&!rateIsLoadingRefersh&&!rateIsLoadingMore){
            rateSkipNumber=listSize;
            if((rateAllCount-listSize)<10)
              rateTopNumber=(rateAllCount-listSize);
            else rateTopNumber=10;
            rateSetMore(true);
            await getAllRatingRQ(skip: rateSkipNumber,top: rateTopNumber,loadMore: true);
            rateSetMore(false);
          }
          // loadMoreReceiver();
          // you are at bottom position


        }
      }
    });


    onProgessControllerScroll.addListener(() async {
      if (onProgessControllerScroll.position.atEdge) {
        if (onProgessControllerScroll.position.pixels == 0){
          // you are at top position
        }
        else{

          int listSize=onProgessListServicesData.length;
          if(listSize<onProgessAllCount&&!onProgessIsLoadingRefersh&&!onProgessIsLoadingMore){
            onProgessSkipNumber=listSize;
            if((onProgessAllCount-listSize)<10)
              onProgessTopNumber=(onProgessAllCount-listSize);
            else onProgessTopNumber=10;
            onProgessSetMore(true);
            await onProgressGetAllServicesRQ(skip: onProgessSkipNumber,top: onProgessTopNumber,loadMore: true);
            onProgessSetMore(false);
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


          length: 3,
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
                        child: Text(AppLocalizations.of(context).translate("serviceProviderPape"),
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
                                  imageUrl+widget.item.pictureId,loadingBuilder:
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
                          Text(widget.item.name,style: getTextSyle(16, Colors.black),)
                        ],
                      ),
                    ))),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    TabBar(

                      controller: tabController,
                      isScrollable: true,
                      labelColor: kPrimaryColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        InkWell(
                            child: Tab(icon: Icon(Icons.info), text:  AppLocalizations.of(context).translate("personalInfo")),
                       ),
                        Tab(icon: Icon(Icons.info), text:  AppLocalizations.of(context).translate("rating")),
                        Tab(icon: Icon(Icons.info), text:  AppLocalizations.of(context).translate("dreamsPending")),

                      //  Tab(icon: Icon(Icons.info), text:  AppLocalizations.of(context).translate("dreamsiInterpreted")),
                      ],
                    ),
                  ),
                  pinned: false,
                ),
              ];
            },
            body: TabBarView(
              controller:tabController ,

              children: [
                //PersonalInfo(),
               // personalInfoWidget(widget.item),
                RefreshIndicator(
                  key:doneRefreshKey,
                  onRefresh: ()async{
                    tabController.index=0;
                    doneSetRefresh(true);
                      await doneGetAllServicesRQ(skip: doneSkipNumber,top: doneTopNumber);
                    doneSetRefresh(false);

                  },
                  child: SingleChildScrollView(
                    controller: doneControllerScroll,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        personalInfoWidget(widget.item),
                        !doneIsLoadingRefersh?  doneDataListView(doneListServicesData, context):
                        Center(child: Text(AppLocalizations.of(context).translate("pleazeWait")),),
                    ],),
                  )
                ),
                RefreshIndicator(
                  key: rateRefreshKey,
                  onRefresh: ()async{
                    rateSetRefresh(true);
                    await getAllRatingRQ(skip: rateSkipNumber,top: rateTopNumber);
                    rateSetRefresh(false);

                  },
                  child: !rateIsLoadingRefersh?  rateDataListView(rateListServicesData, context):
                  Container(),
                ),
                RefreshIndicator(
                  key: onProgessRefreshKey,
                  onRefresh: ()async{
                    onProgessSetRefresh(true);
                    await onProgressGetAllServicesRQ(skip: onProgessSkipNumber,top: onProgessTopNumber);
                    onProgessSetRefresh(false);

                  },
                  child: !onProgessIsLoadingRefersh?  onProgressDataListView(onProgessListServicesData, context):
                  Container(),
                ),
               // personalInfoWidget(widget.item),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
