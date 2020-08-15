class UserWork {
    String adjectiveName;
    String code;
    String creationDate;
    bool enabled;
    int id;
    String lastModificationDate;
    String name;
    String userWorkBinding;

    UserWork({this.adjectiveName, this.code, this.creationDate, this.enabled, this.id, this.lastModificationDate, this.name, this.userWorkBinding});

    factory UserWork.fromJson(Map<String, dynamic> json) {
        return UserWork(
            adjectiveName: json['adjectiveName'], 
            code: json['code'], 
            creationDate: json['creationDate'], 
            enabled: json['enabled'], 
            id: json['id'], 
            lastModificationDate: json['lastModificationDate'], 
            name: json['name'], 
            userWorkBinding: json['userWorkBinding'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['adjectiveName'] = this.adjectiveName;
        data['code'] = this.code;
        data['creationDate'] = this.creationDate;
        data['enabled'] = this.enabled;
        data['id'] = this.id;
        data['lastModificationDate'] = this.lastModificationDate;
        data['name'] = this.name;
        data['userWorkBinding'] = this.userWorkBinding;
        return data;
    }
}