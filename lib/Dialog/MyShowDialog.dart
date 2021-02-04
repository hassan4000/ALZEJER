

import 'dart:ffi';

import 'package:country_pickers/country.dart';
import 'package:faserholmak/Dialog/AddExplnation/AddExplnationDialog.dart';
import 'package:faserholmak/Dialog/Dialog1GeneralPage/Dialog1GeneralPage.dart';
import 'package:faserholmak/Dialog/EditText/EditTextDialog.dart';
import 'package:faserholmak/Dialog/DialogCode/MyCountryPickerDialog.dart';
import 'package:faserholmak/Dialog/PayByPointDialog/PayByPointDialog.dart';
import 'package:faserholmak/Dialog/WaitDilaog/WaitDialog.dart';
import 'package:faserholmak/Dialog/shareDialig/ShareAfterRateDaialog.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/Model/SingleServicesModel/SingleServicesModel.dart';
import 'package:flutter/material.dart';

import 'AddCommentDialog/AddCommentDialog.dart';
import 'shareRateDialog/ShareRateAppDialog.dart';
import 'Dialog2GeneralPage/Dialog2GeneralPage.dart';
import 'EditExplanationDialog/EditExplanationDialog.dart';
import 'deleteDialog/DeleteDialog.dart';

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

Future<String> openAddExplnation(BuildContext context,String id,bool fromPublicPage,List<String>  clinetToken) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AddExplnationDialog(servicesID: id,fromPublicPage: fromPublicPage,clientToken: clinetToken,);
    },
  );
}


/*when you add services*/
Future<void> openShareAndRateApp(BuildContext context) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return ShareRateAppDialog();
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
Future<CommentModel> openCommentDialog(BuildContext context,String serivesID,List<String>  clientToken,List<String> providerToken) async {
  return showDialog<CommentModel>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AddCommentDialog(serivesID,clientToken,providerToken);
    },
  );
}


Future<String> openEditTextCilentDialog(BuildContext context,String serivesID,String text) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return EditTextDialog(serivesID,text);
    },
  );
}

Future<bool> openDeleteServicesDialog(BuildContext context,String serivesID,{String text}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return DeleteServiceDialog(serivesID);
    },
  );
}

Future<String> openEditExplanationDialog(BuildContext context,String serivesID,String text) async {
  return showDialog<String>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return EditExplanationDialog(serivesID,text);
    },
  );
}


Future<Response> openPayByPointDialog(BuildContext context,SingleServicesModel servicesModel,int  amount) async {
  return showDialog<Response>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return PayByPointDialog(servicesModel: servicesModel,amount: amount,);
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

