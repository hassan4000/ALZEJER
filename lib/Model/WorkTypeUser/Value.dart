class Value {
    String adjectiveName;
    String creationDate;
    bool enabled;
    int id;
    String lastModificationDate;
    String name;
    String code;
    String userWorkBinding;

    Value({this.userWorkBinding,this.adjectiveName, this.creationDate, this.enabled, this.id, this.lastModificationDate, this.name,this.code});

    factory Value.fromJson(Map<String, dynamic> json) {
        return Value(
            adjectiveName: json['AdjectiveName'],
            creationDate: json['CreationDate'],
            enabled: json['Enabled'],
            id: json['id'], 
            lastModificationDate: json['LastModificationDate'],
            name: json['Name'],
            code: json['Code'],
            userWorkBinding: json['userWorkBinding'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AdjectiveName'] = this.adjectiveName;
        data['CreationDate'] = this.creationDate;
        data['Enabled'] = this.enabled;
        data['id'] = this.id;
        data['LastModificationDate'] = this.lastModificationDate;
        data['Name'] = this.name;
        data['Code'] = this.code;
        data['userWorkBinding'] = this.userWorkBinding;
        return data;
    }
}