
import 'package:faserholmak/Model/WorkTypeUser/Value.dart';

class WorkTypeModel {
    List<Value> value;

    WorkTypeModel({ this.value});

    factory WorkTypeModel.fromJson(Map<String, dynamic> json) {
        return WorkTypeModel(
            value: json['value'] != null ? (json['value'] as List).map((i) => Value.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.value != null) {
            data['value'] = this.value.map((v) => v.toJson()).toList();
        }
        return data;
    }
}