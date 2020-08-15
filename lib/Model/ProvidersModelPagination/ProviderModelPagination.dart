

import 'package:faserholmak/Model/UserInfoModel/UserInfoModel.dart';

class ProviderModelPagination{
  int odata_count;

  List<UserInfoModel> value;

  ProviderModelPagination({this.odata_count, this.value});

  factory ProviderModelPagination.fromJson(Map<String, dynamic> json) {
    return ProviderModelPagination(
      odata_count: json['Count'],

      value: json['Users'] != null ? (json['Users'] as List).map((i) => UserInfoModel.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Count'] = this.odata_count;

    if (this.value != null) {
      data['Users'] = this.value.map((v) => v.toJson()).toList();
    }
    return data;
  }
}