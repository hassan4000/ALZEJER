import 'package:faserholmak/Helper/HassanCountry.dart';
import 'package:faserholmak/Screens/AreYouHurryPage/AreYouHurryPage.dart';
import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/Model/SingleServicesModel/SingleServicesModel.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';

import 'package:faserholmak/Screens/GeneralPageServicesProvider/GeneralPageServicesProvider.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/rateMofaser/RateMofaser.dart';
import 'package:faserholmak/constants.dart';
import 'package:faserholmak/wigets/CardDreams.dart';
import 'package:faserholmak/wigets/CardTimeDreams.dart';

import 'package:faserholmak/wigets/MessageComment.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/wigets/PersonalProfileContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DetailsServiceYouWant extends StatefulWidget {
  AllServicesData servicesData;
  bool forPublicPage=false;

  DetailsServiceYouWant({this.servicesData,this.forPublicPage=false});

  @override
  _DetailsServiceYouWantState createState() => _DetailsServiceYouWantState();
}

class _DetailsServiceYouWantState extends State<DetailsServiceYouWant> {
  SingleServicesModel servicesData;
  GlobalKey<RefreshIndicatorState> refreshKey =
      new GlobalKey<RefreshIndicatorState>();

  bool isLoading = false;
  bool isLoadingHUD = false;
  SetLoading(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  SetLoadingHUD(bool state) {
    setState(() {
      isLoadingHUD = state;
    });
  }

  Widget showCommentSection(context){

    if(isLoading||servicesData==null)
      return Container();
    else if(showCardDreamsInDetails(
        creationID: servicesData.creatorId,
        providerID:
        servicesData.serviceProviderId))
      return dataListComment(servicesData.comments,context) ;
    else return Container();
  }


  Widget dataListComment(List<CommentModel> data, context) {
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
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,


          itemBuilder: (context, index) {
            CommentModel item=data[index];
            return MessageComment(creationDate: item.creationDate,message: emptyString(item.text),
              sendByMe: emptyString(userInfo.id)==item.creatorId,
            name: item.creatorName,);
          });
    else
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Text(
              noComment,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            )),
      );
  }
  bool showComment() {
    return emptyString(widget.servicesData.creatorId) == userInfo.id;
  }

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshKey.currentState.show());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: ()async{
        Navigator.of(context).pop({"info":"hassan"});
       return false;
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoadingHUD,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("تفاصيل صاحب الخدمة"),
          ),
          body: SafeArea(
            child: Background(
              topAlignment: true,
              child: RefreshIndicator(
                key: refreshKey,
                onRefresh: () async {
                  SetLoading(true);
                  var response = await getSingleServicesInfo(
                      id: widget.servicesData.id.toString());
                  if (response.statusCode == 200) {
                    SingleServicesModel item = response.object;
                    setState(() {
                      servicesData = item;
                    });
                  }
                  SetLoading(false);
                },
                child: SingleChildScrollView(
                  child: servicesData != null
                      ? Container(

                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 24,
                              ),

                              /*---------------------TIME STATE------------------------------------*/
                              showStateAndTime(createrID: servicesData.creatorId)?Column(
                              children: <Widget>[
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(state,style: getTextSyle(16, Colors.black),),

                                    ),
                                    Expanded(flex: 5,child: Text(emptyString(stateToArabic(servicesData.status)),style:
                                    getTextSyle(16, kPrimaryColor,fontWeight: FontWeight.w600),textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,),)
                                  ],
                                ),

                                SizedBox(height: 10,),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,

                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        expectedTimeForInterpretation,
                                        style: getTextSyle(16, kPrimaryColor),
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    )
                                  ],
                                ),

                                SizedBox(height: 10,),
                                CardTimeDreams(textAboveLine: emptyString(servicesData.numberOfAllPeopleWaiting.toString()),
                                  textUnderLine: emptyString(servicesData.numberOfRemainingPeople.toString()),
                                  textUnderLineHint: "$youAreHere",
                                  name: emptyString(servicesData.serviceProvider==null?"":servicesData.serviceProvider.name),
                                  price: "",
                                  showDolar: false,),
                              ],
                            ):Container(),
                              SizedBox(
                                height: 20,
                              ),


                            showAreYouHurry(singleServicesModel: servicesData,creationId: servicesData.creatorId) ?
                            MyButton(txt: areYouHurryToExplain,press: (){

                              print(servicesData.toJson().toString());
                              openPage(context, AreYouHarryPage(servicesID: servicesData.id,providerID:
                              servicesData.serviceProviderId));


                              },)


                                :Container(),

                              /*-------------DATA-------------------------------------*/
                              showCardDreamsInDetails(
                                  creationID: servicesData.creatorId,
                                  providerID:
                                  servicesData.serviceProviderId)
                                  ?Column(
                                children: <Widget>[
                                  PersonalProfileContent(
                                      hint: name, text: emptyString(servicesData.name)),
                                  PersonalProfileContent(
                                      hint: gener, text: emptyString(servicesData.sex)),
                                  PersonalProfileContent(
                                      hint: socialStatus,
                                      text: emptyString(servicesData.socialStatus)),
                                  PersonalProfileContent(
                                      hint: country,
                                      text: emptyString(StringToBoolean(
                                          servicesData.isThereWakefulness))),
                                  PersonalProfileContent(
                                      hint: work,
                                      text: emptyString(servicesData.jobStatus)),
                                  PersonalProfileContent(
                                      hint: isThereAnyChild,
                                      text: emptyString(servicesData.kidsStatus)),
                                  PersonalProfileContent(
                                      hint: didYouPrayBeforeDreams,
                                      text: emptyString(StringToBoolean(
                                          servicesData.haveYouPrayedBeforeTheDream))),
                                  PersonalProfileContent(
                                      hint: didYouExorcism,
                                      text: emptyString(StringToBoolean(
                                          servicesData.didYouExorcism))),
                                  PersonalProfileContent(
                                      hint: religiousState,
                                      text: emptyString(servicesData.regligionStatus)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                                  :Container(),

                              /*-----------------------CARD--------------------------------------*/
          /*                    showCardDreamsInDetails(
                                      creationID: widget.servicesData.creatorId,
                                      providerID:
                                          widget.servicesData.serviceProviderId,forPublicPage: widget.forPublicPage)*/
                                   CardDreams(
//                                     showDelete:showDeleteIcon(clinetId: servicesData.creatorId,providerID: servicesData.serviceProviderId) ,
                                   showDelete: false,
                                     showEditText: showEditIcon(clinetId: servicesData.creatorId,providerID: servicesData.serviceProviderId,
                                     explanation: emptyString(servicesData.explanation)),
                                     showLove: servicesData.showLove,
                                      views: emptyString(
                                          servicesData.numberOfViews.toString()),
                                      likes: emptyString(
                                          servicesData.numberOfLikes.toString()),
                                      desc: emptyString(servicesData.description),
                                      showExplanationText: showExplnationText(
                                          explnation: servicesData.explanation),
                                      explantaion:
                                          emptyString(servicesData.explanation),
                                      showComment: showCardDreamsInDetails(
                                          creationID: servicesData.creatorId,
                                          providerID:
                                          servicesData.serviceProviderId),
                                      showExplnationButton: showExplnationButton(
                                        fromPublicPage: widget.forPublicPage,
                                          userType: userInfo.type,
                                          explnation: servicesData.explanation,
                                          servicesProvider:
                                              servicesData.serviceProviderId),
                                      showRating: showRating(createrID: servicesData.creatorId,
                                          explnation: emptyString(servicesData.explanation)),
                                      showToAnotherMofaser: showAnotherMofaser(fromPublicPage: widget.forPublicPage,
                                      servicesProvider: servicesData.serviceProviderId),
                                  /*    lovePress: () async {
                                       setState(() {
                                         servicesData.showLove=true;
                                       });

                                       Response response=await addLike(servicesData.id);

                                       setState(() {
                                         servicesData.showLove=false;
                                         if(response.statusCode==200)
                                           servicesData.numberOfLikes++;
                                       });


                                      },*/
                                      commentPress: () async {
                                      /*  openPage(
                                            context,
                                            CommentPage(
                                              servicesData: widget.servicesData,
                                            ));*/

                                      CommentModel item= await openCommentDialog(context,servicesData.id.toString(),
                                      getSplit(servicesData.clientToken),getSplit(servicesData.serviceProviderToken));
                                      if(item!=null)
                                        setState(() {
                                          servicesData.comments.add(item);
                                        });
                                      },
                                      deletePress: ()async{
                                        bool info=await openDeleteServicesDialog(context, servicesData.id.toString());
                                        if(userInfo.id==servicesData.creatorId&&info!=null&&info){
                                          openPageAndClearPrev(context:context,page: GeneralPageClient(),route: HomePageRoute);
                                        }

                                        else if(userInfo.id==emptyString(servicesData.serviceProviderId)&&info!=null&&info){
                                          openPageAndClearPrev(context:context,page: GeneralPageServicesProvider(),route: HomePageRoute2);

                                        }

                                      },
                                     editTextPress: () async {
                                        if(userInfo.id==servicesData.creatorId){
                                        String desc=await openEditTextCilentDialog(context,servicesData.id.toString(),servicesData.description);
                                        if(desc!=null&&desc.isNotEmpty){
                                          setState(() {
                                            servicesData.description=desc;
                                          });
                                          openPageAndClearPrev(context:context,page: GeneralPageClient(),route: HomePageRoute);

                                        }
                                        }else if(userInfo.id==emptyString(servicesData.serviceProviderId)){
                                          String desc=await openEditExplanationDialog(context,servicesData.id.toString(),servicesData.explanation);
                                          if(desc!=null&&desc.isNotEmpty){
                                            setState(() {
                                              servicesData.description=desc;
                                            });
                                            openPageAndClearPrev(context:context,page: GeneralPageServicesProvider(),route: HomePageRoute2);

                                          }
                                        }
                                     },
                                      explanationPress: () async {
                                        String map = await openAddExplnation(
                                            context,
                                            widget.servicesData.id.toString(),
                                        widget.forPublicPage,
                                        getSplit(servicesData.clientToken));
                                        if (map != null && map.isNotEmpty){
                                          if(widget.forPublicPage){
                                          showToast(successfulAddExplnationForPublic);
                                          openPageAndClearPrev(context:context,page: GeneralPageServicesProvider(),route: HomePageRoute2);
                                          }
                                          else
                                          showToast(successfulAddExplnation);
                                          refreshKey.currentState.show();}
                                      },
                                ratingPress: (){
                                        openPage(context,RateMofaser(servicesData));
                                },
                                     sharePress: () async {
                                       var response=     await FlutterShare.share(
                                           title: 'يرجى مشاركة هذا الرابط ',

                                           text:
                                           '  ${serviceProvider}: ${servicesData.serviceProvider.name}\n ${specalist}: ${servicesData.userWork.name}\n${shareHitn2}\n${userInfo.userSpecialCode}',
                                           linkUrl:
                                           '${linkApp} \n ${googlePlayUrl}',
                                           chooserTitle:
                                           'share');
                                     },

                                toAnotherMofaserPress: () async {
                                  SetLoadingHUD(true);
                                  Response response=await toAnotherMofser(
                                      providerID:userInfo.id,
                                  serviesid: widget.servicesData.id.toString());
                                  SetLoadingHUD(false);
                                  if(response.statusCode==200)
                                    refreshKey.currentState.show();
                                },


                                    ),



                              SizedBox(height: 4,),
                              showCommentSection(context),
                              SizedBox(height: 100,)


                            ],
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
