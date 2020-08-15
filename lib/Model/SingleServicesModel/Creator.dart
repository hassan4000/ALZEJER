class Creator {
    int accessFailedCount;
    int age;
    String country;
    String creationDate;
    String email;
    bool emailConfirmed;
    String fireBaseId;
    String id;
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
    String sex;
    String socialState;
    String status;
    bool twoFactorEnabled;
    String type;
    String userName;
    String userRegistrationCode;
    String userSpecialCode;
    String userWorkBinding;
    bool verifiedInterpreter;

    Creator({this.accessFailedCount, this.age, this.country, this.creationDate, this.email, this.emailConfirmed, this.fireBaseId, this.id, this.jobDescription, this.joiningDate, this.lastModificationDate, this.lockoutEnabled, this.lockoutEndDateUtc, this.martialStatus, this.name, this.numbOfDreamsInOneDay, this.online, this.passwordHash, this.personalDescription, this.phoneNumber, this.phoneNumberConfirmed, this.pictureId, this.pointsBalance, this.securityStamp, this.sex, this.socialState, this.status, this.twoFactorEnabled, this.type, this.userName, this.userRegistrationCode, this.userSpecialCode, this.userWorkBinding, this.verifiedInterpreter});

    factory Creator.fromJson(Map<String, dynamic> json) {
        return Creator(
            accessFailedCount: json['AccessFailedCount'],
            age: json['Age'],
            country: json['Country'],
            creationDate: json['CreationDate'],
            email: json['Email'],
            emailConfirmed: json['EmailConfirmed'],
            fireBaseId: json['FireBaseId'],
            id: json['Id'],
            jobDescription: json['JobDescription'],
            joiningDate: json['JoiningDate'],
            lastModificationDate: json['LastModificationDate'],
            lockoutEnabled: json['LockoutEnabled'],
            lockoutEndDateUtc: json['LockoutEndDateUtc'],
            martialStatus: json['MartialStatus'],
            name: json['Name'],
            numbOfDreamsInOneDay: json['NumbOfDreamsInOneDay'],
            online: json['Online'],
            passwordHash: json['PasswordHash'],
            personalDescription: json['PersonalDescription'],
            phoneNumber: json['PhoneNumber'],
            phoneNumberConfirmed: json['PhoneNumberConfirmed'],
            pictureId: json['PictureId'],
            pointsBalance: json['PointsBalance'],
            securityStamp: json['SecurityStamp'],
            sex: json['Sex'],
            socialState: json['SocialState'],
            status: json['Status'],
            twoFactorEnabled: json['TwoFactorEnabled'],
            type: json['Type'],
            userName: json['UserName'],
            userRegistrationCode: json['UserRegistrationCode'],
            userSpecialCode: json['UserSpecialCode'],
            userWorkBinding: json['UserWorkBinding'],
            verifiedInterpreter: json['VerifiedInterpreter'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AccessFailedCount'] = this.accessFailedCount;
        data['Age'] = this.age;
        data['Country'] = this.country;
        data['CreationDate'] = this.creationDate;
        data['Email'] = this.email;
        data['EmailConfirmed'] = this.emailConfirmed;
        data['FireBaseId'] = this.fireBaseId;
        data['Id'] = this.id;
        data['JobDescription'] = this.jobDescription;
        data['JoiningDate'] = this.joiningDate;
        data['LastModificationDate'] = this.lastModificationDate;
        data['LockoutEnabled'] = this.lockoutEnabled;
        data['LockoutEndDateUtc'] = this.lockoutEndDateUtc;
        data['MartialStatus'] = this.martialStatus;
        data['Name'] = this.name;
        data['NumbOfDreamsInOneDay'] = this.numbOfDreamsInOneDay;
        data['Online'] = this.online;
        data['PasswordHash'] = this.passwordHash;
        data['PersonalDescription'] = this.personalDescription;
        data['phoneNumber'] = this.phoneNumber;
        data['PhoneNumberConfirmed'] = this.phoneNumberConfirmed;
        data['PictureId'] = this.pictureId;
        data['PointsBalance'] = this.pointsBalance;
        data['SecurityStamp'] = this.securityStamp;
        data['Sex'] = this.sex;
        data['SocialState'] = this.socialState;
        data['Status'] = this.status;
        data['TwoFactorEnabled'] = this.twoFactorEnabled;
        data['Type'] = this.type;
        data['UserName'] = this.userName;
        data['UserRegistrationCode'] = this.userRegistrationCode;
        data['UserSpecialCode'] = this.userSpecialCode;
        data['UserWorkBinding'] = this.userWorkBinding;
        data['VerifiedInterpreter'] = this.verifiedInterpreter;
        return data;
    }
}