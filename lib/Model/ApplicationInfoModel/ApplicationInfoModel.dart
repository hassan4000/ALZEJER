class ApplicationInfoModel {
    int allActiveClients;
    int allActiveClientsInThePastThreeDays;
    int allActiveServices;
    int allClients;
    int allDoneServices;
    int allIftaa;
    int allInterpreters;
    int allMustashareen;
    int allRouqat;
    int allServiceProviders;
    int allServices;
    int allUsers;
    int allDreamUsers;
    int allRouqiaUsers;
    int allIstasharaUsers;
    int allMedicalUsers;
    int allIftaaUsers;

    ApplicationInfoModel({this.allIftaaUsers,this.allMedicalUsers,this.allIstasharaUsers,this.allRouqiaUsers,this.allDreamUsers,this.allActiveClients, this.allActiveClientsInThePastThreeDays, this.allActiveServices, this.allClients, this.allDoneServices, this.allIftaa, this.allInterpreters, this.allMustashareen, this.allRouqat, this.allServiceProviders, this.allServices, this.allUsers});

    factory ApplicationInfoModel.fromJson(Map<String, dynamic> json) {
        return ApplicationInfoModel(
            allActiveClients: json['AllActiveClients'],
            allActiveClientsInThePastThreeDays: json['AllActiveClientsInThePastThreeDays'],
            allActiveServices: json['AllActiveServices'],
            allClients: json['AllClients'],
            allDoneServices: json['AllDoneServices'],
            allIftaa: json['AllIftaa'],
            allInterpreters: json['AllInterpreters'],
            allMustashareen: json['AllMustashareen'],
            allRouqat: json['AllRouqat'],
            allServiceProviders: json['AllServiceProviders'],
            allServices: json['AllServices'],
            allUsers: json['AllUsers'],
            allDreamUsers: json['AllDreamUsers'],
            allRouqiaUsers: json['AllRouqiaUsers'],
            allIstasharaUsers: json['AllIstasharaUsers'],
            allMedicalUsers: json['AllMedicalUsers'],
            allIftaaUsers: json['AllIftaaUsers'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['AllActiveClients'] = this.allActiveClients;
        data['AllActiveClientsInThePastThreeDays'] = this.allActiveClientsInThePastThreeDays;
        data['AllActiveServices'] = this.allActiveServices;
        data['AllClients'] = this.allClients;
        data['AllDoneServices'] = this.allDoneServices;
        data['AllIftaa'] = this.allIftaa;
        data['AllInterpreters'] = this.allInterpreters;
        data['AllMustashareen'] = this.allMustashareen;
        data['AllRouqat'] = this.allRouqat;
        data['AllServiceProviders'] = this.allServiceProviders;
        data['AllServices'] = this.allServices;
        data['AllUsers'] = this.allUsers;
        data['AllDreamUsers'] = this.allDreamUsers;
        data['AllRouqiaUsers'] = this.allRouqiaUsers;
        data['AllIstasharaUsers'] = this.allIstasharaUsers;
        data['AllMedicalUsers'] = this.allMedicalUsers;
        data['AllIftaaUsers'] = this.allIftaaUsers;
        return data;
    }
}