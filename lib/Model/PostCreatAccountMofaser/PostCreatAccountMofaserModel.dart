import 'package:faserholmak/Model/WorkTypeUser/Value.dart';

class PostCreatAccountMofaserModel {
    int age;
    String confirmPassword;
    String country;
    String email;
    String jobDescription;
    String martialStatus;
    String name;
    String password;
    String personalDescription;
    String phoneNumber;
    String pictureId;
    String sex;
    String type;
    List<Value> userWork;
    String username;
    String socialState;

    PostCreatAccountMofaserModel({this.socialState="Normal",this.age, this.confirmPassword, this.country, this.email, this.jobDescription, this.martialStatus, this.name, this.password, this.personalDescription, this.phoneNumber, this.pictureId, this.sex, this.type, this.userWork, this.username});

    factory PostCreatAccountMofaserModel.fromJson(Map<String, dynamic> json) {
        return PostCreatAccountMofaserModel(
            age: json['age'], 
            confirmPassword: json['confirmPassword'], 
            country: json['country'], 
            email: json['email'], 
            jobDescription: json['jobDescription'], 
            martialStatus: json['martialStatus'], 
            name: json['name'], 
            password: json['password'], 
            personalDescription: json['personalDescription'], 
            phoneNumber: json['phoneNumber'], 
            pictureId: json['pictureId'], 
            sex: json['sex'], 
            type: json['type'], 
            userWork: json['UserWork'] != null ? (json['UserWork'] as List).map((i) => Value.fromJson(i)).toList() : null,
            username: json['username'],
            socialState: json['SocialState'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['age'] = this.age;
        data['confirmPassword'] = this.confirmPassword;
        data['country'] = this.country;
        data['email'] = this.email;
        data['jobDescription'] = this.jobDescription;
        data['martialStatus'] = this.martialStatus;
        data['name'] = this.name;
        data['password'] = this.password;
        data['personalDescription'] = this.personalDescription;
        data['phoneNumber'] = this.phoneNumber;
        data['pictureId'] = this.pictureId;
        data['sex'] = this.sex;
        data['type'] = this.type;
        data['SocialState'] = this.socialState;
        data['username'] = this.username;
        if (this.userWork != null) {
            data['UserWork'] = this.userWork.map((v) => v.toJson()).toList();
        }
        return data;
    }
}