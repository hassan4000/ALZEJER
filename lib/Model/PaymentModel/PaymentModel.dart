class PaymentModel {
    String amount;
    String currency;
    String method;
    String myPaymnetMethod;
    double myMoeny;
    int serviceId;
    int servicePathId;
    bool privateServices;

    PaymentModel({this.myPaymnetMethod,this.amount, this.currency, this.method, this.myMoeny, this.serviceId, this.servicePathId,
    this.privateServices=false});

    factory PaymentModel.fromJson(Map<String, dynamic> json) {
        return PaymentModel(
            amount: json['Amount'],
            currency: json['Currency'],
            method: json['Method'],
            myMoeny: json['myMoeny'],
            myPaymnetMethod: json['myPaymnetMethod'],
            serviceId: json['ServiceId'],
            servicePathId: json['ServicePathId'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['Amount'] = this.amount;
        data['Currency'] = this.currency;
        data['Method'] = this.method;
        data['myMoeny'] = this.myMoeny;
        data['ServiceId'] = this.serviceId;
        data['ServicePathId'] = this.servicePathId;
        return data;
    }
}