import 'PaymentMethod.dart';

class AllPaymentMethodModel {
    List<PaymentMethod> paymentMethods;

    AllPaymentMethodModel({this.paymentMethods});

    factory AllPaymentMethodModel.fromJson(Map<String, dynamic> json) {
        return AllPaymentMethodModel(
            paymentMethods: json['PaymentMethods'] != null ? (json['PaymentMethods'] as List).map((i) => PaymentMethod.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.paymentMethods != null) {
            data['PaymentMethods'] = this.paymentMethods.map((v) => v.toJson()).toList();
        }
        return data;
    }
}