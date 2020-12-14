import 'User.dart';

class UserWorkBinding {
    int attachmentId;
    String creationDate;
    String creator;
    String creatorId;
    String creatorName;
    int id;
    String lastModificationDate;
    String modifier;
    String modifierId;
    User user;
    String userId;
    int userWorkId;

    UserWorkBinding({this.attachmentId, this.creationDate, this.creator, this.creatorId, this.creatorName, this.id, this.lastModificationDate, this.modifier, this.modifierId, this.user, this.userId, this.userWorkId});

    factory UserWorkBinding.fromJson(Map<String, dynamic> json) {
        return UserWorkBinding(
            attachmentId: json['attachmentId'], 
            creationDate: json['creationDate'], 
            creator: json['creator'], 
            creatorId: json['creatorId'], 
            creatorName: json['creatorName'], 
            id: json['id'], 
            lastModificationDate: json['lastModificationDate'], 
            modifier: json['modifier'], 
            modifierId: json['modifierId'], 
            user: json['user'] != null ? User.fromJson(json['user']) : null, 
            userId: json['userId'], 
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
        data['userWorkId'] = this.userWorkId;
        if (this.user != null) {
            data['user'] = this.user.toJson();
        }
        return data;
    }
}