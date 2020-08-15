import 'dart:convert';

import 'package:faserholmak/Helper/BasicTools.dart';
import 'package:flutter/material.dart';
import 'package:faserholmak/Helper/HassanFatorrah.dart';

/*
TODO: The following data are using for testing only, so that when you go live
      don't forget to replace the following test credentials with the live
      credentials provided by MyFatoorah Company.
*/

// Base Url
//final String baseUrl = "https://apitest.myfatoorah.com";
final String baseUrl = "https://api.myfatoorah.com/";


final String tokenHASS="jxgpB9hZY0yAmTx_YN4NSmeXRb6Dbolv17-nsMkcG8wLrf6lOWibfBShd9RuiQ3jB3PQs_0DVRb0bSTiJTddltx5jElPgkA99rGAM9C8OGJMY0lB9jaexzNdwaJxiiH3F6hTCFhq4McGxKzuCLGq7s-95hK3CcSmblXlJ5vZzCv8_Rl8lDvltSxEPImp3d_B9KIPe1-s0ttr_thuEDV6Qr4NAzS98Xzc7rqqqb8diy01Uw0G2jSbaASnmc-UzEPwYGrYWwalbGVXAwQAoH6c8gjvvuuAARL636meV-3nR7qIXjP10yz_cOSxY6xMjkF-R6G8Wiy18OX3cKg0fPlMP2jgbAbHt0Ygevi-yt9-Wa-KIB9vBtOiII5VXz-MjYMpfEeiUUI3xkwqQvu8veQt1o3Vz0B4JcDshImVgF_6uFev_VKia3eVJIwcVJe9PBsFQ6llZqSZrhPJCADmL4Uc5agUSPoujcUoCa-GrMkzPdjleJyjbfCu-44jbFcfGR759VDKvrm4tJpEtk-1yTusFif17tbMpjwrC-qkrJmx-mEWckuHpcI4TAhoxhliaCR37ogn6Gl5smIFUfIMy0YU7gKzdi1VqjmCX2R1nznelP32DQd1H47Pc8d0e_qEcFY8eVFl2JT3aa64ktB3B1PBA5ew14lS6DcPPmdHq1fbdj-A9dVqEH3DOrZD-Zf8qk63d-zYBw";
// Token for regular payment
final String regularPaymentToken =
    "7Fs7eBv21F5xAocdPvvJ-sCqEyNHq4cygJrQUFvFiWEexBUPs4AkeLQxH4pzsUrY3Rays7GVA6SojFCz2DMLXSJVqk8NG-plK-cZJetwWjgwLPub_9tQQohWLgJ0q2invJ5C5Imt2ket_-JAlBYLLcnqp_WmOfZkBEWuURsBVirpNQecvpedgeCx4VaFae4qWDI_uKRV1829KCBEH84u6LYUxh8W_BYqkzXJYt99OlHTXHegd91PLT-tawBwuIly46nwbAs5Nt7HFOozxkyPp8BW9URlQW1fE4R_40BXzEuVkzK3WAOdpR92IkV94K_rDZCPltGSvWXtqJbnCpUB6iUIn1V-Ki15FAwh_nsfSmt_NQZ3rQuvyQ9B3yLCQ1ZO_MGSYDYVO26dyXbElspKxQwuNRot9hi3FIbXylV3iN40-nCPH4YQzKjo5p_fuaKhvRh7H8oFjRXtPtLQQUIDxk-jMbOp7gXIsdz02DrCfQIihT4evZuWA6YShl6g8fnAqCy8qRBf_eLDnA9w-nBh4Bq53b1kdhnExz0CMyUjQ43UO3uhMkBomJTXbmfAAHP8dZZao6W8a34OktNQmPTbOHXrtxf6DS-oKOu3l79uX_ihbL8ELT40VjIW3MJeZ_-auCPOjpE3Ax4dzUkSDLCljitmzMagH2X8jN8-AYLl46KcfkBV";

// Token for direct payment and recurring
final String directPaymentToken =
    "fVysyHHk25iQP4clu6_wb9qjV3kEq_DTc1LBVvIwL9kXo9ncZhB8iuAMqUHsw-vRyxr3_jcq5-bFy8IN-C1YlEVCe5TR2iCju75AeO-aSm1ymhs3NQPSQuh6gweBUlm0nhiACCBZT09XIXi1rX30No0T4eHWPMLo8gDfCwhwkbLlqxBHtS26Yb-9sx2WxHH-2imFsVHKXO0axxCNjTbo4xAHNyScC9GyroSnoz9Jm9iueC16ecWPjs4XrEoVROfk335mS33PJh7ZteJv9OXYvHnsGDL58NXM8lT7fqyGpQ8KKnfDIGx-R_t9Q9285_A4yL0J9lWKj_7x3NAhXvBvmrOclWvKaiI0_scPtISDuZLjLGls7x9WWtnpyQPNJSoN7lmQuouqa2uCrZRlveChQYTJmOr0OP4JNd58dtS8ar_8rSqEPChQtukEZGO3urUfMVughCd9kcwx5CtUg2EpeP878SWIUdXPEYDL1eaRDw-xF5yPUz-G0IaLH5oVCTpfC0HKxW-nGhp3XudBf3Tc7FFq4gOeiHDDfS_I8q2vUEqHI1NviZY_ts7M97tN2rdt1yhxwMSQiXRmSQterwZWiICuQ64PQjj3z40uQF-VHZC38QG0BVtl-bkn0P3IjPTsTsl7WBaaOSilp4Qhe12T0SRnv8abXcRwW3_HyVnuxQly_OsZzZry4ElxuXCSfFP2b4D2-Q";





