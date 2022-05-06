import 'package:flutter/material.dart';

class PaymentSuccessful extends StatefulWidget {
  const PaymentSuccessful({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Image.asset('assets/images/paymentsuccessful.png'),
          SizedBox(height: 12),
          Text(
            'Payment Successful!',
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Thank you for shopping with us.',
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
