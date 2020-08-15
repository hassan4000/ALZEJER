import 'package:faserholmak/Model/CommentModel/CommentModel.dart';

import 'Creator.dart';
import 'Modifier.dart';
import 'ServicePath.dart';
import 'ServiceProvider.dart';
import 'UserWork.dart';

class SingleServicesModel {
    int attachmentId;
    String avgWaitingTime;
    List<CommentModel> comments;
    String country;
    String creationDate;
    Creator creator;
    String creatorId;
    String description;
    bool didYouExorcism;
    String dreamDate;
    String explanation;
    String explanationDate;
    bool haveYouPrayedBeforeTheDream;
    int id;
    bool isThereWakefulness;
    String jobStatus;
    String kidsStatus;
    String lastModificationDate;
    Modifier modifier;
    String modifierId;
    String name;
    int numberOfAllPeopleWaiting;
    int numberOfLikes;
    int numberOfRemainingPeople;
    int numberOfViews;
    bool privateService;
    double privateServicePrice;
    bool publicServiceAction;
    String regligionStatus;
    ServicePath servicePath;
    int servicePathId;
    ServiceProvider serviceProvider;
    String serviceProviderId;
    String sex;
    String socialStatus;
    String status;
    UserWork userWork;
    String serviceProviderToken;
    String clientToken;
    int userWorkId;

    SingleServicesModel({this.serviceProviderToken,this.clientToken,this.attachmentId, this.avgWaitingTime, this.comments, this.country, this.creationDate, this.creator, this.creatorId, this.description, this.didYouExorcism, this.dreamDate, this.explanation, this.explanationDate, this.haveYouPrayedBeforeTheDream, this.id, this.isThereWakefulness, this.jobStatus, this.kidsStatus, this.lastModificationDate, this.modifier, this.modifierId, this.name, this.numberOfAllPeopleWaiting, this.numberOfLikes, this.numberOfRemainingPeople, this.numberOfViews, this.privateService, this.privateServicePrice, this.publicServiceAction, this.regligionStatus, this.servicePath, this.servicePathId, this.serviceProvider, this.serviceProviderId, this.sex, this.socialStatus, this.status, this.userWork, this.userWorkId});

    factory SingleServicesModel.fromJson(Map<String, dynamic> json) {
        return SingleServicesModel(
            attachmentId: json['AttachmentId'],
            avgWaitingTime: json['AvgWaitingTime'],
            comments: json['Comments'] != null ? (json['Comments'] as List).map((i) => CommentModel.fromJson(i)).toList() : null,
            country: json['Country'],
            creationDate: json['CreationDate'],
            creator: json['Creator'] != null ? Creator.fromJson(json['Creator']) : null,
            creatorId: json['CreatorId'],
            description: json['Description'],
            didYouExorcism: json['DidYouExorcism'],
            dreamDate: json['DreamDate'],
            explanation: json['Explanation'],
            explanationDate: json['ExplanationDate'],
            haveYouPrayedBeforeTheDream: json['HaveYouPrayedBeforeTheDream'],
            id: json['Id'],
            isThereWakefulness: json['IsThereWakefulness'],
            jobStatus: json['JobStatus'],
            kidsStatus: json['KidsStatus'],
            lastModificationDate: json['LastModificationDate'],
            modifier: json['Modifier'] != null ? Modifier.fromJson(json['Modifier']) : null,
            modifierId: json['ModifierId'],
            name: json['Name'],
            numberOfAllPeopleWaiting: json['NumberOfAllPeopleWaiting'],
            numberOfLikes: json['numberOfLikes'], 
            numberOfRemainingPeople: json['NumberOfRemainingPeople'],
            numberOfViews: json['numberOfViews'], 
            privateService: json['PrivateService'],
            privateServicePrice: json['PrivateServicePrice'],
            publicServiceAction: json['PublicServiceAction'],
            regligionStatus: json['RegligionStatus'],
            servicePath: json['ServicePath'] != null ? ServicePath.fromJson(json['ServicePath']) : null,
            servicePathId: json['ServicePathId'],
            serviceProvider: json['ServiceProvider'] != null ? ServiceProvider.fromJson(json['ServiceProvider']) : null,
            serviceProviderId: json['ServiceProviderId'],
            sex: json['Sex'],
            socialStatus: json['SocialStatus'],
            status: json['Status'],
            serviceProviderToken: json['ServiceProviderToken'],
            clientToken: json['ClientToken'],
            userWork: json['UserWork'] != null ? UserWork.fromJson(json['UserWork']) : null,
            userWorkId: json['UserWorkId'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AttachmentId'] = this.attachmentId;
        data['AvgWaitingTime'] = this.avgWaitingTime;
        data['Country'] = this.country;
        data['CreationDate'] = this.creationDate;
        data['CreatorId'] = this.creatorId;
        data['Description'] = this.description;
        data['DidYouExorcism'] = this.didYouExorcism;
        data['DreamDate'] = this.dreamDate;
        data['Explanation'] = this.explanation;
        data['ExplanationDate'] = this.explanationDate;
        data['HaveYouPrayedBeforeTheDream'] = this.haveYouPrayedBeforeTheDream;
        data['Id'] = this.id;
        data['IsThereWakefulness'] = this.isThereWakefulness;
        data['JobStatus'] = this.jobStatus;
        data['KidsStatus'] = this.kidsStatus;
        data['LastModificationDate'] = this.lastModificationDate;
        data['ModifierId'] = this.modifierId;
        data['Name'] = this.name;
        data['NumberOfAllPeopleWaiting'] = this.numberOfAllPeopleWaiting;
        data['numberOfLikes'] = this.numberOfLikes;
        data['NumberOfRemainingPeople'] = this.numberOfRemainingPeople;
        data['numberOfViews'] = this.numberOfViews;
        data['PrivateService'] = this.privateService;
        data['PrivateServicePrice'] = this.privateServicePrice;
        data['PublicServiceAction'] = this.publicServiceAction;
        data['RegligionStatus'] = this.regligionStatus;
        data['ServicePathId'] = this.servicePathId;
        data['ServiceProviderId'] = this.serviceProviderId;
        data['Sex'] = this.sex;
        data['SocialStatus'] = this.socialStatus;
        data['Status'] = this.status;
        data['ServiceProviderToken'] = this.serviceProviderToken;
        data['ClientToken'] = this.clientToken;
        data['UserWorkId'] = this.userWorkId;
        if (this.comments != null) {
            data['Comments'] = this.comments.map((v) => v.toJson()).toList();
        }
        if (this.creator != null) {
            data['Creator'] = this.creator.toJson();
        }
        if (this.modifier != null) {
            data['Modifier'] = this.modifier.toJson();
        }
        if (this.servicePath != null) {
            data['ServicePath'] = this.servicePath.toJson();
        }
        if (this.serviceProvider != null) {
            data['ServiceProvider'] = this.serviceProvider.toJson();
        }
        if (this.userWork != null) {
            data['UserWork'] = this.userWork.toJson();
        }
        return data;
    }
}