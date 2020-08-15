

import 'dart:ffi';

import 'package:country_pickers/country.dart';
import 'package:faserholmak/Dialog/AddExplnation/AddExplnationDialog.dart';
import 'package:faserholmak/Dialog/Dialog1GeneralPage/Dialog1GeneralPage.dart';
import 'package:faserholmak/Dialog/DialogCode/MyCountryPickerDialog.dart';
import 'package:faserholmak/Dialog/PayByPointDialog/PayByPointDialog.dart';
import 'package:faserholmak/Dialog/WaitDilaog/WaitDialog.dart';
import 'package:faserholmak/Dialog/shareDialig/ShareAfterRateDaialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/Model/SingleServicesModel/SingleServicesModel.dart';
import 'package:flutter/material.dart';

import 'AddCommentDialog/AddCommentDialog.dart';
import 'Dialog2GeneralPage/Dialog2GeneralPage.dart';

Future<Country> openCountryDialog(BuildContext context,{String search,String selectedHint,ValueChanged<Country> onValuePicked}) async {
  return showDialog<Country>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return MyCountryPickerDialog(searchHint: search,selectHint: selectedHint,onValuePicked: onValuePicked,);
    },
  );
}


Future<void> openDialog1GeneralPage(BuildContext context) async {
  return showDialog<Country>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return Dialog1GeneralPage();
    },
  );
}

Future<void> openDialog2GeneralPage(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return Dialog2GeneralPage();
    },
  );
}

Future<String> openAddExplnation(BuildContext context,String id,bool fromPublicPage,String clinetToken) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AddExplnationDialog(servicesID: id,fromPublicPage: fromPublicPage,clientToken: clinetToken,);
    },
  );
}


Future<String> openShareAfterRate(BuildContext context,String name,String userWokrname) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return ShareAfterDialog(name,userWokrname);
    },
  );
}
Future<CommentModel> openCommentDialog(BuildContext context,String serivesID,String clientToken,String providerToken) async {
  return showDialog<CommentModel>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AddCommentDialog(serivesID,clientToken,providerToken);
    },
  );
}


Future<Response> openPayByPointDialog(BuildContext context,SingleServicesModel servicesModel) async {
  return showDialog<Response>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return PayByPointDialog(servicesModel: servicesModel);
    },
  );
}


  Future<Response> openLogout(BuildContext context,) async {
    return showDialog<Response>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return WaitDialog();
      },
    );}

