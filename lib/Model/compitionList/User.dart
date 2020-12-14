import 'UserWorkBindingX.dart';

class User {
    int accessFailedCount;
    int age;
    String country;
    String creationDate;
    String email;
    bool emailConfirmed;
    String fireBaseId;
    String id;
    String imageUrl;
    String jobDescription;
    String joiningDate;
    String lastModificationDate;
    bool lockoutEnabled;
    String lockoutEndDateUtc;
    String martialStatus;
    String name;
    int numbOfDreamsInOneDay;
    bool online;
    String passwordHash;
    String personalDescription;
    String phoneNumber;
    bool phoneNumberConfirmed;
    String pictureId;
    int pointsBalance;
    String securityStamp;
    int serviceProviderPoints;
    String sex;
    String socialState;
    String socialToken;
    String status;
    bool twoFactorEnabled;
    String type;
    String userName;
    String userRegistrationCode;
    String userSpecialCode;
    List<UserWorkBindingX> userWorkBinding;
    bool verifiedInterpreter;

    User({this.accessFailedCount, this.age, this.country, this.creationDate, this.email, this.emailConfirmed, this.fireBaseId, this.id, this.imageUrl, this.jobDescription, this.joiningDate, this.lastModificationDate, this.lockoutEnabled, this.lockoutEndDateUtc, this.martialStatus, this.name, this.numbOfDreamsInOneDay, this.online, this.passwordHash, this.personalDescription, this.phoneNumber, this.phoneNumberConfirmed, this.pictureId, this.pointsBalance, this.securityStamp, this.serviceProviderPoints, this.sex, this.socialState, this.socialToken, this.status, this.twoFactorEnabled, this.type, this.userName, this.userRegistrationCode, this.userSpecialCode, this.userWorkBinding, this.verifiedInterpreter});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            accessFailedCount: json['accessFailedCount'], 
            age: json['age'], 
            country: json['country'], 
            creationDate: json['creationDate'], 
            email: json['email'], 
            emailConfirmed: json['emailConfirmed'], 
            fireBaseId: json['fireBaseId'], 
            id: json['id'], 
            imageUrl: json['imageUrl'], 
            jobDescription: json['jobDescription'], 
            joiningDate: json['joiningDate'], 
            lastModificationDate: json['lastModificationDate'], 
            lockoutEnabled: json['lockoutEnabled'], 
            lockoutEndDateUtc: json['lockoutEndDateUtc'], 
            martialStatus: json['martialStatus'], 
            name: json['name'], 
            numbOfDreamsInOneDay: json['numbOfDreamsInOneDay'], 
            online: json['online'], 
            passwordHash: json['passwordHash'], 
            personalDescription: json['personalDescription'], 
            phoneNumber: json['phoneNumber'], 
            phoneNumberConfirmed: json['phoneNumberConfirmed'], 
            pictureId: json['pictureId'], 
            pointsBalance: json['pointsBalance'], 
            securityStamp: json['securityStamp'], 
            serviceProviderPoints: json['serviceProviderPoints'], 
            sex: json['sex'], 
            socialState: json['socialState'], 
            socialToken: json['socialToken'], 
            status: json['status'], 
            twoFactorEnabled: json['twoFactorEnabled'], 
            type: json['type'], 
            userName: json['userName'], 
            userRegistrationCode: json['userRegistrationCode'], 
            userSpecialCode: json['userSpecialCode'], 
            userWorkBinding: json['userWorkBinding'] != null ? (json['userWorkBinding'] as List).map((i) => UserWorkBindingX.fromJson(i)).toList() : null, 
            verifiedInterpreter: json['verifiedInterpreter'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['accessFailedCount'] = this.accessFailedCount;
        data['age'] = this.age;
        data['country'] = this.country;
        data['creationDate'] = this.creationDate;
        data['email'] = this.email;
        data['emailConfirmed'] = this.emailConfirmed;
        data['fireBaseId'] = this.fireBaseId;
        data['id'] = this.id;
        data['imageUrl'] = this.imageUrl;
        data['jobDescription'] = this.jobDescription;
        data['joiningDate'] = this.joiningDate;
        data['lastModificationDate'] = this.lastModificationDate;
        data['lockoutEnabled'] = this.lockoutEnabled;
        data['lockoutEndDateUtc'] = this.lockoutEndDateUtc;
        data['martialStatus'] = this.martialStatus;
        data['name'] = this.name;
        data['numbOfDreamsInOneDay'] = this.numbOfDreamsInOneDay;
        data['online'] = this.online;
        data['passwordHash'] = this.passwordHash;
        data['personalDescription'] = this.personalDescription;
        data['phoneNumber'] = this.phoneNumber;
        data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
        data['pictureId'] = this.pictureId;
        data['pointsBalance'] = this.pointsBalance;
        data['securityStamp'] = this.securityStamp;
        data['serviceProviderPoints'] = this.serviceProviderPoints;
        data['sex'] = this.sex;
        data['socialState'] = this.socialState;
        data['socialToken'] = this.socialToken;
        data['status'] = this.status;
        data['twoFactorEnabled'] = this.twoFactorEnabled;
        data['type'] = this.type;
        data['userName'] = this.userName;
        data['userRegistrationCode'] = this.userRegistrationCode;
        data['userSpecialCode'] = this.userSpecialCode;
        data['verifiedInterpreter'] = this.verifiedInterpreter;
        if (this.userWorkBinding != null) {
            data['userWorkBinding'] = this.userWorkBinding.map((v) => v.toJson()).toList();
        }
        return data;
    }
}