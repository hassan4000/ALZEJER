import 'package:faserholmak/Helper/AppApi.dart';
import 'package:faserholmak/Helper/StyleForApp.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class WaitDialog extends StatefulWidget {
  @override
  _WaitDialogState createState() => _WaitDialogState();
}

class _WaitDialogState extends State<WaitDialog> {


  bool isLoading = false;



  Future<void> logout() async {
    setState(() {
      isLoading=true;
    });
    var response=await logoutRQ();
    Navigator.of(context).pop(response);
    setState(() {
      isLoading=false;
    });
  }

  @override
  void initState() {
   if(mounted)
     logout();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return  AlertDialog(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            borderSide: BorderSide.none),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(
              width: 4.0,
            ),
            Text(
                "تسجيل الخروج  ",
                style: getTextSyle(20, kPrimaryColor,fontWeight: FontWeight.w600)
            ),
          ],

        ),

        content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: isLoading?Container(
              height: 120,
              width: width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'الرجاء الانتظار ..',
                        style: TextStyle(
                          fontFamily: 'Heading',
                          fontSize: 18.0,
                          color: Colors.black87,
                        ),
                      )),
                ],
              ),
            ):Container(
              height: 120,
              width: width,)

        )


    );
  }
}
