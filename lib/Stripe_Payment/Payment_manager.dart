import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:coachyp/stripe_Payment/stripe_keys.dart';


abstract class PaymentManager {
  static Future<void>makePayment(int amount,String currency)async{
try {
     String clientSecret=await _getClientSecret((amount*100).toString(), currency);

} catch (error) {
  throw Exception(error.toString());
} 
}
static Future<void> _initializePaymentSheet(){
  Stripe.instance.initPaymentSheet(
    paymentSheetParameters: 
    );
}
  static Future<String> _getClientSecret(String amount,String currency)async {
    Dio dio=Dio();
    var response=await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization':'Bearer ${ApiKeys.secretKey}',
          'Content_Type':'application/x-www-form-urlencoded'
        },
      ),
      data: {
        'amount':amount,
        'currency':currency,
     },
   );
   return response.data["client_secret"];
 }
 
}