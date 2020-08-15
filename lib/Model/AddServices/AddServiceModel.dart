class AddServiceModel {
    String country;
    String description;
    bool didYouExorcism;
    String dreamDate;
    bool haveYouPrayedBeforeTheDream;
    bool isThereWakefulness;
    String kidsStatus;
    String name;
    bool privateService;
    String privateServicePrice;
    bool publicServiceAction;
    String regligionStatus;
    int servicePathId;
    String serviceProviderId;
    String sex;
    String socialStatus;
    int userWorkId;
    String jobStatus;
    String dreamDateText;

    AddServiceModel({this.country, this.description, this.didYouExorcism, this.dreamDate, this.haveYouPrayedBeforeTheDream, this.isThereWakefulness, this.kidsStatus, this.name, this.privateService, this.privateServicePrice, this.publicServiceAction, this.regligionStatus, this.servicePathId, this.serviceProviderId, this.sex, this.socialStatus, this.userWorkId,this.jobStatus,this.dreamDateText});

    factory AddServiceModel.fromJson(Map<String, dynamic> json) {
        return AddServiceModel(
            country: json['Country'],
            description: json['Description'],
            didYouExorcism: json['DidYouExorcism'],
            dreamDate: json['DreamDate'],
            haveYouPrayedBeforeTheDream: json['HaveYouPrayedBeforeTheDream'],
            isThereWakefulness: json['IsThereWakefulness'],
            kidsStatus: json['KidsStatus'],
            name: json['Name'],
            privateService: json['PrivateService'],
            privateServicePrice: json['PrivateServicePrice'],
            publicServiceAction: json['PublicServiceAction'],
            regligionStatus: json['RegligionStatus'],
            servicePathId: json['ServicePathId'],
            serviceProviderId: json['ServiceProviderId'],
            sex: json['Sex'],
            socialStatus: json['SocialStatus'],
            userWorkId: json['UserWorkId'],
            jobStatus: json['JobStatus'],
            dreamDateText: json['DreamDateText']
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['Country'] = this.country;
        data['Description'] = this.description;
        data['DidYouExorcism'] = this.didYouExorcism;
        data['DreamDate'] = this.dreamDate;
        data['HaveYouPrayedBeforeTheDream'] = this.haveYouPrayedBeforeTheDream;
        data['IsThereWakefulness'] = this.isThereWakefulness;
        data['KidsStatus'] = this.kidsStatus;
        data['Name'] = this.name;
        data['PrivateService'] = this.privateService;
        data['PrivateServicePrice'] = this.privateServicePrice;
        data['PublicServiceAction'] = this.publicServiceAction;
        data['RegligionStatus'] = this.regligionStatus;
        data['ServicePathId'] = this.servicePathId;
        data['ServiceProviderId'] = this.serviceProviderId;
        data['Sex'] = this.sex;
        data['SocialStatus'] = this.socialStatus;
        data['UserWorkId'] = this.userWorkId;
        data['JobStatus'] = this.jobStatus;
        data['DreamDateText'] = this.dreamDateText;
        return data;
    }
}