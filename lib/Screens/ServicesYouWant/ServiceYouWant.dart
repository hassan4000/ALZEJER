import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Model/WorkTypeUser/Value.dart';
import 'package:faserholmak/Model/WorkTypeUser/WorkTypeModel.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/ServiceProviders/ServiceProviders.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ServiceYouWant extends StatefulWidget {
  @override
  _ServiceYouWantState createState() => _ServiceYouWantState();
}

class _ServiceYouWantState extends State<ServiceYouWant> {

  bool isLoading=false;
  List<Value> listViewItem;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();

  Widget dataListView(List<Value> data, context) {
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
              child: MyButton(txt: data[index].adjectiveName.toString(),raduis: 10,
                borderColor: Colors.transparent,
                press: (){
                Value item=data.elementAt(index);

                openPage(context, ServiceProviders(selectedService: item,));

                }
                ,),
            );
          });
    else
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  'No DATA ',
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
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(whatIsServicesYouWant_v2),
        ),
        body: Background(
          topAlignment: true,
          child: RefreshIndicator(

            key: refreshKey,
            onRefresh: ()async{
              reSetLoading(true);
              var response=await getWorkTypeRQ();
              if(response.statusCode==200){
                WorkTypeModel workTypeModel=response.object;

                setState(() {
                  listViewItem=workTypeModel.value;

                });


              }

              reSetLoading(false);


            },
            child: isLoading?
            SingleChildScrollView(

                child: Container(height: MediaQuery.of(context).size.height,)

            ):
            dataListView(listViewItem,context),
          ),
        ),
      ),
    );
  }
}
