class AllPaymentToShowModel {
    double amount;
    int attachmentId;
    String creationDate;
    String creator;
    String creatorId;
    String creatorName;
    String currency;
    int id;
    String lastModificationDate;
    String method;
    String modifier;
    String modifierId;
    String service;
    int serviceId;
    int serviceProviderId;
    String status;

    AllPaymentToShowModel({this.amount, this.attachmentId, this.creationDate, this.creator, this.creatorId, this.creatorName, this.currency, this.id, this.lastModificationDate, this.method, this.modifier, this.modifierId, this.service, this.serviceId, this.serviceProviderId, this.status});

    factory AllPaymentToShowModel.fromJson(Map<String, dynamic> json) {
        return AllPaymentToShowModel(
            amount: json['Amount'],
            attachmentId: json['AttachmentId'],
            creationDate: json['CreationDate'],
            creator: json['Creator'],
            creatorId: json['CreatorId'],
            creatorName: json['CreatorName'],
            currency: json['Currency'],
            id: json['id'], 
            lastModificationDate: json['LastModificationDate'],
            method: json['Method'],
            modifier: json['Modifier'],
            modifierId: json['ModifierId'],
            service: json['Service'],
            serviceId: json['ServiceId'],
            serviceProviderId: json['ServiceProviderId'],
            status: json['Status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['Amount'] = this.amount;
        data['AttachmentId'] = this.attachmentId;
        data['CreationDate'] = this.creationDate;
        data['Creator'] = this.creator;
        data['CreatorId'] = this.creatorId;
        data['CreatorName'] = this.creatorName;
        data['Currency'] = this.currency;
        data['id'] = this.id;
        data['LastModificationDate'] = this.lastModificationDate;
        data['Method'] = this.method;
        data['Modifier'] = this.modifier;
        data['ModifierId'] = this.modifierId;
        data['Service'] = this.service;
        data['ServiceId'] = this.serviceId;
        data['ServiceProviderId'] = this.serviceProviderId;
        data['Status'] = this.status;
        return data;
    }
}