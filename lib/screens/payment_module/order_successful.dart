import 'package:flutter/material.dart';

class OrderSuccessful extends StatefulWidget {
  const OrderSuccessful({ Key? key }) : super(key: key);

  @override
  State<OrderSuccessful> createState() => _OrderSuccessfulState();
}

class _OrderSuccessfulState extends State<OrderSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Image.asset('assets/images/ordersuccessful.png'),
          const SizedBox(height: 12),
          Text(
            'Order Successful!',
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