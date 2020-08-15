

import 'UserWorkData.dart';

class UserWork {
    int attachmentId;
    String creationDate;
    String creator;
    String creatorId;
    int id;
    String lastModificationDate;
    String modifier;
    String modifierId;
   /* String user;*/
    String userId;
    UserWorkData userWork;
    int userWorkId;

    UserWork({this.attachmentId, this.creationDate, this.creator, this.creatorId, this.id, this.lastModificationDate, this.modifier, this.modifierId, this.userId, this.userWork, this.userWorkId});

    factory UserWork.fromJson(Map<String, dynamic> json) {
        return UserWork(
            attachmentId: json['AttachmentId'],
            creationDate: json['CreationDate'],
            creator: json['creator'], 
            creatorId: json['creatorId'], 
            id: json['id'], 
            lastModificationDate: json['lastModificationDate'], 
            modifier: json['modifier'], 
            modifierId: json['modifierId'], 
          /*  user: json['User'],*/
            userId: json['UserId'],
            userWork: json['UserWork'] != null ? UserWorkData.fromJson(json['UserWork']) : null,
            userWorkId: json['UserWorkId'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AttachmentId'] = this.attachmentId;
        data['CreationDate'] = this.creationDate;
        data['creator'] = this.creator;
        data['creatorId'] = this.creatorId;
        data['id'] = this.id;
        data['lastModificationDate'] = this.lastModificationDate;
        data['modifier'] = this.modifier;
        data['modifierId'] = this.modifierId;
     /*   data['User'] = this.user;*/
        data['UserId'] = this.userId;
        data['UserWorkId'] = this.userWorkId;
        if (this.userWork != null) {
            data['UserWork'] = this.userWork.toJson();
        }
        return data;
    }
}