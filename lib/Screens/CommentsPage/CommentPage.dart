import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/Screens/ServicesForServiceProviders/CompletedServiceServiceProviders/CompletedServiceServiceProviders.dart';
import 'package:faserholmak/Screens/ServicesForServiceProviders/OnProgressServiceServiceProviders/OnProgressServiceServiceProviders.dart';
import 'package:faserholmak/wigets/MessageTitle.dart';
import 'package:faserholmak/wigets/SmallHomeCard.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../constants.dart';

class CommentPage extends StatefulWidget {
  AllServicesData servicesData;

  CommentPage({this.servicesData});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  bool isLoading=false;
  TextEditingController controller=TextEditingController();
  ScrollController scrollController=ScrollController();
  List<CommentModel> listComment=List();



  bool sentByMeFun(CommentModel item){
    return emptyString(item.creatorId)==emptyString(userInfo.id);
  }
  Widget dataListView(List<CommentModel> data, context) {
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

          controller: scrollController,
          itemBuilder: (context, index) {
            CommentModel item=data[index];
            return MessageTitle(commentModel: data.elementAt(index),sendByMe: sentByMeFun(item),);
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

  void setIsLodaing(bool state){
    setState(() {
      isLoading=state;
    });
  }

  Map<String,dynamic> initMap(){
    Map<String,dynamic> data={
      "Text":controller.text.toString().trim(),
      "ServiceId":"${widget.servicesData.id}",
    };

    return data;
  }


  void sendComment() async {
    if(controller.text.toString().trim().isNotEmpty){
      setIsLodaing(true);

      var response=await AddCommentRQ(initMap());
      if(response.statusCode==200){
        controller.text="";
        CommentModel item=response.object;
        setState(() {
          listComment.add(item);
        });

        if(listComment.length>4)
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
      setIsLodaing(false);

    }
  }
  void getAllComment() async {
    setIsLodaing(true);

    token=await getToken();
    var response=await getCommentByID(serviceID: widget.servicesData.id);
    if(response.statusCode==200){
      List<CommentModel> item=response.object;
      setState(() {
        listComment=item;
      });
    }

    setIsLodaing(false);
  }

  @override
  void initState() {
    if(mounted)
    getAllComment();


    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("تعليقات"),
      ),

      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                   child: dataListView(listComment,context)
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
                            sendComment();
                          },
                        ),
                      ),
                      Expanded(
                        flex:4,
                        child: TextFormField(
                          controller: controller,
                          textDirection: TextDirection.rtl,
                          minLines: 1,
                          maxLines: 2,

                          decoration: getInputDecorationChat(hint: "ارسال تعليق",
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



