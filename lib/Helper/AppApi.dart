import 'dart:async';
import 'dart:convert';

import 'package:faserholmak/Model/ALLPaymentToShowModel/AllPaymentToShowModel.dart';
import 'package:faserholmak/Model/AboutModel/AboutModel.dart';
import 'package:faserholmak/Model/AddServices/AddServiceModel.dart';
import 'package:faserholmak/Model/AddUserWorkModel.dart';
import 'package:faserholmak/Model/AllPaymentMethodModel/AllPaymentMethodModel.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';
import 'package:faserholmak/Model/AllServicesModel/AllServicesModel.dart';
import 'package:faserholmak/Model/ApplicationInfoModel/ApplicationInfoModel.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/Model/CompitionUserModel/CompitionListUser.dart';
import 'package:faserholmak/Model/PaymentModel/PaymentModel.dart';
import 'package:faserholmak/Model/PostCreatAccountMofaser/PostCreatAccountMofaserModel.dart';
import 'package:faserholmak/Model/ProvidersModelPagination/ProviderModelPagination.dart';
import 'package:faserholmak/Model/ServicesPathModel.dart';
import 'package:faserholmak/Model/SingleServicesModel/SingleServicesModel.dart';
import 'package:faserholmak/Model/TokenModel.dart';
import 'package:faserholmak/Model/TransactionRecord/TransactionRecordModel.dart';
import 'package:faserholmak/Model/UserInfoModel/UserInfoModel.dart';
import 'package:faserholmak/Model/UserWorkWithNumber/UserWorkWithNumber.dart';
import 'package:faserholmak/Model/WorkTypeUser/Value.dart';
import 'package:faserholmak/Model/WorkTypeUser/WorkTypeModel.dart';
import 'package:faserholmak/Model/compitionList/CompitionResponse.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import 'BasicTools.dart';
import 'Content.dart';




final baseUrl = 'https://api2.fsrhilmak.com/';
//final payUrl = 'http://api2.fsrhilmak.com/';
final payUrlTest = 'https://apitest.myfatoorah.com';

final String payUrlRealse = "https://api.myfatoorah.com/";
final String tokenPAY="jxgpB9hZY0yAmTx_YN4NSmeXRb6Dbolv17-nsMkcG8wLrf6lOWibfBShd9RuiQ3jB3PQs_0DVRb0bSTiJTddltx5jElPgkA99rGAM9C8OGJMY0lB9jaexzNdwaJxiiH3F6hTCFhq4McGxKzuCLGq7s-95hK3CcSmblXlJ5vZzCv8_Rl8lDvltSxEPImp3d_B9KIPe1-s0ttr_thuEDV6Qr4NAzS98Xzc7rqqqb8diy01Uw0G2jSbaASnmc-UzEPwYGrYWwalbGVXAwQAoH6c8gjvvuuAARL636meV-3nR7qIXjP10yz_cOSxY6xMjkF-R6G8Wiy18OX3cKg0fPlMP2jgbAbHt0Ygevi-yt9-Wa-KIB9vBtOiII5VXz-MjYMpfEeiUUI3xkwqQvu8veQt1o3Vz0B4JcDshImVgF_6uFev_VKia3eVJIwcVJe9PBsFQ6llZqSZrhPJCADmL4Uc5agUSPoujcUoCa-GrMkzPdjleJyjbfCu-44jbFcfGR759VDKvrm4tJpEtk-1yTusFif17tbMpjwrC-qkrJmx-mEWckuHpcI4TAhoxhliaCR37ogn6Gl5smIFUfIMy0YU7gKzdi1VqjmCX2R1nznelP32DQd1H47Pc8d0e_qEcFY8eVFl2JT3aa64ktB3B1PBA5ew14lS6DcPPmdHq1fbdj-A9dVqEH3DOrZD-Zf8qk63d-zYBw";



final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
// Token for regular payment
final String regularPaymentToken =
    "cxu2LdP0p0j5BGna0velN9DmzKJTrx3Ftc0ptV8FmvOgoDqvXivkxZ_oqbi_XM9k7jgl3SUriQyRE2uaLWdRumxDLKTn1iNglbQLrZyOkmkD6cjtpAsk1_ctrea_MeOQCMavsQEJ4EZHnP4HoRDOTVRGvYQueYZZvVjsaOLOubLkdovx6STu9imI1zf5OvuC9rB8p0PNIR90rQ0-ILLYbaDZBoQANGND10HdF7zM4qnYFF1wfZ_HgQipC5A7jdrzOoIoFBTCyMz4ZuPPPyXtb30IfNp47LucQKUfF1ySU7Wy_df0O73LVnyV8mpkzzonCJHSYPaum9HzbvY5pvCZxPYw39WGo8pOMPUgEugtaqepILwtGKbIJR3_T5Iimm_oyOoOJFOtTukb_-jGMTLMZWB3vpRI3C08itm7ealISVZb7M3OMPPXgcss9_gFvwYND0Q3zJRPmDASg5NxRlEDHWRnlwNKqcd6nW4JJddffaX8p-ezWB8qAlimoKTTBJCe5CnjT4vNjnWlJWscvk38VNIIslv4gYpC09OLWn4rDNeoUaGXi5kONdEQ0vQcRjENOPAavP7HXtW1-Vz83jMlU3lDOoZsdEKZReNYpvdFrGJ5c3aJB18eLiPX6mI4zxjHCZH25ixDCHzo-nmgs_VTrOL7Zz6K7w6fuu_eBK9P0BDr2fpS";

