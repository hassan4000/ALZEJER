import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Model/AddServices/AddServiceModel.dart';
import 'package:faserholmak/Model/UserInfoModel/UserInfoModel.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/TabWithImage/TabWithImage.dart';
import 'package:faserholmak/wigets/CardServicesProvider.dart';
import 'package:faserholmak/wigets/CardServicesProviderV2.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AllProvidersPage extends StatefulWidget {
  @override
  _AllProvidersPageState createState() => _AllProvidersPageState();
}

class _AllProvidersPageState extends State<AllProvidersPage> {

  bool isLoading=false;
  bool isLoadingHUD=false;
  List<UserInfoModel> listUser;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();

  Widget dataListView(List<UserInfoModel> data, context) {
    if (data == null)
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  failedOpreation,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );
    else if (data.length > 0)
      return ListView.builder(
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,
          physics: const AlwaysScrollableScrollPhysics(),

          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child:CardServicesProviderV2(
                userInfoModel: data.elementAt(index),

                pressShowProviderPage: (){
                  print("---------------");
                  showServicesProvidersPage(data.elementAt(index));
                },),
            );
          });
    else
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  noData,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );
  }





  void showServicesProvidersPage(UserInfoModel item) async {
    setHUD(true);
    var response=await getSingleUserInfo(id: item.id);
    if(response.statusCode==200){
      UserInfoModel item=response.object;
      openPage(context, TabWithImage(item));
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
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("مقدمو الخدمات"),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoadingHUD,
          child: Background(
            topAlignment: true,
            child: RefreshIndicator(

              key: refreshKey,
              onRefresh: ()async{
                reSetLoading(true);
                var response=await getAllServiceProviders();
                if(response.statusCode==200){
                  List<UserInfoModel> dataList=response.object;

                  setState(() {
                    listUser=dataList;
                  });


                }

                reSetLoading(false);


              },
              child: isLoading?
              SingleChildScrollView(

                  child: Container(height: MediaQuery.of(context).size.height,)

              ):
              dataListView(listUser,context),
            ),
          ),
        ),
      ),
    );
  }
}
