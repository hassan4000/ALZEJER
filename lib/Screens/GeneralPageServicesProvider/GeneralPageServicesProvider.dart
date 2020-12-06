import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesModel.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/Screens/ChatsForMofaser/ChatForMofaser.dart';
import 'package:faserholmak/Screens/DetailsServiceYouWant/DetailsServiceYouWant.dart';
import 'package:faserholmak/Screens/Drawer/MyDrawerServiceProviders.dart';
import 'package:faserholmak/Screens/MofaserBalance/MofaserBalance.dart';
import 'package:faserholmak/Screens/ServicesForServiceProviders/CompletedServiceServiceProviders/CompletedServiceServiceProviders.dart';
import 'package:faserholmak/Screens/ServicesForServiceProviders/OnProgressServiceServiceProviders/OnProgressServiceServiceProviders.dart';
import 'package:faserholmak/Screens/ServicesForServiceProviders/PublicServiceServiceProviders/PublicServiceServiceProviders.dart';
import 'package:faserholmak/Screens/ServicesIndex/ServicesIndexPage.dart';
import 'package:faserholmak/Screens/ServicesYouWant/ServiceYouWant.dart';
import 'package:faserholmak/Screens/TabWithImage/TabWithImageHomePage.dart';
import 'package:faserholmak/wigets/CardDreams.dart';
import 'package:faserholmak/wigets/MessageChat.dart';
import 'package:faserholmak/wigets/SmallHomeCard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:faserholmak/Helper/AppApi.dart';

import '../../constants.dart';

class GeneralPageServicesProvider extends StatefulWidget {
  @override
  _GeneralPageServicesProviderState createState() => _GeneralPageServicesProviderState();
}

class _GeneralPageServicesProviderState extends State<GeneralPageServicesProvider> {

  bool isLoading=false;

  List<AllServicesData> listServicesData;
  AllServicesData firstServicesData;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();

  void reSetLoading(bool state){
    setState(() {
      isLoading=state;
    });
  }


  Widget dataListView(List<AllServicesData> data, context) {
    if (data == null)
      return Container(
        height: 100,
        child: Center(
            child: Text(
              failedOpreation,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
    else if (data.length > 0)
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 1,
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            AllServicesData item=listServicesData[index];
            return CardDreams(showLove: item.showLove,desc: item.description,likes: item.numberOfLikes,views: item.numberOfViews,
              lovePress: () async {
                setState(() {
                  item.showLove=true;
                });

                Response response=await addLike(item.id);

                setState(() {
                  item.showLove=false;
                  if(response.statusCode==200 ){
                    if(item.numberOfLikes!=null){
                      int num=   int.parse(item.numberOfLikes);
                      num++;
                      item.numberOfLikes=num.toString();
                    }
                    else{
                      item.numberOfLikes="1";
                    }

                  }

                });


              },
            press: () async {
              Map map=await openMapPage(context, DetailsServiceYouWant(servicesData: item,));
              if(map!=null)
                refreshKey.currentState.show();
            },);
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

  Widget showCommentSection(context){
    if(isLoading|| firstServicesData==null)
      return Container();

    else if(showCardDreamsInDetails(
        creationID: firstServicesData.creatorId,
        providerID:
        firstServicesData.serviceProviderId)) return dataListComment(listServicesData,context);

    else return Container();
  }


  Widget dataListComment(List<AllServicesData> data, context) {
    if (data == null)
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Text(
              failedOpreation,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
    else if (data.length > 0)
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data[0].commentList.length,
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            CommentModel item=data[0].commentList[index];
            return MessageChat(message: emptyString(item.text),sendByMe: emptyString(userInfo.id)==item.creatorId,);
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshKey.currentState.show());

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessageFIRE: $message");

      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunchFIRE: $message");

      },
      onResume: (Map<String, dynamic> message) async {
        print("onResumeFIRE: $message");

      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      fireBASETOKEN=token;
      await addFirebaseToken(fireToken: token,userID: userInfo.id);
      print('FIREBASETOKEN  $token');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerServicsProvider(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("صفحة العامة"),
      ),
      body: SafeArea(
        top:true,
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: ()async{
            reSetLoading(true);
            var response=await getAllServiceForProvider(filterUserID: userInfo.id);
            if(response.statusCode==200){
              AllServicesModel item=response.object;
              setState(() {
                listServicesData=item.value;
              });


            }
            reSetLoading(false);

          },

          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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
                                  child: SmallHomeCard(txt: completedServices,press:(){
                                    openPage(context, CompletedServiceServiceProviders());

                                  },),
                                )),

                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: servicesInProgress,press:(){
                                    openPage(context, OnProgressServiceServiceProviders());
                                  },),
                                )),

                              ],
                            ),
                            SizedBox(height: 0,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: balanceTxt,press: (){
                                    openPage(context, MofaserBalance());
                                  },),
                                )),
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: publicServices,press: (){
                                    openPage(context, PublicServiceServiceProviders());
                                  },),
                                )),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: chatProviders,press: (){
                                    openPage(context, ChatForMofaser());
                                  },),
                                )),

                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt:moreInfo,press: (){
                                    openPage(context, TabWithImageHomePage(userInfo));
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

                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: servicesIndex,press: (){
                                    openPage(context, ServicesIndexPage());
                                  },),
                                )),
                              /*  Expanded(child: GestureDetector(
                                  onTap: (){

                                    openDialog1GeneralPage(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.people,color: kPrimaryColor,size: 30,)
                                    ,
                                  ),
                                )),*/
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),


                    isLoading?Container():dataListView(listServicesData,context),
                    showCommentSection(context),
                    SizedBox(height: 150,),



                  ],
                ),
              ),
            ),
          ),
        )

        ),

    );
  }
}
