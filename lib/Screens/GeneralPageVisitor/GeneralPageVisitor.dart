import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesModel.dart';
import 'package:faserholmak/Screens/ChatForPublic/ChatForPublic.dart';
import 'package:faserholmak/Screens/DetailsServiceYouWant/DetailsServiceYouWant.dart';
import 'package:faserholmak/Screens/Drawer/MyDrawer.dart';
import 'package:faserholmak/Screens/Drawer/MyDrawerVistor.dart';
import 'package:faserholmak/Screens/Login/login_screen.dart';
import 'package:faserholmak/Screens/SelectUserType/SelectUserType.dart';
import 'package:faserholmak/Screens/ServicesIndex/ServicesIndexPage.dart';
import 'package:faserholmak/Screens/ServicesYouWant/ServiceYouWant.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/CardDreams.dart';
import 'package:faserholmak/wigets/CardTimeDreams.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/wigets/SmallHomeCard.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';


class GeneralPageVisitor extends StatefulWidget {


  @override
  _GeneralPageVisitorState createState() => _GeneralPageVisitorState();
}

class _GeneralPageVisitorState extends State<GeneralPageVisitor> {

  bool isLoading=false;
  List<AllServicesData> listServicesData;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();

  void reSetLoading(bool state){
    setState(() {
      isLoading=state;
    });
  }


  Widget dataListView(List<AllServicesData> data, context) {
    if (data == null)
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Text(
              AppLocalizations.of(context).translate("failedOpreation"),
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
    else if (data.length > 0)
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            AllServicesData item=listServicesData[index];
            return CardDreams(desc: item.description,likes: item.numberOfLikes,views: item.numberOfViews,showComment: false,
                press: (){ openPage(context, DetailsServiceYouWant(servicesData: item,));});
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
        drawer: MyDrawerVistor(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context).translate("homePageTxt")),
        ),
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: ()async{
            reSetLoading(true);
            var response=await getAllServiceVisitor();
            if(response.statusCode==200){
              AllServicesModel item=response.object;
              setState(() {
                listServicesData=item.value;
              });


            }
            reSetLoading(false);

          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt:  AppLocalizations.of(context).translate("whatIsServicesYouWant"),press:(){
                                 showToast(youHaveToLogin);
                                 openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page:  LoginScreen());
                                  },),
                                )),

                                GestureDetector(
                                  onTap: (){
                                    showToast(youHaveToLogin);
                                    openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page:  LoginScreen());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.add_box,color:kPrimaryColor,size: 30,),
                                  ),
                                )

                              ],
                            ),
                            SizedBox(height: 0,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt:  AppLocalizations.of(context).translate("chatForPeople"),press: (){
                                    openPage(context, ChatForPublic());
                                  },),
                                )),
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt:  AppLocalizations.of(context).translate("servicesIndex"),press: (){
                                    openPage(context, ServicesIndexPage());
                                  },),
                                )),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(child: GestureDetector(
                                  onTap: (){

                                    openDialog2GeneralPage(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.assessment,color: kPrimaryColor,size: 30,)
                                    ,
                                  ),
                                )),
                                Expanded(child: GestureDetector(
                                  onTap: (){

                                    openDialog1GeneralPage(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.people,color: kPrimaryColor,size: 30,)
                                    ,
                                  ),
                                )),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    MyButton(txt:  AppLocalizations.of(context).translate("doYouWantServiceLogin"),press: (){
                      openPageAndClearPrev(context: context,route: SelectUserTypeRoute,page:  LoginScreen());
                    },),
                    isLoading?Container():dataListView(listServicesData,context)



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