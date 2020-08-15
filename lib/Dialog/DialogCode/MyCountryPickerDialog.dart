import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

class MyCountryPickerDialog extends StatelessWidget {
  final String searchHint;
  final String selectHint;

  final ValueChanged<Country>onValuePicked;




  MyCountryPickerDialog({
    this.searchHint="Search...",
    this.selectHint="Select your country code",
    this.onValuePicked
    });

  @override
  Widget build(BuildContext context) {
    return CountryPickerDialog(
        titlePadding: EdgeInsets.all(8.0),
        searchCursorColor: Colors.black,
        searchInputDecoration: InputDecoration(hintText: searchHint==null?'Search...':searchHint),
        isSearchable: true,
        title: Text(selectHint==null?'Select your country code':selectHint),
        onValuePicked: onValuePicked,
        itemBuilder: (Country country) {
          return Container(
            child: Row(
              children: <Widget>[
                CountryPickerUtils.getDefaultFlagImage(country),
                SizedBox(
                  width: 16.0,
                ),
                Text("+${country.phoneCode}(${country.isoCode})"),
              ],
            ),
          );
        });
  }
}
