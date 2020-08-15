import 'package:faserholmak/Dialog/MyShowDialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Model/SingleServicesModel/SingleServicesModel.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';
import 'package:faserholmak/Screens/GeneralPageServicesProvider/GeneralPageServicesProvider.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/Screens/TabWithImage/TabWithImage.dart';
import 'package:faserholmak/components/rounded_button.dart';
import 'package:faserholmak/test.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../constants.dart';
import '../../who.dart';


class RateMofaser extends StatefulWidget {
  SingleServicesModel servicesModel;

  RateMofaser(this.servicesModel);

  @override
  _RateMofaserState createState() => _RateMofaserState();
}

class _RateMofaserState extends State<RateMofaser> {
  bool isSwitched=false;
  double rating=3.0;
  bool isLoading=false;
  TextEditingController textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      title: Text(rateMofaser),),

      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Background(
            child: Container(

              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height: 20,),
                    Container(decoration: BoxDecoration(

                    ),
                      width: 150,
                      height: 150,
                      child: ClipOval(child: Image.network(imageUrl+emptyString(widget.servicesModel.serviceProvider.pictureId))),),
                    SizedBox(height: 20,),

                    Text(whatIsYourRateAboutMrater),
                    SizedBox(height: 20,),
                    RatingBar(
                      itemSize: 40,
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onRatingUpdate: (rate) {

                        setState(() {
                          rating=rate;
                        });

                      },
                    ),
                    Container(
                      width: 250,
                      child: SwitchListTile(
                        value: isSwitched,
                        onChanged: (value){
                         setState(() {
                           isSwitched=!isSwitched;
                         });
                        },
                        activeColor: Colors.yellow,


                        title: Text(honestIntrepreted,style: TextStyle(),textAlign: TextAlign.end,),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(addYourOpinionInMofaser),
                    TextFormField(
                      controller: textEditingController,
                      decoration: getInputDecorationHassan(hint: "",icon: Icon(Icons.description,color: kPrimaryColor,)),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.start,
                      minLines: 3,
                      maxLines: 3,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                    ),

                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(

                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        /*  Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RoundedButton(
                                text: done,
                                color: kPrimaryLightColor,
                                textColor: Colors.black,
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Who();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),*/
                          Expanded(
                            child:MyButton(txt: done,press: () async {


                              setState(() {
                                isLoading=true;
                              });

                              var response=await addRateRQ(txt: textEditingController.text.toString(),
                              id: widget.servicesModel.id.toString(),rate: rating);

                              if(response.statusCode==200){

                                showToast(successfulRating);
                                setState(() {
                                  isLoading=false;
                                });


                                String item= await openShareAfterRate(context,
                                    widget.servicesModel.serviceProvider.name,
                                widget.servicesModel.userWork.name);

                             if(item!=null &&item.isNotEmpty)
                            {
                                if(userInfo.type==clientTxt)
                                openPageAndClearPrev(context: context,route:HomePageRoute,page: GeneralPageClient() );
                                else if(userInfo.type==interpreterTxt)
                                  openPageAndClearPrev(context: context,route:HomePageRoute2,page: GeneralPageServicesProvider() );}
                              }
                              setState(() {
                                isLoading=false;
                              });
                            },)
                          ),
                        ],
                      ),
                    )
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
