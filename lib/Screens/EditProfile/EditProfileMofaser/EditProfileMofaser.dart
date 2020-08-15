import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:faserholmak/Helper/Content.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:faserholmak/Screens/EditWorkTypeForMofaser/EditMofaserAccount.dart';
import 'package:faserholmak/Screens/EditWorkTypeForMofaser/EdtiWorkTypeForMofase.dart';
import 'package:faserholmak/Screens/Login/components/background.dart';
import 'package:faserholmak/constants.dart';
import 'package:flutter/material.dart';

class EditProfileMofaser extends StatefulWidget {
  @override
  _EditProfileMofaserState createState() => _EditProfileMofaserState();
}

class _EditProfileMofaserState extends State<EditProfileMofaser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editProfile,
          style: getTextSyle(16, Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Background(
          topAlignment: true,
          child: SingleChildScrollView(
            child: Column(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  title: Text(
                    editProfile,
                    style: getTextSyle(16, kPrimaryColor),textDirection: TextDirection.rtl,
                  ),
                  onTap: () {
                    openPage(context, EditMofaserAccount());
                  },
                  enabled: true,
                  trailing: Icon(Icons.edit),
                ),
                ListTile(
                  title: Text(
                    addUserWork,
                    style: getTextSyle(16, kPrimaryColor),textDirection: TextDirection.rtl,
                  ),
                  onTap: () {openPage(context, EditWotkTypeForMofase());},
                  enabled: true,
                  trailing: Icon(Icons.edit),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
