class AboutModel {
    String code;
    String creationDate;
    int id;
    String lastModificationDate;
    String name;
    String value;

    AboutModel({this.code, this.creationDate, this.id, this.lastModificationDate, this.name, this.value});

    factory AboutModel.fromJson(Map<String, dynamic> json) {
        return AboutModel(
            code: json['Code'],
            creationDate: json['CreationDate'],
            id: json['id'], 
            lastModificationDate: json['LastModificationDate'],
            name: json['Name'],
            value: json['Value'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['Code'] = this.code;
        data['CreationDate'] = this.creationDate;
        data['id'] = this.id;
        data['LastModificationDate'] = this.lastModificationDate;
        data['Name'] = this.name;
        data['Value'] = this.value;
        return data;
    }
}