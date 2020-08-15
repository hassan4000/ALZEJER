
import 'package:faserholmak/Screens/TabWithImage/TabWithImage.dart';
import 'package:faserholmak/Screens/createAccountMofaser/CreateAccountMofaser.dart';
import 'package:flutter/material.dart';

class Who extends StatefulWidget {
  @override
  _WhoState createState() => _WhoState();
}

class _WhoState extends State<Who> {
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
                     width: MediaQuery.of(context).size.width*0.35,
                     padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text("زائر", style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                      ),),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: <Widget> [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width -65,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffe8eaf6),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child:Text("يمكنك تصفح محتويات البرنامج",

                          style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17
                      ),),
                    ),
                    Image.asset("assets/images/about.png"),
                    ],
                    ),
                    SizedBox(height: 16,),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.35,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Text("مفسر", style: TextStyle(
                          color: Color(0xffe8eaf6),
                          fontSize: 17
                      ),),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: <Widget> [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width -65,
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffe8eaf6),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:Text("خاص بمن يجيد تغسير الأحلام واجتياز الاختبار",

                          style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17
                      ),),
                    ),
                    Image.asset("assets/images/about.png"),
                    ],
                    ),
                    SizedBox(height: 16,),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width *0.35,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text("عميل", style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                      ),),
                    ),

                    SizedBox(height: 16,),
                    Row(
                      children: <Widget> [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width -65,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffe8eaf6),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Text("يمكنك تفسير أحلامك",

                          style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17
                      ),),
                    ),
                    Image.asset("assets/images/about.png"),
                    ],
                    ),
                    SizedBox(height: 16,),
                    GestureDetector(
                      onTap: (){   Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CreateAccountMofaser();
                          },
                        ),
                      );},
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                           color: Colors.indigo,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text("تسجيل دخول", style: TextStyle(
                            color: Colors.white,
                            fontSize: 17
                        ),),
                      ),
                    ),
                   /* SizedBox(height: 16,),
                    Row(
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
