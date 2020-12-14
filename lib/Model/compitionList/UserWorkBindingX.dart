class UserWorkBindingX {
    int attachmentId;
    String creationDate;
    String creator;
    String creatorId;
    String creatorName;
    int id;
    String lastModificationDate;
    String modifier;
    String modifierId;
    String userId;
    String userWork;
    int userWorkId;

    UserWorkBindingX({this.attachmentId, this.creationDate, this.creator, this.creatorId, this.creatorName, this.id, this.lastModificationDate, this.modifier, this.modifierId, this.userId, this.userWork, this.userWorkId});

    factory UserWorkBindingX.fromJson(Map<String, dynamic> json) {
        return UserWorkBindingX(
            attachmentId: json['attachmentId'], 
            creationDate: json['creationDate'], 
            creator: json['creator'], 
            creatorId: json['creatorId'], 
            creatorName: json['creatorName'], 
            id: json['id'], 
            lastModificationDate: json['lastModificationDate'], 
            modifier: json['modifier'], 
            modifierId: json['modifierId'], 
            userId: json['userId'], 
            userWork: json['userWork'], 
            userWorkId: json['userWorkId'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['attachmentId'] = this.attachmentId;
        data['creationDate'] = this.creationDate;
        data['creator'] = this.creator;
        data['creatorId'] = this.creatorId;
        data['creatorName'] = this.creatorName;
        data['id'] = this.id;
        data['lastModificationDate'] = this.lastModificationDate;
        data['modifier'] = this.modifier;
        data['modifierId'] = this.modifierId;
        data['userId'] = this.userId;
        data['userWork'] = this.userWork;
        data['userWorkId'] = this.userWorkId;
        return data;
    }
}