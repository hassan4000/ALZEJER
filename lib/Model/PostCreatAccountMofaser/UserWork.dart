class UserWork {
    int id;

    UserWork({this.id});

    factory UserWork.fromJson(Map<String, dynamic> json) {
        return UserWork(
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        return data;
    }
}