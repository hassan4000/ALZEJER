class ServicesPathModel {
    String avgWaitingTime;
    double cost;
    int id;
    String name;
    int numberOfPeopleWaiting;

    ServicesPathModel({this.avgWaitingTime, this.cost, this.id, this.name, this.numberOfPeopleWaiting});

    factory ServicesPathModel.fromJson(Map<String, dynamic> json) {
        return ServicesPathModel(
            avgWaitingTime: json['AvgWaitingTime'],
            cost: json['Cost'],
            id: json['id'], 
            name: json['Name'],
            numberOfPeopleWaiting: json['NumberOfPeopleWaiting'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AvgWaitingTime'] = this.avgWaitingTime;
        data['Cost'] = this.cost;
        data['id'] = this.id;
        data['Name'] = this.name;
        data['NumberOfPeopleWaiting'] = this.numberOfPeopleWaiting;
        return data;
    }
}