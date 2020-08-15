import 'package:faserholmak/Model/WorkTypeUser/Value.dart';

class UserWorkWithNumber {
    int userCount;
    Value userWork;

    UserWorkWithNumber({this.userCount, this.userWork});

    factory UserWorkWithNumber.fromJson(Map<String, dynamic> json) {
        return UserWorkWithNumber(
            userCount: json['UserCount'],
            userWork: json['UserWork'] != null ? Value.fromJson(json['UserWork']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['UserCount'] = this.userCount;
        if (this.userWork != null) {
            data['UserWork'] = this.userWork.toJson();
        }
        return data;
    }
}