import 'package:cloud_firestore/cloud_firestore.dart';
import 'Content.dart';

Future<void> addUserInfo(userData) async {
  Firestore.instance.collection(TableUser).add(userData).catchError((e) {
    print("Firebase database"+e.toString());
  });
}

getUserInfo(String email) async {
  return Firestore.instance
      .collection(TableUser)
      .where(TableUserName, isEqualTo: email)
      .getDocuments()
      .catchError((e) {
    print("Firebase database"+e.toString());
  });
}


getChats() async{
  return Firestore.instance
      .collection("Chats")
      .orderBy('Time')
      .snapshots();
}

getChatsMofaser() async{
  return Firestore.instance
      .collection("ChatsMofaser")
      .orderBy('Time')
      .snapshots();
}

Future<void> addMessageFirebase( chatMessageData){

  Firestore.instance.collection("Chats")
      .add(chatMessageData).catchError((e){
    print(e.toString());
  });
}

Future<void> addMessageFirebaseMofaser( chatMessageData){

  Firestore.instance.collection("ChatsMofaser")
      .add(chatMessageData).catchError((e){
    print(e.toString());
  });
}