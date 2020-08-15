class PaymentMethod {
    String currencyIso;
    String ethodAr;
    String imageUrl;
    bool isDirectPayment;
    String paymentMethodAr;
    String paymentMethodCode;
    String paymentMethodEn;
    int paymentMethodId;
    double serviceCharge;
    double totalAmount;

    PaymentMethod({this.currencyIso, this.ethodAr, this.imageUrl, this.isDirectPayment, this.paymentMethodAr, this.paymentMethodCode, this.paymentMethodEn, this.paymentMethodId, this.serviceCharge, this.totalAmount});

    factory PaymentMethod.fromJson(Map<String, dynamic> json) {
        return PaymentMethod(
            currencyIso: json['CurrencyIso'],
            ethodAr: json['EthodAr'],
            imageUrl: json['ImageUrl'],
            isDirectPayment: json['IsDirectPayment'],
            paymentMethodAr: json['PaymentMethodAr'],
            paymentMethodCode: json['PpaymentMethodCode'],
            paymentMethodEn: json['PaymentMethodEn'],
            paymentMethodId: json['PaymentMethodId'],
            serviceCharge: json['ServiceCharge'],
            totalAmount: json['TotalAmount'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['CurrencyIso'] = this.currencyIso;
        data['EthodAr'] = this.ethodAr;
        data['ImageUrl'] = this.imageUrl;
        data['IsDirectPayment'] = this.isDirectPayment;
        data['PaymentMethodAr'] = this.paymentMethodAr;
        data['PaymentMethodCode'] = this.paymentMethodCode;
        data['PaymentMethodEn'] = this.paymentMethodEn;
        data['PaymentMethodId'] = this.paymentMethodId;
        data['ServiceCharge'] = this.serviceCharge;
        data['TotalAmount'] = this.totalAmount;
        return data;
    }
}