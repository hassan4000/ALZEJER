import 'package:flutter/material.dart';
//import 'package:photo_view/photo_view.dart';


class Vision extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.indigo),
        primarySwatch: Colors.purple,
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Dreams'),
      ),
      body: new ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i) {
          
          return Container(
            //height:  MediaQuery.of(context).size.height,
            child: Card(
//                color: Colors.blue,
              elevation: 10,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: Colors.indigo,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset("assets/images/share.png"),
                        Image.asset("assets/images/help.png"),
                      ],
                    ),
                  ),
                  Text("نص الرؤية"),
                  Text(" السلام عليكم ... أمي حلمت أنها بمزرعة كبيرة وخضراء ومعاها ناس تعرفهم من أهلها وعزموها على العشاء",textAlign: TextAlign.right,),
                  Text("كان مشوي وقلت لا حنا كلينا سمك و شافت بنت عمتي عيونها سوده بالحلم مو عاجبها شكلها",textAlign: TextAlign.right,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    color: Colors.indigo,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset("assets/images/heart.png"),
                        SizedBox(width:5),
                        Text("1400",  style: TextStyle(color: Colors.white),),
                        SizedBox(width:20),
                        Image.asset("assets/images/eye.png"),
                         SizedBox(width:10),
                        Text("400",  style: TextStyle(color: Colors.white),),
                        SizedBox(width:65),
                        Image.asset("assets/images/comment.png"),
                        SizedBox(width:5),
                        Text("التعليقات", style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                  ],
                ),
                
            ),
            
          );
        },
      ),
    );
  }
}
