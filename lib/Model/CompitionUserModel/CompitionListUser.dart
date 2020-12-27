import 'ServiceProvider.dart';

class CompitionListUser {
    int attachmentId;
    double availableBalance;
    double avgServicesInOneDay;
    int competitionId;
    String creationDate;
    String creator;
    String creatorId;
    String creatorName;
    int id;
    String lastModificationDate;
    String modifier;
    String modifierId;
    int numberOfActiveServices;
    int numberOfDoneServices;
    int pointsBalance;
    int rank;
    double rating;
    ServiceProvider serviceProvider;
    String serviceProviderId;
    double speed;
    double suspendedBalance;
    double totalBalance;

    CompitionListUser({this.attachmentId, this.availableBalance, this.avgServicesInOneDay, this.competitionId, this.creationDate, this.creator, this.creatorId, this.creatorName, this.id, this.lastModificationDate, this.modifier, this.modifierId, this.numberOfActiveServices, this.numberOfDoneServices, this.pointsBalance, this.rank, this.rating, this.serviceProvider, this.serviceProviderId, this.speed, this.suspendedBalance, this.totalBalance});

    factory CompitionListUser.fromJson(Map<String, dynamic> json) {
        return CompitionListUser(
            attachmentId: json['AttachmentId'],
            availableBalance: json['AvailableBalance'],
            avgServicesInOneDay: json['AvgServicesInOneDay'],
            competitionId: json['CompetitionId'],
            creationDate: json['CreationDate'],
            creator: json['Creator'],
            creatorId: json['CreatorId'],
            creatorName: json['CreatorName'],
            id: json['id'], 
            lastModificationDate: json['LastModificationDate'],
            modifier: json['Modifier'],
            modifierId: json['ModifierId'],
            numberOfActiveServices: json['NumberOfActiveServices'],
            numberOfDoneServices: json['NumberOfDoneServices'],
            pointsBalance: json['PointsBalance'],
            rank: json['rank'],
            rating: json['Rating'],
            serviceProvider: json['ServiceProvider'] != null ? ServiceProvider.fromJson(json['ServiceProvider']) : null,
            serviceProviderId: json['ServiceProviderId'],
            speed: json['Speed'],
            suspendedBalance: json['SuspendedBalance'],
            totalBalance: json['TotalBalance'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AttachmentId'] = this.attachmentId;
        data['AvailableBalance'] = this.availableBalance;
        data['AvgServicesInOneDay'] = this.avgServicesInOneDay;
        data['CompetitionId'] = this.competitionId;
        data['CreationDate'] = this.creationDate;
        data['Creator'] = this.creator;
        data['CreatorId'] = this.creatorId;
        data['CreatorName'] = this.creatorName;
        data['id'] = this.id;
        data['LastModificationDate'] = this.lastModificationDate;
        data['Modifier'] = this.modifier;
        data['ModifierId'] = this.modifierId;
        data['NumberOfActiveServices'] = this.numberOfActiveServices;
        data['NumberOfDoneServices'] = this.numberOfDoneServices;
        data['PointsBalance'] = this.pointsBalance;
        data['rank'] = this.rank;
        data['Rating'] = this.rating;
        data['ServiceProviderId'] = this.serviceProviderId;
        data['Speed'] = this.speed;
        data['SuspendedBalance'] = this.suspendedBalance;
        data['TotalBalance'] = this.totalBalance;
        if (this.serviceProvider != null) {
            data['ServiceProvider'] = this.serviceProvider.toJson();
        }
        return data;
    }
}