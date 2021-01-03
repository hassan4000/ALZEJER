


import 'dart:io';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Model/SingleServicesModel/SingleServicesModel.dart';
import 'package:faserholmak/Model/UserInfoModel/UserInfoModel.dart';
import 'package:faserholmak/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_localizations.dart';
import 'Content.dart';



final facebookLogin = FacebookLogin();

Future<bool> logOutFacebook() async {
  try {
    await facebookLogin.logOut();
    return true;
  } catch (error) {
    print(error);
    return false;
  }
}







final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

//final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn1 = GoogleSignIn();
//Future<String> signInWithGoogle() async {
//
//
//  final GoogleSignInAccount googleSignInAccount = await googleSignIn1.signIn();
//  final GoogleSignInAuthentication googleSignInAuthentication =
//  await googleSignInAccount.authentication;

/*  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );*/

  //final AuthResult authResult = await _auth.signInWithCredential(credential);
  //final FirebaseUser user = authResult.user;


//  print("id ${user.uid}");
//  assert(!user.isAnonymous);
//  assert(await user.getIdToken() != null);

//  final FirebaseUser currentUser = await _auth.currentUser();
//  assert(user.uid == currentUser.uid);

//  return  'signInWithGoogle succeeded: $user';
//}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}
String tokenValue;
UserInfoModel userInfo;
String fireBASETOKEN="";



List<String> getSplit(String txt){
/*  if(txt==null ||txt.isEmpty) return List();
  else {
    var x=txt.split(";");
    int size=x.length;

    if(size==0) return x[0];
    else return x[x.length-1];

  }
  return List();*/



  if(txt==null ||txt.isEmpty) return List();
  else {
    List<String> x=txt.split(";");
    int size=x.length;

    return x;

  }
  return List();
}

Future<String> getPassword() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("USER_PASSWORD");
}

void setPassword(String password) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("USER_PASSWORD", password);
}


Future<String> getEmail() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("USER_EMAIL");
}

void setEmail(String data) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("USER_EMAIL", data);
}

Future<String> getToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("USER_TOKEN");
}

String getZeroWithNumber(int num){
  if(num<10) return"0$num";
  else return num.toString();
}


bool canLikeServies(String id,String idProvider,String idClient){
  if(id=="" ||id=="null"||id==idProvider||id==idClient) return false;
  else return true;
}
void setToken(String data) async {
  tokenValue=data;
  token=data;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("USER_TOKEN", data);
}









 bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}


String emptyString(String txt){
  if(txt==null) return"";
  return txt;
}

String StringToBoolean(bool txt,BuildContext context){
 if(txt==null ||!txt)  return AppLocalizations.of(context).translate("no");
 else return AppLocalizations.of(context).translate("yes");
}



 String userWorkLanguage({int id,String lang,String name}){

  if(lang=="en"){

    if(id==26) return"Interpreter of dreams";
    if(id==27) return"Legit classy";
    if(id==28) return "Legal Mufti";
    if(id==29) return "Family Counselor";
    if(id==36) return "Medical advisor";
    if(id==37) return "Counsel";
  }
  return name;
 }


 Widget userWorkIcon({int id}){

  var width=24.0;
  var height=24.0;

    if(id==26) return Image.asset('assets/images/ahlam.png',width: width,height: height,color: Colors.white,);
    if(id==27) return Image.asset('assets/images/raki.png',width: width,height: height,color: Colors.white,);
    if(id==28) return Image.asset('assets/images/mofte.png',width: width,height: height,color: Colors.white,);
    if(id==29) return  Image.asset('assets/images/famely.png',width: width,height: height,color: Colors.white,);
    if(id==36) return Image.asset('assets/images/doctor.png',width: width,height: height,color: Colors.white,);
    if(id==37) return Image.asset('assets/images/legal.png',width: width,height: height,color: Colors.white,);

    return Image.asset('assets/images/users.png',width: width,height: height,color: Colors.white,);
}

 bool validatePassWord(password) {
   if (password
       .toString()
       .length < passwordLength)
     return false;
   return true;
 }

 bool  validationForm(GlobalKey<FormState> item){

return item.currentState.validate();
}


