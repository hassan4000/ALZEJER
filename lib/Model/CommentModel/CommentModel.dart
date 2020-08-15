class CommentModel {
    String attachmentId;
    String creationDate;
    String creatorId;
    int id;
    String lastModificationDate;
    String modifierId;
    int serviceId;
    String text;
    String creatorName;

    CommentModel({this.creatorName,this.attachmentId, this.creationDate, this.creatorId, this.id, this.lastModificationDate, this.modifierId, this.serviceId, this.text});

    factory CommentModel.fromJson(Map<String, dynamic> json) {
        return CommentModel(
            attachmentId: json['AttachmentId'].toString(),
            creationDate: json['CreationDate'],
            creatorId: json['CreatorId'],
            id: json['id'], 
            lastModificationDate: json['LastModificationDate'],
            modifierId: json['modifierId'], 
            serviceId: json['ServiceId'],
            text: json['Text'],
            creatorName: json['CreatorName'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AttachmentId'] = this.attachmentId.toString();
        data['CreationDate'] = this.creationDate;
        data['CreatorId'] = this.creatorId;
        data['id'] = this.id;
        data['LastModificationDate'] = this.lastModificationDate;
        data['ModifierId'] = this.modifierId;
        data['ServiceId'] = this.serviceId;
        data['Text'] = this.text;
        data['CreatorName'] = this.creatorName;
        return data;
    }
}