// Token for direct payment and recurring
final String directPaymentToken =
    "fVysyHHk25iQP4clu6_wb9qjV3kEq_DTc1LBVvIwL9kXo9ncZhB8iuAMqUHsw-vRyxr3_jcq5-bFy8IN-C1YlEVCe5TR2iCju75AeO-aSm1ymhs3NQPSQuh6gweBUlm0nhiACCBZT09XIXi1rX30No0T4eHWPMLo8gDfCwhwkbLlqxBHtS26Yb-9sx2WxHH-2imFsVHKXO0axxCNjTbo4xAHNyScC9GyroSnoz9Jm9iueC16ecWPjs4XrEoVROfk335mS33PJh7ZteJv9OXYvHnsGDL58NXM8lT7fqyGpQ8KKnfDIGx-R_t9Q9285_A4yL0J9lWKj_7x3NAhXvBvmrOclWvKaiI0_scPtISDuZLjLGls7x9WWtnpyQPNJSoN7lmQuouqa2uCrZRlveChQYTJmOr0OP4JNd58dtS8ar_8rSqEPChQtukEZGO3urUfMVughCd9kcwx5CtUg2EpeP878SWIUdXPEYDL1eaRDw-xF5yPUz-G0IaLH5oVCTpfC0HKxW-nGhp3XudBf3Tc7FFq4gOeiHDDfS_I8q2vUEqHI1NviZY_ts7M97tN2rdt1yhxwMSQiXRmSQterwZWiICuQ64PQjj3z40uQF-VHZC38QG0BVtl-bkn0P3IjPTsTsl7WBaaOSilp4Qhe12T0SRnv8abXcRwW3_HyVnuxQly_OsZzZry4ElxuXCSfFP2b4D2-Q";


final imageUrl= baseUrl+'api/Core/Download?id=';
String token;



class Response {
  int _statusCode;
  dynamic _object;


  Response(this._statusCode, this._object);

  dynamic get object => this._object;

  set object(dynamic value) {
    this._object = value;
  }

  int get statusCode => this._statusCode;

  set statusCode(int value) {
    this._statusCode = value;
  }
}


Future<Response> sendAndRetrieveMessage({String body,String title,List<String> providerToken,
  List<String>  clientToken}) async {
  await firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
  );


  printWrapped("PROVIDER TOKEM"+providerToken.toString());
  List<String> to=new List();
  if(clientToken!=null&& clientToken.isNotEmpty)
    to=clientToken;
  else if(providerToken!=null&& providerToken.isNotEmpty)
    to=providerToken;
 var response=  await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$SERVER_TOKEN',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': '$body',
          'title': '$title'
        },
        'registration_ids':to,
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',

        },
      //  'to': await firebaseMessaging.getToken(),
        //'to': "$to",
      },
    ),
  );

 print("code ${response.statusCode}");



 print( jsonEncode(
   <String, dynamic>{
     'notification': <String, dynamic>{
       'body': '$body',
       'title': '$title',
       'sound':'default'
     },
     'registration_ids':to,
     'priority': 'high',
     'data': <String, dynamic>{
       'click_action': 'FLUTTER_NOTIFICATION_CLICK',
       'id': '1',
       'status': 'done',

     },
     //  'to': await firebaseMessaging.getToken(),
     //'to': "$to",
   },
 ),);
 print(jsonEncode(response.body));
 return Response(response.statusCode,response.body);

/*  final Completer<Map<String, dynamic>> completer =
  Completer<Map<String, dynamic>>();

  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      completer.complete(message);
      printWrapped("FIREBASE RESPONSE ${jsonEncode(message.toString())}");
    },
  );

  return completer.future;*/
}


Future<Response> uploadUserImage(String pathImage) async {
  printWrapped(pathImage);
  try {

    String url = baseUrl + 'api/Core/Upload';
    printWrapped('url  = $url');
    var request = new http.MultipartRequest("POST", Uri.parse(url));

    if (pathImage != null) {
      request.files.add(await http.MultipartFile.fromPath('image', pathImage));
    }

    var response = await request.send();
    printWrapped(' code ${response.statusCode}');

    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);
      var data = json.decode(res.body);
      printWrapped(' response ${res.body}');

      return Response(response.statusCode,data['id']);

    } else {
      return new Response(response.statusCode, failedAddPic);
    }
  }

  on TimeoutException catch (_) {
   // showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    return new Response(-1, failedAddPic);
  }
}


