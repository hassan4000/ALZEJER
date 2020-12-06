import 'package:cloud_firestore/cloud_firestore.dart';
import 'Content.dart';

Future<void> addUserInfo(userData) async {
  FirebaseFirestore.instance.collection(TableUser).add(userData).catchError((e) {
    print("Firebase database"+e.toString());
  });
}

getUserInfo(String email) async {
  return FirebaseFirestore.instance
      .collection(TableUser)
      .where(TableUserName, isEqualTo: email).get()
      .catchError((e) {
    print("Firebase database"+e.toString());
  });
}


getChats() async{
  return FirebaseFirestore.instance
      .collection("Chats")
      .orderBy('Time')
      .snapshots();
}

getChatsMofaser() async{
  return FirebaseFirestore.instance
      .collection("ChatsMofaser")
      .orderBy('Time')
      .snapshots();
}

Future<void> addMessageFirebase( chatMessageData){

  FirebaseFirestore.instance.collection("Chats")
      .add(chatMessageData).catchError((e){
    print(e.toString());
  });
}

Future<void> addMessageFirebaseMofaser( chatMessageData){

  FirebaseFirestore.instance.collection("ChatsMofaser")
      .add(chatMessageData).catchError((e){
    print(e.toString());
  });
}