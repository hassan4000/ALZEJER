class TransactionRecordData {
    double amount;
    String attachmentId;
    String bank;
    String creationDate;
    String creatorId;
    String creatorName;
    int id;
    String lastModificationDate;
    String method;
    String modifierId;
    String status;
    String userId;

    TransactionRecordData({this.amount, this.attachmentId, this.bank, this.creationDate, this.creatorId, this.creatorName, this.id, this.lastModificationDate, this.method, this.modifierId, this.status, this.userId});

    factory TransactionRecordData.fromJson(Map<String, dynamic> json) {
        return TransactionRecordData(
            amount: json['Amount'],
            attachmentId: json['AttachmentId'],
            bank: json['Bank'],
            creationDate: json['CreationDate'],
            creatorId: json['CreatorId'],
            creatorName: json['CreatorName'],
            id: json['id'], 
            lastModificationDate: json['LastModificationDate'],
            method: json['Method'],
            modifierId: json['ModifierId'],
            status: json['Status'],
            userId: json['UserId'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['Amount'] = this.amount;
        data['AttachmentId'] = this.attachmentId;
        data['Bank'] = this.bank;
        data['CreationDate'] = this.creationDate;
        data['CreatorId'] = this.creatorId;
        data['CreatorName'] = this.creatorName;
        data['id'] = this.id;
        data['LastModificationDate'] = this.lastModificationDate;
        data['Method'] = this.method;
        data['ModifierId'] = this.modifierId;
        data['Status'] = this.status;
        data['UserId'] = this.userId;
        return data;
    }
}