import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesModel.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/Model/SingleServicesModel/SingleServicesModel.dart';
import 'package:faserholmak/Model/UserWorkWithNumber/UserWorkWithNumber.dart';
import 'package:faserholmak/Screens/AreYouHurryPage/AreYouHurryPage.dart';
import 'package:faserholmak/Screens/ChatForPublic/ChatForPublic.dart';
import 'package:faserholmak/Screens/DetailsServiceYouWant/DetailsServiceYouWant.dart';
import 'package:faserholmak/Screens/Drawer/MyDrawer.dart';
import 'package:faserholmak/Screens/ServiceProviders/ServiceProviders.dart';
import 'package:faserholmak/Screens/ServicesIndex/ServicesIndexPage.dart';
import 'package:faserholmak/Screens/ServicesYouWant/ServiceYouWant.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/CardDreams.dart';
import 'package:faserholmak/wigets/CardTimeDreams.dart';
import 'package:faserholmak/wigets/MessageChat.dart';
import 'package:faserholmak/wigets/MessageComment.dart';
import 'package:faserholmak/wigets/MessageTitle.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/wigets/MyButtonWithNumber.dart';
import 'package:faserholmak/wigets/SmallHomeCard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert' as JSON;


class GeneralPageClient extends StatefulWidget {


  @override
  _GeneralPageClientState createState() => _GeneralPageClientState();
}

class _GeneralPageClientState extends State<GeneralPageClient> {

  bool isLoading=false;
  Map userProfile;
  bool isLoadingTime=false;
  List<AllServicesData> listServicesData;

  List<UserWorkWithNumber> listUserWork;
  AllServicesData firstServicesData;
  SingleServicesModel singleServicesModel;
  GlobalKey<RefreshIndicatorState> refreshKey=new GlobalKey<RefreshIndicatorState>();


  String getAvg(String txt){
    if(emptyString(txt)=="") return "سوف يتم التفسير قريبا";
    else return emptyString(txt);
  }

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
            return CardDreams(desc: item.description,likes: item.numberOfLikes,views: item.numberOfViews,
            press: (){ openPage(context, DetailsServiceYouWant(servicesData: item,));},);
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

