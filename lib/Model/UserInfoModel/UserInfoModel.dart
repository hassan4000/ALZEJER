import 'package:faserholmak/Model/UserInfoModel/UserWork.dart';
class UserInfoModel {
    int age;
    double avgServicesInOneDay;
    String country;
    String email;
    String fireBaseId;
    bool hasRegistered;
    String id;
    String jobDescription;
    String joiningDate;
    String loginProvider;
    String martialStatus;
    String name;
    int numberOfActiveServices;
    int numberOfDoneServices;
    String personalDescription;
    String phoneNumber;
    String pictureId;
    String sex;
    String socialStatus;
    double speed;
    String status;
    String type;
    String userName;
    List<String> userRoles;
    List<UserWork> userWorks;
    bool verifiedUser;
    String userRegistrationCode;
    String userSpecialCode;
    int pointsBalance;
    double totalBalance ;
    double availableBalance ;
    double suspendedBalance ;

    UserInfoModel({this.availableBalance,this.suspendedBalance,this.totalBalance,this.age, this.avgServicesInOneDay, this.country, this.email, this.fireBaseId, this.hasRegistered, this.id, this.jobDescription, this.joiningDate, this.loginProvider, this.martialStatus, this.name, this.numberOfActiveServices, this.numberOfDoneServices, this.personalDescription, this.phoneNumber, this.pictureId, this.sex, this.socialStatus, this.speed, this.status, this.type, this.userName, this.userRoles, this.userWorks, this.verifiedUser,this.userRegistrationCode,this.userSpecialCode,this.pointsBalance});

    factory UserInfoModel.fromJson(Map<String, dynamic> json) {
        return UserInfoModel(
            age: json['Age'],
            avgServicesInOneDay: json['AvgServicesInOneDay'],
            country: json['Country'],
            email: json['Email'],
            fireBaseId: json['FireBaseId'],
            hasRegistered: json['HasRegistered'],
            id: json['Id'],
            jobDescription: json['JobDescription'],
            joiningDate: json['JoiningDate'],
            loginProvider: json['LoginProvider'],
            martialStatus: json['MartialStatus'],
            name: json['Name'],
            numberOfActiveServices: json['NumberOfActiveServices'],
            numberOfDoneServices: json['NumberOfDoneServices'],
            personalDescription: json['PersonalDescription'],
            phoneNumber: json['phoneNumber'], 
            pictureId: json['PictureId'],
            sex: json['Sex'],
            socialStatus: json['SocialStatus'],
            speed: json['Speed'],
            status: json['Status'],
            type: json['Type'],
            userName: json['UserName'],
            userRoles: json['UserRoles'] != null ? new List<String>.from(json['UserRoles']) : null,
            userWorks: json['UserWorks'] != null ? (json['UserWorks'] as List).map((i) => UserWork.fromJson(i)).toList() : null,
            verifiedUser: json['VerifiedUser'],
            userRegistrationCode: json['UserRegistrationCode'].toString(),
            userSpecialCode: json['UserSpecialCode'].toString(),
            pointsBalance: json['PointsBalance'],
            totalBalance : json['TotalBalance'],
            availableBalance  : json['AvailableBalance'],
            suspendedBalance  : json['SuspendedBalance'],

        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['Age'] = this.age;
        data['AvgServicesInOneDay'] = this.avgServicesInOneDay;
        data['Country'] = this.country;
        data['Email'] = this.email;
        data['FireBaseId'] = this.fireBaseId;
        data['HasRegistered'] = this.hasRegistered;
        data['Id'] = this.id;
        data['JobDescription'] = this.jobDescription;
        data['JoiningDate'] = this.joiningDate;
        data['LoginProvider'] = this.loginProvider;
        data['MartialStatus'] = this.martialStatus;
        data['Name'] = this.name;
        data['NumberOfActiveServices'] = this.numberOfActiveServices;
        data['NumberOfDoneServices'] = this.numberOfDoneServices;
        data['PersonalDescription'] = this.personalDescription;
        data['phoneNumber'] = this.phoneNumber;
        data['PictureId'] = this.pictureId;
        data['Sex'] = this.sex;
        data['SocialStatus'] = this.socialStatus;
        data['Speed'] = this.speed;
        data['Status'] = this.status;
        data['Yype'] = this.type;
        data['UserName'] = this.userName;
        data['VerifiedUser'] = this.verifiedUser;
        data['UserRegistrationCode'] = this.userRegistrationCode.toString();
        data['UserSpecialCode'] = this.userSpecialCode.toString();
        data['PointsBalance'] = this.pointsBalance;
        data['TotalBalance'] = this.totalBalance ;
        data['AvailableBalance'] = this.availableBalance  ;
        data['SuspendedBalance'] = this.suspendedBalance   ;
        if (this.userRoles != null) {
            data['UserRoles'] = this.userRoles;
        }
        if (this.userWorks != null) {
            data['UserWorks'] = this.userWorks.map((v) => v.toJson()).toList();
        }
        return data;
    }
}