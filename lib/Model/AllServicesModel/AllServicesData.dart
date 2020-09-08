import 'package:faserholmak/Model/AllServicesModel/MyServicesProvider.dart';
import 'package:faserholmak/Model/CommentModel/CommentModel.dart';
import 'package:faserholmak/Model/SingleServicesModel/ServiceProvider.dart';

class AllServicesData {
    String attachmentId;
    String country;
    String creationDate;
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
    String modifierId;
    String name;
    String numberOfLikes;
    String numberOfViews;
    bool privateService;
    double privateServicePrice;
    bool publicServiceAction;
    String regligionStatus;
    int servicePathId;
    String serviceProviderId;
    String sex;
    String socialStatus;
    String status;
    int userWorkId;
    String ratingDate;
    String ratingMessage;
    int userRating;
    List <CommentModel> commentList;
    bool showLove;
    MyServicesProvider serviceProvider;

    AllServicesData({this.serviceProvider,this.showLove=false,this.userRating,this.ratingDate,this.ratingMessage,this.attachmentId, this.country, this.creationDate, this.creatorId, this.description, this.didYouExorcism, this.dreamDate, this.explanation, this.explanationDate, this.haveYouPrayedBeforeTheDream, this.id, this.isThereWakefulness, this.jobStatus, this.kidsStatus, this.lastModificationDate, this.modifierId, this.name, this.numberOfLikes, this.numberOfViews, this.privateService, this.privateServicePrice, this.publicServiceAction, this.regligionStatus, this.servicePathId, this.serviceProviderId, this.sex, this.socialStatus, this.status, this.userWorkId,this.commentList});

    factory AllServicesData.fromJson(Map<String, dynamic> json) {
        return AllServicesData(
            attachmentId: json['AttachmentId'].toString(),
            country: json['Country'],
            creationDate: json['CreationDate'],
            creatorId: json['CreatorId'],
            description: json['Description'],
            didYouExorcism: json['DidYouExorcism'],
            dreamDate: json['DreamDate'],
            explanation: json['Explanation'],
            explanationDate: json['ExplanationDate'],
            haveYouPrayedBeforeTheDream: json['HaveYouPrayedBeforeTheDream'],
            id: json['id'], 
            isThereWakefulness: json['IsThereWakefulness'],
            jobStatus: json['JobStatus'],
            kidsStatus: json['KidsStatus'],
            lastModificationDate: json['LastModificationDate'],
            modifierId: json['ModifierId'],
            name: json['Name'],
            numberOfLikes: json['numberOfLikes'].toString(),
            numberOfViews: json['numberOfViews'].toString(),
            privateService: json['PrivateService'],
            privateServicePrice: json['PrivateServicePrice'],
            publicServiceAction: json['PublicServiceAction'],
            regligionStatus: json['RegligionStatus'],
            servicePathId: json['ServicePathId'],
            serviceProviderId: json['ServiceProviderId'],
            sex: json['Sex'],
            socialStatus: json['SocialStatus'],
            status: json['Status'],
            userWorkId: json['UserWorkId'],
            userRating: json['UserRating'],
            ratingDate: json['RatingDate'],
            ratingMessage: json['RatingMessage'],
            serviceProvider: json['ServiceProvider'] != null ? MyServicesProvider.fromJson(json['ServiceProvider']) : null,
            commentList: json['Comments'] != null ? (json['Comments'] as List).map((i) => CommentModel.fromJson(i)).toList() : null,


        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AttachmentId'] = this.attachmentId.toString();
        data['Country'] = this.country;
        data['CreationDate'] = this.creationDate;
        data['CreatorId'] = this.creatorId;
        data['Description'] = this.description;
        data['DidYouExorcism'] = this.didYouExorcism;
        data['DreamDate'] = this.dreamDate;
        data['Explanation'] = this.explanation;
        data['ExplanationDate'] = this.explanationDate;
        data['HaveYouPrayedBeforeTheDream'] = this.haveYouPrayedBeforeTheDream;
        data['id'] = this.id;
        data['IsThereWakefulness'] = this.isThereWakefulness;
        data['JobStatus'] = this.jobStatus;
        data['KidsStatus'] = this.kidsStatus;
        data['LastModificationDate'] = this.lastModificationDate;
        data['ModifierId'] = this.modifierId;
        data['Name'] = this.name;
        data['numberOfLikes'] = this.numberOfLikes.toString();
        data['numberOfViews'] = this.numberOfViews.toString();
        data['PrivateService'] = this.privateService;
        data['PrivateServicePrice'] = this.privateServicePrice;
        data['PublicServiceAction'] = this.publicServiceAction;
        data['RegligionStatus'] = this.regligionStatus;
        data['ServicePathId'] = this.servicePathId;
        data['ServiceProviderId'] = this.serviceProviderId;
        data['Sex'] = this.sex;
        data['SocialStatus'] = this.socialStatus;
        data['Status'] = this.status;
        data['UserWorkId'] = this.userWorkId;
        data['UserRating'] = this.userRating;
        data['RatingDate'] = this.ratingDate;
        data['RatingMessage'] = this.ratingMessage;
        if (this.commentList != null) {
            data['Comments'] = this.commentList.map((v) => v.toJson()).toList();
        }
      /*  if (this.serviceProvider != null) {
            data['ServiceProvider'] = this.serviceProvider.toJson();
        }*/
        return data;
    }
}