  Widget showAreYouHurry(context){
    if(isLoading|| firstServicesData==null)
      return Container();

    else return MyButton(txt: areYouHurryToExplain,press: () async {
     // _loginWithFB();

      print(firstServicesData.toJson().toString());
      openPage(context,
          AreYouHarryPage(servicesID: firstServicesData.id,providerID:
          firstServicesData.serviceProviderId.toString(),));

/*    Map map= await  openMapPage(context, DetailsServiceYouWant(servicesData: firstServicesData,));
    if(map!=null)
    refreshKey.currentState.show();*/
    },);
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


  Widget showCardTime(context){


    if(isLoading|| singleServicesModel==null)
      return Container();

    else  return Column(
      children: <Widget>[
        Text("$expectedTimeForInterpretation  ",style: getTextSyle(16, kPrimaryColor),textAlign: TextAlign.center,),
        Text("  ${getAvg(singleServicesModel.avgWaitingTime)} ",style: getTextSyle(16, kPrimaryColor),textAlign: TextAlign.center,),

        CardTimeDreams(showDolar: false,name: emptyString(singleServicesModel.serviceProvider.name),
        price: "",textUnderLineHint:youAreHere,
          textUnderLine: emptyString(singleServicesModel.numberOfRemainingPeople.toString()),
        textAboveLine: emptyString(singleServicesModel.numberOfAllPeopleWaiting.toString()),),
      ],
    );


  }

  Widget dataListComment(List<AllServicesData> data, context) {
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
          itemCount: data[0].commentList.length,
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            CommentModel item=data[0].commentList[index];
            return MessageComment(creationDate:emptyString(item.creationDate)
              ,message: emptyString(item.text),
              sendByMe: emptyString(userInfo.id)==item.creatorId,
            name: item.creatorName,);
          });
    else
      return Container(
        height: 60,
        child: Center(
            child: Text(
              noData,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
  }



  Widget dataListUserWork(List<UserWorkWithNumber> data, context) {
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
      return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          padding: EdgeInsets.symmetric(horizontal: 4),

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 6,
            childAspectRatio: (MediaQuery.of(context).size.width)/(MediaQuery.of(context).size.height/7)
          ),
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            UserWorkWithNumber item=data[index];
            return MyButtonWithNumber(txt: emptyString(item.userWork.name),
            number: item.userCount,raduis: 6,textStyle: getTextSyle(14, Colors.white),
            press: (){
              openPage(context, ServiceProviders(selectedService: item.userWork,));
            },);
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

  Future<void> getSingleServices() async {
    if(firstServicesData!=null){
      var response = await getSingleServicesInfo(
          id: firstServicesData.id.toString());

      if(response.statusCode==200){
       setState(() {
         singleServicesModel=response.object;
       });
      }



    }
  }









  _loginWithFB() async {
    try {
      final result = await facebookLogin.logIn(['email']);

      print(result.errorMessage);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final token = result.accessToken.token;
          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,picture.width(600).height(600),email&access_token=${token}');

          final profile = JSON.jsonDecode(graphResponse.body);


          userProfile = profile;
          print("--------------------------");
          print(userProfile);
          print("--------------------------");
          print(profile);

          String id = profile['id'];
          print(id);
          String email = profile['email'];
          print(email);
          String name = profile['name'];
          print(name);
          String imagePath = profile['picture']['data']['url'];
          print(imagePath);

          if (email == null) {
            email = id + '@gmail.com';
          }

       /*   setState(() {
            _isLoading = true;
          });*/
       //   Response res = await doSocialLogin(name, email, imagePath, 'facebook', id);

      /*    setState(() {
            _isLoading = false;
          });*/

/*
          if(res.statusCode == 200){
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/HomePage',
                    (Route<dynamic> route) => false);
          } else if(res.statusCode==420){
            alertV2(context, 'Alert',
                'Dear Customer, your account is in-active, kindly contact TrussT @ the following email to re-activate cs@trusstcommunity.com ');

          } else if(res.statusCode == 500){
            showToast('This account has been taken before');
          }
          else{
            showToast('Some thing error, please try again!');
          }*/


          break;

        case FacebookLoginStatus.cancelledByUser:
        /*  showMessage(context,
              'You can access TrussT by login with FB or by create new account');*/
          break;
        case FacebookLoginStatus.error:
          showToast( 'Some thing error, please try again');
          break;
      }
    } catch (exceptopn) {

      print('error');
    /*  setState(() {
        _isLoading = false;
      });*/

      showToast('Some thing error, please try again');
    }
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
    return SafeArea(
      top: true,

      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text("صفحة العميل "),
        ),
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: ()async{
            reSetLoading(true);


            getUserWorkWithNumber().then((response){

              if(response.statusCode==200)
                setState(() {
                  listUserWork=response.object;
                });
            });

            var response=await getAllServiceClient(filterUserID: userInfo.id);
            if(response.statusCode==200){
              AllServicesModel item=response.object;
              setState(() {
                listServicesData=item.value;
                if(item.value!=null &&item.value.isNotEmpty){
                  firstServicesData=item.value[0];
                }

              });
            }

            await getSingleServices();

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
                    ListTile(
                      title: Text(pointDesc,style: getTextSyle(16, Colors.black),textDirection: TextDirection.rtl,),
                      selected: true,
                      subtitle:   Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: Text("رصيدك من النقاط ${userInfo.pointsBalance.toString()}"
                            ,style: getTextSyle(16, Colors.grey),
                            textDirection: TextDirection.rtl,textAlign: TextAlign.center,)),
                        ],
                      ),
                      trailing: Icon(Icons.group_add),
                      enabled: true,
                      onTap: () async {
                        await FlutterShare.share(
                            title: 'يرجى مشاركة هذا الرابط ',

                            text:
                            '${shareHitn1}\n ${userInfo.userSpecialCode}',
                            linkUrl:
                            ' {$linkApp} \n  ${googlePlayUrl}',
                            chooserTitle:
                            'Share');
                      },

                    ),

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
                              textDirection: TextDirection.rtl,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: logoText,press:(){
                                    openPage(context, ServiceYouWant());
                                  },),
                                )),

                                GestureDetector(
                                  onTap: (){
                                    openPage(context, ServiceYouWant());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.add_box,color:kPrimaryColor,size: 30,),
                                  ),
                                )

                              ],
                            ),


                            listUserWork!=null?dataListUserWork(listUserWork,context):Container(),

                            SizedBox(height: 0,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: chatForPeople,press: (){
                                    openPage(context, ChatForPublic());
                                  },),
                                )),
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SmallHomeCard(txt: servicesIndex,press: (){
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
                    showCardTime(context),
                    SizedBox(height: 10,),

                    showAreYouHurry(context),

              /*     MyButton(txt: areYouHurryToExplain,press: () async {


              *//*       print("hiii");
                     await googleSignIn.signIn().then((onValue){
                       print(onValue.email);
                     });*//*

               *//*      signInWithGoogle().whenComplete((){

                     });*//*
                   },)*/
                    isLoading?Container():dataListView(listServicesData,context),
                    showCommentSection(context),

                    SizedBox(height: 100,),



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
