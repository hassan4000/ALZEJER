class ServicePath {
    int attachmentId;
    double cost;
    String creationDate;
    String creator;
    String creatorId;
    bool enabled;
    int id;
    bool isPrivate;
    String lastModificationDate;
    String modifier;
    String modifierId;
    String name;
    String serviceProvider;
    String serviceProviderId;

    ServicePath({this.attachmentId, this.cost, this.creationDate, this.creator, this.creatorId, this.enabled, this.id, this.isPrivate, this.lastModificationDate, this.modifier, this.modifierId, this.name, this.serviceProvider, this.serviceProviderId});

    factory ServicePath.fromJson(Map<String, dynamic> json) {
        return ServicePath(
            attachmentId: json['AttachmentId'],
            cost: json['Cost'],
            creationDate: json['CreationDate'],
            creator: json['Creator'],
            creatorId: json['CreatorId'],
            enabled: json['Enabled'],
            id: json['id'], 
            isPrivate: json['IsPrivate'],
            lastModificationDate: json['LastModificationDate'],
            modifier: json['Modifier'],
            modifierId: json['ModifierId'],
            name: json['Name'],
           // serviceProvider: json['ServiceProvider'],
            serviceProviderId: json['ServiceProviderId'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AttachmentId'] = this.attachmentId;
        data['Cost'] = this.cost;
        data['CreationDate'] = this.creationDate;
        data['Creator'] = this.creator;
        data['CreatorId'] = this.creatorId;
        data['Enabled'] = this.enabled;
        data['id'] = this.id;
        data['IsPrivate'] = this.isPrivate;
        data['LastModificationDate'] = this.lastModificationDate;
        data['Modifier'] = this.modifier;
        data['ModifierId'] = this.modifierId;
        data['Name'] = this.name;
       // data['ServiceProvider'] = this.serviceProvider;
        data['ServiceProviderId'] = this.serviceProviderId;
        return data;
    }
}