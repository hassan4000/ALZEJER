import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/DatabaseMethods.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';
import 'package:faserholmak/wigets/MessageChat.dart';
import 'package:faserholmak/wigets/MessageTitle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../app_localizations.dart';
import '../../constants.dart';

class ChatForPublic extends StatefulWidget {


  @override
  _ChatForPublicState createState() => _ChatForPublicState();
}

class _ChatForPublicState extends State<ChatForPublic> {

  bool isLoading=true;
  Stream<QuerySnapshot> chats;
  TextEditingController controller=TextEditingController();
  ScrollController scrollController=ScrollController();


  void setIsLodaing(bool state){
    setState(() {
      isLoading=state;
    });
  }


  Widget chatMessages(){

    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
          controller: scrollController,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return MessageChat(
                message: snapshot.data.documents[index]["Message"],
                sendByMe:emptyString(userInfo.name) == snapshot.data.documents[index]["SendBy"],
                name: snapshot.data.documents[index]["SendBy"],
              );
            }) : Container(height: MediaQuery.of(context).size.height,
        child: Text(AppLocalizations.of(context).translate("ThereAreNoMessages")),);
      },
    );
  }

  addMessage() async {
    if (controller.text.isNotEmpty) {

      await addMessageFirebase( initMap());

      setState(() {
        controller.text = "";
      });

      Timer(
        Duration(milliseconds:1500),
            () =>   scrollController.animateTo(scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300), curve: Curves.easeOut),
      );


      ;
    }
  }

  Map<String,dynamic> initMap(){
    Map<String,dynamic> data={
      "Message":controller.text.toString().trim(),
      "SendBy":"${userInfo.name}",
      "Time":"${DateTime.now().millisecondsSinceEpoch}",
    };

    return data;
  }

  @override
  void initState() async {
    super.initState();
    if(mounted){
      await Firebase.initializeApp();
      getChats().then((val) {
        setState(() {
          chats = val;
          isLoading=false;
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("chatForPeople")),
      ),

      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                    child: chatMessages()
                ),

                emptyString(token).isNotEmpty?
                Container(
                  height: size.height*0.1,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.send,color: kPrimaryColor,),
                          onPressed: (){
                            addMessage();
                          },
                        ),
                      ),
                      Expanded(
                        flex:4,
                        child: TextFormField(
                          controller: controller,
                       //   textDirection: TextDirection.rtl,
                          minLines: 1,
                          maxLines: 2,

                          decoration: getInputDecorationChat(hint: AppLocalizations.of(context).translate("sendTxt"),
                          ),

                        ),
                      ),
                    ],
                  ),
                ):Container()



              ],
            ),
          ),
        ),
      ),
    );
  }
}