Future<Response> addUserWorkToMofaser(List<Value> map,String idUser) async {


  List<AddUserWorkModel> data=List();
  for(Value i in map)
  data.add(AddUserWorkModel(userId:idUser,userWorkId:i.id ));


  var dataToSend=data.map((item)=>item.toJson()).toList();





  String url = baseUrl + 'api/Actions/AddBindings';
  printWrapped(jsonEncode(dataToSend));
  printWrapped(url);

  try {
    var response = await http.post(url, headers: {'content-type': 'application/json'},
        body: jsonEncode(dataToSend));

    printWrapped('code  = ${response.statusCode}');

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');




      return new Response(200,"");

    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
      showToast("فشلت عملية اضافة اختصاص المفسر");
      return new Response(response.statusCode, failedRegister);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedRegister);
    return new Response(-1, failedRegister);
  }
}


Future<Response> createAccountMofaser(PostCreatAccountMofaserModel map) async {



  var i=map.toJson();
  String url = baseUrl + 'api/Account/Register';
  printWrapped(jsonEncode(i));
  printWrapped(url);

  try {
    var response = await http.post(url, headers: {'content-type': 'application/json'},
        body: jsonEncode(map));

    printWrapped('code  = ${response.statusCode}');

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');




      return new Response(200,"");

    }
 /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
      showToast(response.body.toString());
      return new Response(response.statusCode, failedRegister);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedRegister);
    return new Response(-1, failedRegister);
  }
}

Future<Response> editAccountMofaserRQ(Map<String,dynamic> map) async {


  String token=await getToken();

  printWrapped(json.encode(map));
  String url = baseUrl + 'api/Account/updateUserInfo';

  printWrapped(url);

  try {
    var response = await http.post(url, headers: {
      'content-type': 'application/json',
      'Authorization': 'Bearer ' +token},
        body: jsonEncode(map));

    printWrapped('code  = ${response.statusCode}');

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');




      return new Response(200,"");

    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
     // showToast(response.body.toString());
      showToast(failedRegister);
      return new Response(response.statusCode, failedRegister);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedRegister);
    return new Response(-1, failedRegister);
  }
}


Future<Response> createAccountNormal(Map<String,dynamic> map) async {



  String url = baseUrl + 'api/Account/Register';
  printWrapped("body"+ json.encode(map).toString());

  try {
    var response = await http.post(url, headers: {'content-type': 'application/json'},
        body: json.encode(map));

    printWrapped('code  = ${response.statusCode}');

    print("Body"+response.body);
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');





      return new Response(200,"");

    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {


      return new Response(response.statusCode, response.body.toString());
    }
  }
  on TimeoutException catch (_) {

    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    return new Response(-1, failedRegister);
  }
}

Future<Response> createAccountSocial(Map<String,dynamic> map) async {



  String url = baseUrl + 'api/Account/Register';
  printWrapped("body"+ json.encode(map).toString());

  printWrapped("url "+url);
  try {
    var response = await http.post(url, headers: {'content-type': 'application/json'},
        body: json.encode(map));

    printWrapped('code  = ${response.statusCode}');

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');




      return new Response(200,"");

    }

    else if(response.statusCode==400){
      return new Response(200,"");
    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, response.body.toString());
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedRegister);
  }
}



