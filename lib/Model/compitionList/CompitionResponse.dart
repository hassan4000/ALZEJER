import 'Competition.dart';

class CompitionResponse {
    List<Competition> competitions;
    int count;

    CompitionResponse({this.competitions, this.count});

    factory CompitionResponse.fromJson(Map<String, dynamic> json) {
        return CompitionResponse(
            competitions: json['Competitions'] != null ? (json['Competitions'] as List).map((i) => Competition.fromJson(i)).toList() : null,
            count: json['Count'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['Count'] = this.count;
        if (this.competitions != null) {
            data['Competitions'] = this.competitions.map((v) => v.toJson()).toList();
        }
        return data;
    }
}