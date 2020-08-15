
import 'package:flutter/material.dart';

import 'Screens/TabWithImage/TabWithImage.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
    TextEditingController passwordTextEditingController = new TextEditingController();

    @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
             // height: MediaQuery.of(context).size.height - 50,
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                    ),
                    SizedBox(height: 16,),
                    Container(
                      alignment: Alignment.center,
                     width: MediaQuery.of(context).size.width,
                     padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(30)
                      ),
                      child: Text("نص السؤال الأول", style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                      ),),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: <Widget> [
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width -65,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffe8eaf6),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child:Text("الخيار الأول",

                          style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17
                      ),),
                    ),
                    
                    ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: <Widget> [
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width -65,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffe8eaf6),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child:Text("الخيار الثاني",

                          style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17
                      ),),
                    ),
                    
                    ],
                    ),

                    SizedBox(height: 16,),
                    Row(
                      children: <Widget> [
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width -65,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffe8eaf6),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child:Text("الخيار الثالث",

                          style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17
                      ),),
                    ),
                    
                    ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: <Widget> [
                    Container(
                     alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width -65,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffe8eaf6),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child:Text("الخيار الرابع",

                          style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17
                      ),),
                    ),
                    
                    ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: <Widget> [
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width -65,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffe8eaf6),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child:Text("الخيار الخامس",

                          style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17
                      ),),
                    ),
                    
                    ],
                    ),
                    SizedBox(height: 16,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget>[
                        Image.asset("assets/images/back.png"),
                        Image.asset("assets/images/next.png"),

                      ],
                    ),
                    SizedBox(height: 26,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Container();
                            },
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                       width: MediaQuery.of(context).size.width,
                       padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text("إنهاء الاختبار", style: TextStyle(
                            color: Colors.white,
                            fontSize: 17
                        ),),
                      ),
                    ),
                   SizedBox(height: 16,),
                    /*Row(
                      children: <Widget>[
                        Text("Already have account?", style: mediumTextStyle(),),
                        Text("SingIn now", style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                        ),)
                      ],
                    ),
                    SizedBox(height: 50,),
*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
