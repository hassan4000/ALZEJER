class UserWorkData {
    String adjectiveName;
    String creationDate;
    bool enabled;
    int id;
    String lastModificationDate;
    String name;

    UserWorkData({this.adjectiveName, this.creationDate, this.enabled, this.id, this.lastModificationDate, this.name});

    factory UserWorkData.fromJson(Map<String, dynamic> json) {
        return UserWorkData(
            adjectiveName: json['AdjectiveName'],
            creationDate: json['CreationDate'],
            enabled: json['Enabled'],
            id: json['id'], 
            lastModificationDate: json['lastModificationDate'], 
            name: json['Name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AdjectiveName'] = this.adjectiveName;
        data['CreationDate'] = this.creationDate;
        data['Enabled'] = this.enabled;
        data['id'] = this.id;
        data['lastModificationDate'] = this.lastModificationDate;
        data['Name'] = this.name;
        return data;
    }
}