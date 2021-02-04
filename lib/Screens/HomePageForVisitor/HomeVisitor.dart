import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/GeneralPage/GeneralPageClient.dart';

import 'package:faserholmak/Screens/HisVision/HisVisionPage.dart';
import 'package:faserholmak/wigets/CardDreams.dart';
import 'package:faserholmak/wigets/CardTimeDreams.dart';
import 'package:faserholmak/wigets/MyButton.dart';
import 'package:faserholmak/wigets/SmallHomeCard.dart';
import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class HomeVisitor extends StatefulWidget {
  @override
  _HomeVisitorState createState() => _HomeVisitorState();
}

class _HomeVisitorState extends State<HomeVisitor> {

  void openPage(){

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GeneralPageClient();
        },
      ),
    );

  }

  void openPage2(){

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HisVisionPage();
        },
      ),
    );

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("صفحة الزائر"),
      ),
      body: SafeArea(
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
                                child: SmallHomeCard(txt: dreamsiInterpreted,press: openPage,),
                              )),
                              Expanded(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SmallHomeCard(txt: interpreters,press: openPage,),
                              )),
                            ],
                          ),
                          SizedBox(height: 0,),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SmallHomeCard(txt: users,press: openPage,),
                              )),
                              Expanded(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SmallHomeCard(txt: chatForPeople,press: openPage,),
                              )),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                 MyButton(txt: AppLocalizations.of(context).translate("areYouHurryToExplain"),press: openPage2,),
                  CardDreams(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
