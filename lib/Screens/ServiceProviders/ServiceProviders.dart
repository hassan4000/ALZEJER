import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AddServices/AddServiceModel.dart';
import 'package:faserholmak/Model/ProvidersModelPagination/ProviderModelPagination.dart';
import 'package:faserholmak/Model/UserInfoModel/UserInfoModel.dart';
import 'package:faserholmak/Model/WorkTypeUser/Value.dart';
import 'package:faserholmak/Screens/HisVision/HisVisionPage.dart';
import 'package:faserholmak/Screens/HisVisionAllPage/HisVisionAllPage.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/TabWithImage/TabWithImage.dart';
import 'package:faserholmak/wigets/CardServicesProvider.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ServiceProviders extends StatefulWidget {
  final Value selectedService;

  ServiceProviders({this.selectedService});


  @override
  _ServiceProvidersState createState() => _ServiceProvidersState();
}

class _ServiceProvidersState extends State<ServiceProviders> {
  bool isLoading=false;
  bool isLoadingHUD=false;
  List<UserInfoModel> listUser;
  var controllerScroll = ScrollController();
  int skipNumber=0;
  int topNumber=10;
  int allCount=10;
  bool isLoadingMore=false;




  void setMore(bool state){
    setState(() {
      isLoadingMore=state;
    });
  }
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();


  Future<void> getAllData({int skip,int top,bool loadMore=false})async{

    print("------------------------------------------------${loadMore}");
    var response=await getServiceProviders(widget.selectedService.id.toString(),top: top,skip: skip);
    if(response.statusCode==200){
        ProviderModelPagination item=response.object;


      setState(() {
        allCount=item.odata_count;
        if(!loadMore){
          print("LoadMoreNot");
        listUser=item.value;}
        else{
          listUser.addAll(item.value);
          print("LoadMore");
        }
      });
  }
  }

  Widget dataListView(List<UserInfoModel> data, context) {
    if (data == null)
      return Container(
        height:100,
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
            else{
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child:CardServicesProvider(
                userInfoModel: data.elementAt(index),
              pressShowPath:(){
                showServicesPath(data.elementAt(index));
              },
              pressShowProviderPage: (){
                  print("---------------");
                showServicesProvidersPage(data.elementAt(index));
              },),
            );}
          });
    else
      return Container(
        height: 100,
        child: Center(
            child: Text(
              noData,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
  }



  void showServicesPath(UserInfoModel item){
    AddServiceModel addServiceModel=AddServiceModel();
    addServiceModel.serviceProviderId=item.id;
    addServiceModel.userWorkId=widget.selectedService.id;

    /*Dream*/
    if(emptyString(widget.selectedService.code)=="Dream")
    openPage(context, HisVisionPage(addServiceModel: addServiceModel,));
    else
      openPage(context, HisVisionAllPage(addServiceModel: addServiceModel,));
  }

  void showServicesProvidersPage(UserInfoModel item) async {
    setHUD(true);
    var response=await getSingleUserInfo(id: item.id);
    if(response.statusCode==200){
      UserInfoModel item=response.object;
      openPage(context, TabWithImage(item,normalUser: true,));
    }
    setHUD(false);

  }

  void reSetLoading(bool state){
    setState(() {
      isLoading=state;
    });
  }

  void setHUD(bool state){
    setState(() {
      isLoadingHUD=state;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshKey.currentState.show());

    controllerScroll.addListener(() async {
      if (controllerScroll.position.atEdge) {
        if (controllerScroll.position.pixels == 0) {
          // you are at top position
        }
        else {
          int listSize = listUser.length;
          print("listSize=${listUser.length}");
          print("allCount=${allCount}");

          if (listSize < allCount && !isLoading&&!isLoadingMore) {
            skipNumber = listSize;
            if ((allCount - listSize) < 10)
              topNumber = (allCount - listSize);
            else
              topNumber = 10;
            setMore(true);
            await getAllData(skip: skipNumber, top: topNumber, loadMore: true);
            setMore(false); // loadMoreReceiver();
            // you are at bottom position


          }
        }
      }});
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(selectProvider,style: getTextSyle(14, Colors.white),),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoadingHUD,
          child: RefreshIndicator(

            key: refreshKey,
            onRefresh: ()async{
              reSetLoading(true);
           await   getAllData(skip: skipNumber,top: topNumber,loadMore: false);

              reSetLoading(false);


            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: controllerScroll,
              child:isLoading?
              Container(

                child: Background(
                  child: Container(),
                ),
              ):
              Container(


                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(height: 10,),

                    dataListView(listUser,context),


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