class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _response = '';
  String _loading = "Loading...";

  @override
  void initState() {
    super.initState();

    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    MFSDK.init(baseUrl, tokenHASS);

    // (Optional) un comment the following lines if you want to set up properties of AppBar.

//    MFSDK.setUpAppBar(
//      title: "MyFatoorah Payment",
//      titleColor: Colors.white,  // Color(0xFFFFFFFF)
//      backgroundColor: Colors.black, // Color(0xFF000000)
//      isShowAppBar: true); // For Android platform only

    // (Optional) un comment this line, if you want to hide the AppBar.
    // Note, if the platform is iOS, this line will not affected

//    MFSDK.setUpAppBar(isShowAppBar: false);
  }

  /*
    Send Payment
   */
  void sendPayment() {
    var request = MFSendPaymentRequest(
        invoiceValue: 0.100,
        customerName: "Customer name",

        notificationOption: MFNotificationOption.LINK);

    MFSDK.sendPayment(
        MFAPILanguage.AR,
        request,
            (MFResult<MFSendPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Initiate Payment
   */
  void initiatePayment() {
    var request = new MFInitiatePaymentRequest(1, MFCurrencyISO.UNITED_STATE_USD);

    MFSDK.initiatePayment(
        request,
        MFAPILanguage.AR,
            (MFResult<MFInitiatePaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {

                printWrapped(jsonEncode(result.response).toString());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Regular Payment
   */
  void executeRegularPayment() {
    // The value "1" is the paymentMethodId of KNET payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
  //  String paymentMethod = "1";
    String paymentMethod = "6";
    MFExecutePaymentRequest mfExecutePaymentRequest=new MFExecutePaymentRequest(paymentMethod, "2");
    mfExecutePaymentRequest.displayCurrencyIso="USD";

    var request = mfExecutePaymentRequest;

    MFSDK.executePayment(
        context,
        request,
        MFAPILanguage.AR,
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                printWrapped(invoiceId);
                printWrapped(jsonEncode(result.response).toString());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(invoiceId);
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Direct Payment
   */
  void executeDirectPayment() {
    // The value "2" is the paymentMethodId of Visa/Master payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    String paymentMethod = "8";
    //String paymentMethod = "2";

    var request = new MFExecutePaymentRequest(paymentMethod, "100");

  // var mfCardInfo = new MFCardInfo(cardToken: "Put your token here");

    var mfCardInfo = new MFCardInfo(
        cardNumber: "2223000000000007",
        expiryMonth: "05",
        expiryYear: "21",
        securityCode: "100",
        bypass3DS: true,

        saveToken: false);

    MFSDK.executeDirectPayment(
        context,
        request,
        mfCardInfo,
        MFAPILanguage.AR,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                printWrapped("invoiceId"+invoiceId);
                printWrapped("-------------------------------------------------------------");
                printWrapped(jsonEncode(result.error).toString());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                printWrapped(invoiceId);
                printWrapped(jsonEncode(result.error).toString());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Direct Payment with Recurring
   */
  void executeDirectPaymentWithRecurring() {
    // The value "2" is the paymentMethodId of Visa/Master payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    String paymentMethod = "2";

    var request = new MFExecutePaymentRequest(paymentMethod, "100");

    var mfCardInfo = new MFCardInfo(
        cardNumber: "2223000000000007",
        expiryMonth: "05",
        expiryYear: "21",
        securityCode: "100",
        bypass3DS: true,
        saveToken: true);

    int intervalDays = 5;

    MFSDK.executeDirectPaymentWithRecurring(
        context,
        request,
        mfCardInfo,
        intervalDays,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(invoiceId);
                print(result.response.toJson());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(invoiceId);
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Payment Enquiry
   */
  void getPaymentStatus() {
    var request = MFPaymentStatusRequest(invoiceId: "204519");

    MFSDK.getPaymentStatus(
        MFAPILanguage.EN,
        request,
            (MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                printWrapped(jsonEncode(result.response).toString());
                _response = result.response.toJson().toString();
              })
            }
          else
            {
              setState(() {
                printWrapped(jsonEncode(result.error).toString());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Cancel Token
   */
  void cancelToken() {
    MFSDK.cancelToken(
        "Put your token here",
        MFAPILanguage.EN,
            (MFResult<bool> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toString());
                _response = result.response.toString();
              })
            }
          else
            {
              setState(() {
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Cancel Recurring Payment
   */
  void cancelRecurringPayment() {
    MFSDK.cancelRecurringPayment(
        "Put RecurringId here",
        MFAPILanguage.EN,
            (MFResult<bool> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toString());
                _response = result.response.toString();
              })
            }
          else
            {
              setState(() {
                print(result.error.toJson());
                _response = result.error.message;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  RaisedButton(
                    child: Text('Send Payment'),
                    onPressed: sendPayment,
                  ),
                  RaisedButton(
                    child: Text('Initiate Payment'),
                    onPressed: initiatePayment,
                  ),
                  RaisedButton(
                    child: Text('Execute Regular Payment'),
                    onPressed: executeRegularPayment,
                  ),
                  RaisedButton(
                    child: Text('Execute Direct Payment'),
                    onPressed: executeDirectPayment,
                  ),
                  RaisedButton(
                    child: Text('Execute Direct Payment with Recurring'),
                    onPressed: executeDirectPaymentWithRecurring,
                  ),
                  RaisedButton(
                    child: Text('Cancel Recurring Payment'),
                    onPressed: cancelRecurringPayment,
                  ),
                  RaisedButton(
                    child: Text('Cancel Token'),
                    onPressed: cancelToken,
                  ),
                  RaisedButton(
                    child: Text('Get Payment Status'),
                    onPressed: getPaymentStatus,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Text(_response),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}