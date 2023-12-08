import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              paymentCard("TNM Mpamba", "088 *** 19"),
              paymentCard("Airtel Money", "099 *** 37"),
              paymentCard("Mo626", "100 *** 500"),
              
            ],
          ),
        ),
      
      );
  }
}


Card paymentCard(String serviceProvider, String number){
  return Card(
    color: Colors.green,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            serviceProvider,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            number,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    ),
  );          
}


