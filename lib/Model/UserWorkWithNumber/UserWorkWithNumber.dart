import 'package:faserholmak/Model/WorkTypeUser/Value.dart';

class UserWorkWithNumber {
    int userCount;
    Value userWork;
    int doneServices;

    UserWorkWithNumber({this.userCount, this.userWork,this.doneServices});

    factory UserWorkWithNumber.fromJson(Map<String, dynamic> json) {
        return UserWorkWithNumber(
            userCount: json['UserCount'],
            doneServices: json['DoneServices'],
            userWork: json['UserWork'] != null ? Value.fromJson(json['UserWork']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['UserCount'] = this.userCount;
        data['DoneServices'] = this.doneServices;
        if (this.userWork != null) {
            data['UserWork'] = this.userWork.toJson();
        }
        return data;
    }
}