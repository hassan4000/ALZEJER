import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Model/AddServices/AddServiceModel.dart';
import 'package:faserholmak/Model/ServicesPathModel.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/PrivetOrPublicService/PrivetOrPublicServicePage.dart';
import 'package:faserholmak/wigets/CardTimeDreams.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class ServicePathList extends StatefulWidget {

  AddServiceModel addServiceModel;

  ServicePathList(this.addServiceModel);

  @override
  _ServicePathListState createState() => _ServicePathListState();
}

class _ServicePathListState extends State<ServicePathList> {
  bool isLoading=false;
  List<ServicesPathModel> listPath;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();

  String getAvg(String txt){
    if(emptyString(txt)=="") return AppLocalizations.of(context).translate("soonTxt");
    else return emptyString(txt);
  }

  Widget dataListView(List<ServicesPathModel> data, context) {
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
    else if (data.length > 0)
      return ListView.builder(
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,
          physics: const AlwaysScrollableScrollPhysics(),

          itemBuilder: (context, index) {
            ServicesPathModel item=listPath[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child:CardTimeDreams(price: item.cost.toString(),
              name: item.name,
              textAboveLine: item.numberOfPeopleWaiting.toString(),
              textUnderLine:getAvg(emptyString(item.avgWaitingTime)) ,
              press: (){

                widget.addServiceModel.servicePathId=item.id;
                widget.addServiceModel.privateServicePrice=item.cost.toString();
                print("hassan"+widget.addServiceModel.toJson().toString());

                openPage(context, PrivetOrPublicServicePage(widget.addServiceModel));
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
                  AppLocalizations.of(context).translate("noData"),
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );
  }


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
    return  SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context).translate("chooseTimeAndPath")),
        ),
        body: Background(
          topAlignment: true,
          child: RefreshIndicator(

            key: refreshKey,
            onRefresh: ()async{
              reSetLoading(true);
              var response=await getServicePath(widget.addServiceModel.serviceProviderId.toString());
              if(response.statusCode==200){
                List<ServicesPathModel> dataList=response.object;

                setState(() {
                  listPath=dataList;
                });


              }

              reSetLoading(false);


            },
            child: isLoading?
            SingleChildScrollView(

                child: Container(height: MediaQuery.of(context).size.height,)

            ):
            dataListView(listPath,context),
          ),
        ),
      ),
    );
  }
}
