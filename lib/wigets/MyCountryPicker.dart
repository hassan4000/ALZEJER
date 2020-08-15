import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

class MyCountryPicker extends StatelessWidget {
 final  double width;
 final double padding;
 final Country country;


 MyCountryPicker({this.width=112, this.padding=12, this.country});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      padding: EdgeInsets.all(padding,),
      child: Row(
        children: <Widget>[
          Text(
            "+${country.phoneCode}",
            style: TextStyle(
                fontSize: 15, color: Colors.grey),
          ),
          SizedBox(
            width: 7,
          ),
          CountryPickerUtils.getDefaultFlagImage(
              CountryPickerUtils.getCountryByPhoneCode(country.phoneCode)
          ),
          SizedBox(
            width: 7,
          ),
        ],
      ),
    );
  }
}
