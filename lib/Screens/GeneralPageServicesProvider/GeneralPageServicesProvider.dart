import 'dart:io';

import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesModel.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/Model/UserInfoModel/UserWork.dart';
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
import 'package:faserholmak/Screens/compititionMofaser/compitition_mofaser.dart';
import 'package:faserholmak/wigets/CardDreams.dart';
import 'package:faserholmak/wigets/MessageChat.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/wigets/SmallHomeCard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_localizations.dart';
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


  void launchWhatsApp(
      {@required String phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }


  _launchURL({String toMailId, String subject, String body}) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget dataListView(List<AllServicesData> data, context) {
    if (data == null)
      return Container(
        height: 100,
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
              AppLocalizations.of(context).translate("noData"),
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
              AppLocalizations.of(context).translate("failedOpreation"),
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
        title: Text(AppLocalizations.of(context).translate("homePageTxt")),
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


                            (userInfo.verifiedUser==null||userInfo.verifiedUser==false)?
                            Column(
                              children: [
                                Text(AppLocalizations.of(context).translate("youHaveToCallUs"),style: getTextSyle(18, kPrimaryColor),),
                                Row(
                                  children: [
                                    MyButton(txt: AppLocalizations.of(context).translate("callUSOnWhats"),textStyle: getTextSyle(16, Colors.white),press: (){

                                    launchWhatsApp(phone: "+971555661133", message: "hi ");
                                    },raduis: 4,),
                                    SizedBox(width: 4,),
                                    MyButton(txt: AppLocalizations.of(context).translate("callUSOnEmail"),textStyle: getTextSyle(16, Colors.white),press: (){

                                      _launchURL(toMailId: "FSRHILMAK@GMAIL.COM",subject: "رسالة الى الادارة من تطبيق اهل الذكر",
                                          body: "");

                                    },raduis: 4,),
                                  ],
                                ),
                              ],
                            ):Container(),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: AppLocalizations.of(context).translate("completedServices"),press:(){
                                    openPage(context, CompletedServiceServiceProviders());

                                  },),
                                )),

                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: AppLocalizations.of(context).translate("servicesInProgress"),press:(){
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
                                  child: SmallHomeCard(txt: AppLocalizations.of(context).translate("balanceTxt"),press: (){
                                    openPage(context, MofaserBalance());
                                  },),
                                )),
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: AppLocalizations.of(context).translate("publicServices"),press: (){
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
                                  child: SmallHomeCard(txt: AppLocalizations.of(context).translate("chatProviders"),press: (){
                                    openPage(context, ChatForMofaser());
                                  },),
                                )),

                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt:AppLocalizations.of(context).translate("moreInfo"),press: (){
                                    openPage(context, TabWithImageHomePage(userInfo));
                                  },),
                                )),

                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[

                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: AppLocalizations.of(context).translate("comptiotn"),press: (){
                                  //  openPage(context, CompititionMofaser());
                                    showToast(AppLocalizations.of(context).translate("waitUsSoon"));
                                  },),
                                )),
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: AppLocalizations.of(context).translate("servicesIndex"),press: (){
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

                            Row(
                              children: [
                                /*GestureDetector(
                                  onTap: (){


                                    openDialog2GeneralPage(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.assessment,color: kPrimaryColor,size: 30,)
                                    ,
                                  ),
                                ),*/
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: SmallHomeCard(txt: AppLocalizations.of(context).translate("ApplicationStats"),press: (){
                                      openDialog2GeneralPage(context);
                                    },),
                                  ),
                                ),

                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: SmallHomeCard(
                                      txt: AppLocalizations.of(context).translate("tellFriends"),
                                      press: () async {

                                        var hisWork="";
                                        if(userInfo.userWorks!=null &&userInfo.userWorks.isNotEmpty){

                                          for(var x in userInfo.userWorks){
                                           hisWork+=emptyString(x.userWork.name);
                                           hisWork+="-";
                                          }
                                        }

                                        await FlutterShare.share(
                                            title: AppLocalizations.of(context).translate("pleaseShareThisLink"),

                                            text:
                                            '  ${AppLocalizations.of(context).translate("serviceProvider")}: ${emptyString(userInfo.name)}\n ${AppLocalizations.of(context).translate("specalist")}: ${hisWork}\n${AppLocalizations.of(context).translate("shareHitn2")}0610',
                                            linkUrl:
                                            '${AppLocalizations.of(context).translate("linkApp")} \n ${googlePlayUrl}',
                                            chooserTitle:
                                            'share');


                                     /* await FlutterShare.share(
                                    title:
                                    '${AppLocalizations.of(context).translate("pleaseShareThisLink")}',
                                    text:
                                    '${AppLocalizations.of(context).translate("shareHitn1")}\n 0610',
                                    linkUrl:
                                    '${AppLocalizations.of(context).translate("linkApp")} \n  ${googlePlayUrl}',
                                    chooserTitle: 'Share');*/
                                    },),
                                  ),
                                ),
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
