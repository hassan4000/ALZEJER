import 'TransactionRecordData.dart';

class TransactionRecordModel {

    List<TransactionRecordData> value;

    TransactionRecordModel({this.value});

    factory TransactionRecordModel.fromJson(Map<String, dynamic> json) {
        return TransactionRecordModel(
            value: json['value'] != null ? (json['value'] as List).map((i) => TransactionRecordData.fromJson(i)).toList() : null,
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