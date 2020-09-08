class MyServicesProvider{
  String country;
  String name;

  MyServicesProvider({this.country, this.name});


  factory MyServicesProvider.fromJson(Map<String, dynamic> json) {
    return MyServicesProvider(
        country: json['Country'],
        name: json['Name']
    );
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Country'] = this.country.toString();
    data['Name'] = this.name.toString();
  }
}