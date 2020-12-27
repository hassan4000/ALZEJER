import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';

import 'package:faserholmak/Model/AllServicesModel/AllServicesModel.dart';
import 'package:faserholmak/Model/CompitionUserModel/CompitionListUser.dart';
import 'package:faserholmak/Model/WorkTypeUser/Value.dart';
import 'package:faserholmak/Model/WorkTypeUser/WorkTypeModel.dart';
import 'package:faserholmak/Screens/DetailsServiceYouWant/DetailsServiceYouWant.dart';
import 'package:faserholmak/Screens/Drawer/MyDrawer.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/compititionMofaser/card_compition_user.dart';
import 'package:faserholmak/wigets/CardDreams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';





class CompitionListUserPage extends StatefulWidget {
  String id;
  int duration;
  bool end=false;

  CompitionListUserPage(this.id,this.duration,{this.end});

  @override
  _CompitionListUserPageState createState() => _CompitionListUserPageState();
}

class _CompitionListUserPageState extends State<CompitionListUserPage> {





  int skipNumber=0;
  int topNumber=10;
  int allCount=10;
  List<CompitionListUser> listServicesData=List();
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


  Widget dataListView(List<CompitionListUser> data, context) {
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
          else{  CompitionListUser item=listServicesData[index];
            return CardCompitionUser(item,widget.duration);}
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





  Future<void> getAllServicesRQ({int skip,int top,bool loadMore=false}) async {
   // var response=await getAllServiceClient(filterUserID: userInfo.id,filterType: DoneTxt);

    var response=await getAllUserForCompition(filterid:widget.id.toString());
    if(response.statusCode==200){
      List<CompitionListUser> item=response.object;
      setState(() {
        allCount=item.length;
        if(!loadMore)
        listServicesData=response.object;
        else listServicesData.addAll(response.object);
      });


    }
    }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshKey.currentState.show());


    controllerScroll.addListener(() async {
      if (controllerScroll.position.atEdge) {
        if (controllerScroll.position.pixels == 0){
          // you are at top position
        }
        else{

    /*      int listSize=listServicesData.length;
          if(listSize<allCount&&!isLoadingRefersh){
            skipNumber=listSize;
            if((allCount-listSize)<10)
              topNumber=(allCount-listSize);
            else topNumber=10;
            setMore(true);
            await getAllServicesRQ(skip: skipNumber,top: topNumber,loadMore: true);
            setMore(false);
          }*/
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

        appBar: AppBar(
          centerTitle: true,
          title: Text("$compitionUsers"),
        ),
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: ()async{
        

            setRefresh(true);
        
        
            await getAllServicesRQ(skip: skipNumber,top: topNumber);
            setRefresh(false);
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            controller: controllerScroll,
            child:isLoadingRefersh?
            Container(

              child: Container(),
            ):
            Container(


              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 30,),
                  Flexible(child: dataListView(listServicesData,context)),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
