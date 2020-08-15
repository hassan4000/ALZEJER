import 'package:faserholmak/Model/AllServicesModel/AllServicesData.dart';

class AllServicesModel {
    String odata_count;

    List<AllServicesData> value;

    AllServicesModel({this.odata_count, this.value});

    factory AllServicesModel.fromJson(Map<String, dynamic> json) {
        return AllServicesModel(
            odata_count: json['odata.count'],

            value: json['value'] != null ? (json['value'] as List).map((i) => AllServicesData.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['odata.count'] = this.odata_count;

        if (this.value != null) {
            data['value'] = this.value.map((v) => v.toJson()).toList();
        }
        return data;
    }
}