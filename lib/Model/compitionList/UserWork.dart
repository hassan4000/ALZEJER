class UserWork {
    String adjectiveName;
    String code;
    String creationDate;
    bool enabled;
    int id;
    String lastModificationDate;
    String name;
  //  List<UserWorkBinding> userWorkBinding;

    UserWork({this.adjectiveName, this.code, this.creationDate, this.enabled, this.id, this.lastModificationDate, this.name});

    factory UserWork.fromJson(Map<String, dynamic> json) {
        return UserWork(
            adjectiveName: json['AdjectiveName'],
            code: json['Code'],
            creationDate: json['CreationDate'],
            enabled: json['Enabled'],
            id: json['id'], 
            lastModificationDate: json['LastModificationDate'],
            name: json['Name'],
          //  userWorkBinding: json['userWorkBinding'] != null ? (json['userWorkBinding'] as List).map((i) => UserWorkBinding.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AdjectiveName'] = this.adjectiveName;
        data['Code'] = this.code;
        data['CreationDate'] = this.creationDate;
        data['Enabled'] = this.enabled;
        data['id'] = this.id;
        data['LastModificationDate'] = this.lastModificationDate;
        data['Name'] = this.name;
    /*    if (this.userWorkBinding != null) {
            data['userWorkBinding'] = this.userWorkBinding.map((v) => v.toJson()).toList();
        }*/
        return data;
    }
}