Future<Response> loginNormal(Map<String,dynamic> map,{bool social=false}) async {



  String url = baseUrl + 'Token';
  printWrapped('url  = $url');
  printWrapped("body"+ json.encode(map).toString());

  try {
    var response = await http.post(url,
        headers: {
      "Accept": "application/json",
      'content-type': 'application/x-www-form-urlencoded'
        },
        body: map,
    encoding: Encoding.getByName("utf-8"));
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 200) {


      
      TokenModel tokenModel=TokenModel.fromJson(res);


      
      
      setToken(tokenModel.access_token);
      setEmail(map['username']);
      setPassword(map['password']);


      return new Response(response.statusCode,tokenModel.access_token);

    }
    else if(response.statusCode==400){
      if(social)
        showToast("هذا الحساب مسجل في التطبيق سابقا");
      else
      showToast(incurrectLogin);
      return new Response(response.statusCode, incurrectLogin);
    }


    else  {
      if(res['error_description']!=null){
        showToast( res['error_description']);
      return new Response(response.statusCode, res['error_description']);}

      else  {
        showToast(  failedOpreation);
        return new Response(response.statusCode, failedOpreation);}

    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> getAdditionlInfo({
  bool about=false,
  bool terms=false,
  bool privacy_policy=false,
  bool swear=false}) async {


  String path="";

  if(about)
    path="About";
  else if(terms)
    path="Terms";
  else if(privacy_policy)
    path="Privacy_Policy";
  else if(swear)
    path="Swear";

  String url = baseUrl + 'api/Core/GetParameter?code=$path';
  printWrapped('url  = $url');



  try {
    var response = await http.get(
      url,

    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 200) {



      AboutModel item=AboutModel.fromJson(res);

      return new Response(200,item);

    }



    else  {
      if(res['error_description']!=null){
        showToast(failedOpreation);
        return new Response(response.statusCode, res['Message']);}
      else  {

        showToast(failedOpreation);
        return new Response(response.statusCode, failedOpreation);}

    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}

Future<Response> getUserInfoRQ({String token}) async {



  String url = baseUrl + 'api/Account/UserInfo';
  printWrapped('url  = $url');



  try {
    var response = await http.get(
      url,
      headers: {
      'content-type': 'application/json',
      'Authorization': 'Bearer ' +token
      },
      );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 200) {



      UserInfoModel userInfoModel=UserInfoModel.fromJson(res);
      userInfo=userInfoModel;





      return new Response(200,userInfoModel);

    }
    else if(response.statusCode==401){
      if(res['Message']!=null){
        showToast(res['Message']);
      return new Response(response.statusCode, res['Message']);}
      else {         showToast(forbiddenRequest);
        return new Response(response.statusCode,forbiddenRequest );}

    }


    else  {
      if(res['error_description']!=null){
        showToast(res['Message']);
        return new Response(response.statusCode, res['Message']);}
      else  {

        showToast(failedOpreation);
        return new Response(response.statusCode, failedOpreation);}

    }
  }
  on TimeoutException catch (_) {
showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}




Future<Response> getUserWorkWithNumber() async {



  String url = baseUrl + 'api/actions/GetUserWorks';
  printWrapped('url  = $url');



  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );

    printWrapped('code  = ${response.statusCode}');

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');
      List<UserWorkWithNumber>item= (res as List).map((i)=>UserWorkWithNumber.fromJson(i)).toList();

      return new Response(200,item);
    }


    else  {
        showToast(failedOpreation);
        return new Response(response.statusCode, failedOpreation);}
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> getWorkTypeRQ() async {
  String url = baseUrl + 'odata/UserWorks';
  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 200) {

      WorkTypeModel workType=WorkTypeModel.fromJson(res);
      return new Response(200,workType);
    }


    else  {
      showToast(failedOpreationWorkType);
         return new Response(response.statusCode, failedOpreationWorkType);
    }
  }
  on TimeoutException catch (_) {

    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> getServiceProviders(String id,{int top=10, int skip=0,}) async {
  String url = baseUrl + 'api/Account/GetServiceProviders?id=$id&skip=$skip&top=$top';
  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 200) {
      ProviderModelPagination item=ProviderModelPagination.fromJson(res);
    //  List<UserInfoModel> item = (res as List).map((i)=>UserInfoModel.fromJson(i)).toList();
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> getAllServiceProviders() async {
  String url = baseUrl + 'api/Account/GetServiceProvidersWithoutFilter';
  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 200) {
      List<UserInfoModel> item = (res as List).map((i)=>UserInfoModel.fromJson(i)).toList();
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> getServicePath(String id) async {

  String t=await getToken();
  String url = baseUrl + 'api/Account/GetServicePathsForProvider?id=$id';
  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    printWrapped('token  = $t');
    if (response.statusCode == 200) {
      List<ServicesPathModel> item = (res as List).map((i)=>ServicesPathModel.fromJson(i)).toList();
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}




Future<Response> getAllCompition({
  int top=10,
  int skip=0,
  String filterType='Active',}) async {

  String t=await getToken();
  String url = baseUrl + 'api/Actions/GetCompetitions?status=$filterType&skip=$skip&top=$top';


  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    printWrapped('token  = $t');
    if (response.statusCode == 200) {
     CompitionResponse item = CompitionResponse.fromJson(res);
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}



Future<Response> getAllUserForCompition({
  int top=10,
  int skip=0,
  String filterid,}) async {

  String t=await getToken();
  String url = baseUrl + 'api/Actions/GetCompetitionResult?CompetitionId=$filterid';
 // String url = baseUrl + 'api/Actions/GetCompetitionResult?CompetitionId=$filterType&skip=$skip&top=$top';


  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');

    printWrapped('token  = $t');
    if (response.statusCode == 200) {
      printWrapped('response  = ${response.body}');
      List<CompitionListUser> item=(res as List).map((i) => CompitionListUser.fromJson(i)).toList();
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> addLike(int idService) async {

  String t=await getToken();
  String url = baseUrl + 'api/Actions/Like?id=$idService';
  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    printWrapped('token  = $t');
    if (response.statusCode == 200) {

      return new Response(200, "");
    }


    else {
   //   showToast(failedOpreation);
      return new Response(response.statusCode, "");
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
   // showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> getServicePrivatePrice() async {
  String url = baseUrl + 'api/Core/GetParameter?code=Privacy_Price';
  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 200) {

      return new Response(200, res['Value']);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}

Future<Response> getCodeFromEmail(String email) async {
  String url = baseUrl + 'api/Account/RequestPasswordReset?Email=$email';
  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 200) {

      return new Response(200, "");
    }


    else if(response.statusCode==400){
      showToast("لايوجد ايميل مشابه ");
      return new Response(400, "");
    }

    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}

Future<Response> addNewPassword({String email,String password}) async {
  String url = baseUrl + 'api/Account/ForgetPassword?Email=$email&NewPassword=$password';
  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/x-www-form-urlencoded',
      },
    );
    //var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 200) {

      return new Response(200, "");
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> checkCode({String code,String email}) async {
  Map<String,dynamic> data={
    "code":"$code",
    "email":"$email",
  };
  var t=await getToken();
  String url = baseUrl + 'api/Account/VerifyEmail';
  printWrapped(json.encode(data));

  try {
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $t',
      'content-type': 'application/json',
    },
        body: jsonEncode(data));
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 201||response.statusCode==200) {
      return new Response(200,"");

    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
      showToast("الكود غير صحيح");
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast("الكود غير صحيح");
    return new Response(-1, failedOpreation);
  }
}


Future<Response> AddServicesRQ(AddServiceModel map) async {
  var i=map.toJson();
  var t=await getToken();
  String url = baseUrl + 'odata/Services';
  printWrapped(json.encode(i));
  printWrapped("url = $url");

  try {
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $t',
      'content-type': 'application/json',
      },
        body: jsonEncode(map));
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 201) {



      int id=int.parse(res['id'].toString());
     // showToast("${res['id']}");
      return new Response(200,id);

    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}



Future<Response> payByPointRQ(Map<String,dynamic> map) async {

  var t=await getToken();
  String url = baseUrl + 'api/Actions/ChangePlan';
  printWrapped(url);
  printWrapped(json.encode(map));

  try {
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $t',
      'content-type': 'application/json',
    },
        body: jsonEncode(map));
    var res = json.decode(response.body);
    printWrapped('code PAY  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 200) {
      return new Response(200,res);

    }
       else if (response.statusCode == 400) {
         showToast(notEnoughPoint);
      return new Response(response.statusCode, "");
    }
    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(notEnoughPoint);
    return new Response(-1, failedOpreation);
  }
}



Future<Response> toAnotherMofser({String serviesid,String providerID}) async {


  Map<String,dynamic> data={
    "id":"$serviesid",
    "ServiceProviderId":"$providerID"
  };

  var t=await getToken();
  String url = baseUrl + 'api/actions/ReceiveService';
  printWrapped(' url = $url ');


  print(json.encode(data));


  try {
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $t',
      'content-type': 'application/json'
    },
      body: jsonEncode(data)
    );
    printWrapped('code   = ${response.statusCode}');
    printWrapped('Body   = ${response.body}');
    if (response.statusCode == 200||response.statusCode==201) {
      var res = json.decode(response.body);

      printWrapped('response  = ${response.body}');
      return new Response(200,"");

    }
    else if (response.statusCode == 400) {
      showToast(response.body.toString());
      return new Response(response.statusCode, "");
    }
    else {
      showToast(response.body.toString());
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    //   showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}

Future<Response> logoutRQ() async {

  var t=await getToken();
  String url = baseUrl + 'api/Account/Logout';
  printWrapped(url);


  try {
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $t',
//      'content-type': 'application/x-www-form-urlencoded',
    },
    );
    printWrapped('code   = ${response.statusCode}');
    printWrapped('Body   = ${response.body.toString()}');
    if (response.statusCode == 200) {
      var res = json.decode(response.body);

      printWrapped('response  = ${response.body}');
      return new Response(200,"");

    }
    else if (response.statusCode == 400) {
      showToast(failedOpreation);
      return new Response(response.statusCode, "");
    }
    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
 //   showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}

Future<Response> getSingleServicesInfo({
  String id}) async {


  String url = baseUrl + 'api/actions/GetSingleServiceInfo?id=$id';


  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );

    printWrapped('code  = ${response.statusCode}');


    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');
      SingleServicesModel item = SingleServicesModel.fromJson(res);
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}



  Future<Response> getServicePricePerPoints(int amount) async {


/*  String url = baseUrl + 'api/Core/GetParameter?code=ServicePricePerPoints';
  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );

    printWrapped('code  = ${response.statusCode}');


    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');

      int value=int.parse(res['Value']);
      return new Response(200, value);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }*/
}


Future<Response> getMofaserBalance({String idMofser}) async {

  var t=await getToken();
 // String url = baseUrl + 'odata/Transactions?\$filter=UserId eq \'$idMofser\'&\$orderby=CreationDate desc';
  String url = baseUrl + 'odata/Transactions?\$filter=UserId eq \'2211669b-fe10-48bf-84d5-22c9c84eb5b3\'&\$orderby=CreationDate desc';


  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
        'content-type': 'application/json'
      },
    );

    printWrapped('code  = ${response.statusCode}');


    if (response.statusCode == 200) {
      var res = json.decode(response.body);

      printWrapped('response  = ${response.body}');

      TransactionRecordModel item=TransactionRecordModel.fromJson(res);
      print("____________________________");
      print(item.toJson().toString());
      print("____________________________");
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> getAllPaymentRecordRQ()async {

  var t=await getToken();
  String url = baseUrl + 'api/Actions/GetPayments';


  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
        'content-type': 'application/json'
      },
    );

    printWrapped('code  = ${response.statusCode}');


    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');

      List<AllPaymentToShowModel> item=(res as List).map((i) => AllPaymentToShowModel.fromJson(i)).toList();
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}

Future<Response> getSingleUserInfo({
  String id}) async {


  String url = baseUrl + 'api/Account/GetSingleUserInfo?id=$id';


  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');

    if (response.statusCode == 200) {
      UserInfoModel item = UserInfoModel.fromJson(res);
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}

Future<Response> getAllServiceVisitor({
  int top=10,
  int skip=0,

  String orderby='CreationDate desc',
  String filterType='Active',
  var filterWorkType
}) async {

  String t=await getToken();
  String url = baseUrl + 'odata/Services?\$inlinecount=allpages';
  url+='&\$top=$top';
  url+='&\$skip=$skip';
  url+='&\$orderby=$orderby';
  url+="&\$filter=Status eq \'${filterType}\'";
  url+="&\$expand=ServiceProvider";

  if(filterWorkType!=null)
    url+='&\$filter=UserWorkId eq $filterWorkType';

  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    printWrapped('token  = $t');
    if (response.statusCode == 200) {
      AllServicesModel item = AllServicesModel.fromJson(res);
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}

Future<Response> getAllServiceClient({
  int top=10,
  int skip=0
  ,String filterUserID,
  String orderby='CreationDate desc',
  String filterType='Active',
  var filterWorkType
}) async {

  String t=await getToken();
  String url = baseUrl + 'odata/Services?\$inlinecount=allpages';
  url+='&\$top=$top';
  url+='&\$skip=$skip';
  url+='&\$filter=CreatorId eq \'$filterUserID\' and Status eq \'${filterType}\'';
  url+='&\$orderby=$orderby';
  url+='&\$expand=Comments,ServiceProvider';
//  url+="&\$filter=Status eq \'${filterType}\'";

  if(filterWorkType!=null)
    url+='&\$filter=UserWorkId eq $filterWorkType';

  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    printWrapped('token  = $t');
    if (response.statusCode == 200) {
     AllServicesModel item = AllServicesModel.fromJson(res);
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}



Future<Response> getAllMyService({
  int top=10,
  int skip=0
  ,String filterUserID,
  String orderby='CreationDate desc',

  var filterWorkType
}) async {

  String t=await getToken();
  String url = baseUrl + 'odata/Services?\$inlinecount=allpages';

  if(filterWorkType==null){
  url+='&\$top=$top';
  url+='&\$skip=$skip';
  url+='&\$filter=CreatorId eq \'$filterUserID\'';
  url+='&\$orderby=$orderby';
  url+='&\$expand=Comments,ServiceProvider';}
//  url+="&\$filter=Status eq \'${filterType}\'";



  if(filterWorkType!=null){
    url+='&\$top=$top';
    url+='&\$skip=$skip';
    url+='&\$filter=CreatorId eq \'$filterUserID\' and UserWorkId eq ${filterWorkType}&\$orderby=CreationDate desc&\$expand=Comments';}


  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    printWrapped('token  = $t');
    if (response.statusCode == 200) {
      AllServicesModel item = AllServicesModel.fromJson(res);
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> getAllServiceServicesProvider({
  int top=10,
  int skip=0
  ,String filterUserID,
  String orderby='CreationDate desc',
  String filterType='Active',
  var filterWorkType,

}) async {

  String t=await getToken();
  String url = baseUrl + 'odata/Services?\$inlinecount=allpages';
  url+='&\$top=$top';
  url+='&\$expand=Comments,ServiceProvider';
  url+='&\$skip=$skip';
  url+='&\$filter=ServiceProviderId eq \'$filterUserID\' and Status eq \'${filterType}\'';
  url+='&\$orderby=$orderby';
  //url+="&\$filter=Status eq \'${filterType}\'";

  if(filterWorkType!=null)
    url+='&\$filter=UserWorkId eq $filterWorkType';



  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    printWrapped('token  = $t');
    if (response.statusCode == 200) {
      AllServicesModel item = AllServicesModel.fromJson(res);
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}



Future<Response> getAllServiceForProvider({
  int top=10,
  int skip=0
  ,String filterUserID,
  String orderby='CreationDate asc',
  String filterType='Active',
  var filterWorkType,

}) async {

  String t=await getToken();
  String url = baseUrl + 'odata/Services?\$inlinecount=allpages';
  url+='&\$top=$top';
  url+='&\$expand=Comments,ServiceProvider';
  url+='&\$skip=$skip';
  url+='&\$filter=ServiceProviderId eq \'$filterUserID\' and Status eq \'${filterType}\'&\$orderby=$orderby';
 // url+='&\$orderby=$orderby';
  //url+="&\$filter=Status eq \'${filterType}\'";

  if(filterWorkType!=null)
    url+='&\$filter=UserWorkId eq $filterWorkType';



  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    printWrapped('token  = $t');
    if (response.statusCode == 200) {
      AllServicesModel item = AllServicesModel.fromJson(res);
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> getAllServicePublic({
  int top=10,
  int skip=0,
  String orderby='CreationDate desc',
  String filterType='Active and PublicServiceAction eq True',
  var filterWorkType,

}) async {

  String t=await getToken();
  String url = "";
  //String url = baseUrl + 'api/Actions/GetPublicServices';
/*  url+='&\$top=$top';
  url+='&\$skip=$skip';
  url+='&\$orderby=$orderby';*/

if(filterWorkType==null){
  url= baseUrl + 'api/Actions/GetPublicServicesWithoutFilter';
}
 // url+="Status=Active";
  //url+="&\$filter=Status eq \'${filterType}\'";

 else if(filterWorkType!=null){
 url= baseUrl + 'api/Actions/GetPublicServices';
    url+='?UserWorkId=$filterWorkType';}



  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    printWrapped('token  = $t');
    if (response.statusCode == 200) {
      List<AllServicesData> item=(res as List).map((i) => AllServicesData.fromJson(i)).toList();
     // AllServicesModel item = AllServicesModel.fromJson(res);
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> getAllServiceServicesProviderPublic({
  int top=10,
  int skip=0,
  String orderby='CreationDate desc',
  String filterType='Active and PublicServiceAction eq True',
  var filterWorkType,

}) async {

  String t=await getToken();
  String url = baseUrl + 'odata/Services?\$inlinecount=allpages';
  url+='&\$top=$top';
  url+='&\$skip=$skip';
  url+='&\$orderby=$orderby';
  url+="&\$filter=Status eq \'${filterType}\'";

  if(filterWorkType!=null)
    url+='&\$filter=UserWorkId eq $filterWorkType';



  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    printWrapped('token  = $t');
    if (response.statusCode == 200) {
      AllServicesModel item = AllServicesModel.fromJson(res);
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}






Future<Response> getCommentByID({
  int serviceID,

}) async {

  String t=await getToken();
  String url = baseUrl + 'odata/Services($serviceID)?\$expand=Comments';




  printWrapped('url  = $url');
  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $t',
      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    printWrapped('token  = $t');
    if (response.statusCode == 200) {
      List<CommentModel> item = (res['Comments'] as List).map((i)=>CommentModel.fromJson(i)).toList();
      return new Response(200, item);
    }


    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }
  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}



Future<Response> addPaymentToServer(PaymentModel map) async {






  var t=await getToken();
  String url = baseUrl + 'api/Actions/ChangePlan';
  printWrapped("body ${json.encode(map)}");
  printWrapped(url);


/*  return Response(400,"");*/
  try {
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $t',
      'content-type': 'application/json',
    },
        body: jsonEncode(map));
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');

    if (response.statusCode == 201||response.statusCode==200) {
      printWrapped('response  = ${response.body}');





      return new Response(200,"");

    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> addFirebaseToken({String fireToken,String userID}) async {


  Map<String,dynamic> map={
    "UserId":"$userID",
    "token":"$fireToken",
  };


  var t=await getToken();
  String url = baseUrl + 'odata/UsersDeviceTokens';
  print(url);
  printWrapped(json.encode(map));

  try {
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $t',
      'content-type': 'application/json',
    },
        body: jsonEncode(map));

    printWrapped('code FireBase  = ${response.statusCode}');

    if (response.statusCode == 201||response.statusCode==200) {
      var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');





      return new Response(200,"");

    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
    //  showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
   // showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
  //  showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}

Future<Response> AddCommentRQ(Map<String,dynamic> map) async {
  var t=await getToken();
  String url = baseUrl + 'odata/ServiceComments';
  printWrapped(json.encode(map));

  try {
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $t',
      'content-type': 'application/json',
    },
        body: jsonEncode(map));
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 201) {


      CommentModel item=CommentModel.fromJson(res);



      return new Response(200,item);

    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> EditTextClientRQ(Map<String,dynamic> map) async {
  var t=await getToken();
  String url = baseUrl + 'api/actions/EditService';
  printWrapped("url = $url");
  printWrapped(json.encode(map));

  try {
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $t',
      'content-type': 'application/json',
    },
        body: jsonEncode(map));

    printWrapped('code  = ${response.statusCode}');

    if (response.statusCode == 201||response.statusCode==200) {
      var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');

     // CommentModel item=CommentModel.fromJson(res);



      return new Response(200,"");

    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> addExplanationRQ({String txt,String id,bool fromPublicPage,String providerID}) async {
  Map<String,dynamic> map;
  if(!fromPublicPage)
   map ={
    "id":id,
    "Explanation":txt
  };
  else
    map ={
      "id":id,
      "Explanation":txt,
      "ServiceProviderId":providerID
    };



  var t=await getToken();
  String url = baseUrl + 'api/actions/AddExplanation';

  printWrapped(url);
  printWrapped(json.encode(map));

  try {
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $t',
      'content-type': 'application/json',
    },
        body: jsonEncode(map));
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 201||response.statusCode==200) {


      //CommentModel item=CommentModel.fromJson(res);



      return new Response(200,"");

    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}


Future<Response> addRateRQ({String txt,String id,double rate}) async {
  Map<String,dynamic> map ={
    "id":id,
    "RatingMessage":txt,
    "UserRating":"${rate.toInt()}",
  };



  var t=await getToken();
  String url = baseUrl + 'api/actions/AddRating';

  printWrapped(url);
  printWrapped(json.encode(map));

  try {
    var response = await http.post(url, headers: {
      'Authorization': 'Bearer $t',
      'content-type': 'application/json',
    },
        body: jsonEncode(map));
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 201||response.statusCode==200) {


      //CommentModel item=CommentModel.fromJson(res);



      return new Response(200,"");

    }
    /*   else if (response.statusCode == 401) {
      return new Response(response.statusCode, sharedData.tryLater);
    } else if(response.statusCode==500)  {
      sharedData.flutterToast(sharedData.phoneAlreadyUserd);
      return new Response(response.statusCode, sharedData.tryLater);
    }*/
    else {
      showToast(failedOpreation);
      return new Response(response.statusCode, failedOpreation);
    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}



Future<Response> getApplicationInfo() async {

  String url = baseUrl + 'api/actions/getUsersStatistics';
  printWrapped('url  = $url');

  try {
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',

      },
    );
    var res = json.decode(response.body);
    printWrapped('code  = ${response.statusCode}');
    printWrapped('response  = ${response.body}');
    if (response.statusCode == 200) {

      ApplicationInfoModel item=ApplicationInfoModel.fromJson(res);
      return new Response(200,item);

    }
    else if(response.statusCode==401){
      if(res['Message']!=null){
        showToast(res['Message']);
        return new Response(response.statusCode, res['Message']);}
      else {         showToast(forbiddenRequest);
      return new Response(response.statusCode,forbiddenRequest );}

    }


    else  {
      if(res['error_description']!=null){
        showToast(res['Message']);
        return new Response(response.statusCode,failedOpreation);}
      else  {

        showToast(failedOpreation);
        return new Response(response.statusCode, failedOpreation);}

    }
  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}




Future<Response> deleteService(String id) async {

  String t=await getToken();
  String url = baseUrl + 'odata/Services($id)';
  printWrapped('url  = $url');

  try {
    var response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $t',

      },
    );

    printWrapped('code  = ${response.statusCode}');

    if (response.statusCode == 200||response.statusCode==204) {

  /*    var res = json.decode(response.body);
      printWrapped('response  = ${response.body}');*/
      return new Response(200,true);

    }



    else  {

        showToast(failedOpreation);
        return new Response(response.statusCode, failedOpreationDelete);}


  }
  on TimeoutException catch (_) {
    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreationDelete);
  }
}

/*------------------------------asdasdasdasd-----------------------*/

Future<Response> getAllPaymentMethod({double cost}) async {

  MFSDK.init(payUrlTest, regularPaymentToken);
  try {
    var request = new MFInitiatePaymentRequest(cost, MFCurrencyISO.UNITED_STATE_USD);

    AllPaymentMethodModel item;
    int code=0;
    MFSDK.initiatePayment(
        request,
        MFAPILanguage.AR,
            (MFResult<MFInitiatePaymentResponse> result) => {
          if (result.isSuccess())
            {
              item=AllPaymentMethodModel.fromJson(result.response.toJson()),
              code=200

          /*    setState(() {

                printWrapped(jsonEncode(result.response).toString());
                _response = result.response.toJson().toString();
              })*/
            }
          else
            { code=200,
              print(emptyString(result.error.toJson().toString()))
            }


        });

    return Response(code,item);
  }
  on TimeoutException catch (_) {

    showToast(checkEnternet);
    return Response(-1000, checkEnternet);
  }

  catch (e) {
    printWrapped(e.toString());
    showToast(failedOpreation);
    return new Response(-1, failedOpreation);
  }
}