Country initCountry(String num){
   return new Country(
     phoneCode: CountryPickerUtils
         .getCountryByPhoneCode(num)
         .phoneCode,
   );
}

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: kPrimaryColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}



bool IsServiceProvider(String txt){
   return emptyString(txt)==interpreterTxt;
}
bool showExplnationButton({String userType,String explnation,String servicesProvider,bool fromPublicPage=false}){
// showToast(servicesProvider.toString());
 // if(fromPublicPage&&servicesProvider!=userInfo.id) return true;
  /*&& servicesProvider==userInfo.id*/
  return userInfo.id!=null&&emptyString(userType)==interpreterTxt &&emptyString(explnation)==""&&servicesProvider==userInfo.id;
}



bool showDeleteIcon({String clinetId,String providerID}){
  if(userInfo==null||userInfo.id==null||clinetId=="") return false;

  if(userInfo.id==clinetId){
    return true;
  }


  return false;

}

bool showEditIcon({String clinetId,String providerID,String explanation}){
  if(userInfo==null||userInfo.id==null||clinetId=="") return false;


  if(userInfo.id==clinetId){
    return true;
  }

  else if(userInfo.id==providerID){
    if(explanation==null ||explanation.isEmpty) return false;
    else return true;
  }



  return false;

}

bool showAnotherMofaser({bool fromPublicPage=false,String servicesProvider}){
print("my id= ${userInfo.id}");
print("provider id= ${servicesProvider}");
print("state id= ${fromPublicPage}");
  return userInfo.id!=null&&fromPublicPage&&servicesProvider!=userInfo.id;
}


bool showStateAndTime({String createrID}){
  if(userInfo==null) return false;

  return emptyString(userInfo.id)==createrID&&emptyString(userInfo.type)==clientTxt;
}
bool showExplnationText({String explnation}){
  return emptyString(explnation)!="";
}

bool showRating({String createrID,String explnation}){
  return(userInfo.id!=null&&createrID==userInfo.id&&showExplnationText(explnation: explnation));

}


String stateToArabic(String txt,BuildContext context){
  if(emptyString(txt)=="Active")
    return AppLocalizations.of(context).translate("dreamsPending");
  else if(emptyString(txt)=="Done")
    return AppLocalizations.of(context).translate("done");
  else return txt;
}
bool showCardDreamsInDetails({String creationID,String providerID,bool forPublicPage=false}){
  if(forPublicPage) return true;

  if(userInfo==null) return false;
  return (userInfo.id==emptyString(creationID)||userInfo.id==emptyString(providerID));
}

showAreYouHurry({SingleServicesModel singleServicesModel,String creationId}){
  if(userInfo==null||singleServicesModel==null) return false;
  return (userInfo.id==creationId);
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
bool IsExplanation(String txt){
  return emptyString(txt)!="";
}


Future<File> getImageFromGallery({@required int quality}) async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: quality);
  return  File(pickedFile.path);
}


void openPageAndClearPrev({BuildContext context,page,String route}){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => page
      ),
      ModalRoute.withName("/$route")
  );

}


int addPointInPaymnet(String amount){
  print("------AmountString  $amount");
  double result1=double.parse(amount);
  int result= result1.toInt();
  print("------Amount  ${result*10}");
  return result*10;
}

void openPage(context, page) async {
  var route = new MaterialPageRoute(builder: (BuildContext context) {
    return page;
  });
  Navigator.of(context).push(route);
}

Future<Map> openMapPage(context, page) async {
  Map result = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (context) => page));
  return result;
}

void askPermissionCamera() {
  PermissionHandler()
      .requestPermissions([PermissionGroup.camera]).then(onStatusRequsetCamera);
}

Future onStatusRequsetCamera(Map<PermissionGroup, PermissionStatus> statuses) {
  final status = statuses[PermissionGroup.camera];
  if (status != PermissionStatus.granted) {
    PermissionHandler().openAppSettings();
  }
}


