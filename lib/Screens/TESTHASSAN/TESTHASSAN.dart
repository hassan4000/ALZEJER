import 'package:flutter/material.dart';

class TESTHASSAN extends StatefulWidget {
  @override
  _TESTHASSANState createState() => _TESTHASSANState();
}

class _TESTHASSANState extends State<TESTHASSAN> {


  List<String> array=["1","2","3","4","5","6","7"];
  bool isLoading=false;

  Widget dataListView(List<String> data, context) {
    if (data == null)
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  "tag",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );
    else if (data.length > 0)
      return ListView.builder(
          itemCount: data.length,
          //      controller: _controllerScrollRecevier,
          physics: const NeverScrollableScrollPhysics(),

          itemBuilder: (context, index) {

            return Container(
              width: 100,
                child: Text(array[index].toString()));
          });
    else
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Text(
                  "noData",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )),
          ),
        ],
      );
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('اختر الوقت والمسار المناسب'),
        ),
        body:

             dataListView(array,context),

      ),
    );
  }
}
