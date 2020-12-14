import 'UserWork.dart';

class Competition {
    int duration;
    String endDate;
    double firstPlacePrice;
    String goal;
    int id;
    String name;
    bool repeat;
    String startDate;
    String status;
    UserWork userWork;

    Competition({this.duration, this.endDate, this.firstPlacePrice, this.goal, this.id, this.name, this.repeat, this.startDate, this.status, this.userWork});

    factory Competition.fromJson(Map<String, dynamic> json) {
        return Competition(
            duration: json['duration'],
            endDate: json['EndDate'],
            firstPlacePrice: json['FirstPlacePrice'],
            goal: json['Goal'],
            id: json['id'], 
            name: json['Name'],
            repeat: json['repeat'], 
            startDate: json['StartDate'],
            status: json['Status'],
            userWork: json['UserWork'] != null ? UserWork.fromJson(json['UserWork']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['duration'] = this.duration;
        data['EndDate'] = this.endDate;
        data['FirstPlacePrice'] = this.firstPlacePrice;
        data['Goal'] = this.goal;
        data['id'] = this.id;
        data['Name'] = this.name;
        data['repeat'] = this.repeat;
        data['StartDate'] = this.startDate;
        data['Status'] = this.status;
        if (this.userWork != null) {
            data['UserWork'] = this.userWork.toJson();
        }
        return data;
    }
}