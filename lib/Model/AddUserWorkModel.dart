class AddUserWorkModel {
    String userId;
    int userWorkId;

    AddUserWorkModel({this.userId, this.userWorkId});

    factory AddUserWorkModel.fromJson(Map<String, dynamic> json) {
        return AddUserWorkModel(
            userId: json['UserId'],
            userWorkId: json['UserWorkId'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['UserId'] = this.userId;
        data['UserWorkId'] = this.userWorkId;
        return data;
    }
}