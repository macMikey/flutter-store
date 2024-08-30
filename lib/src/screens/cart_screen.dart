import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Center(
        child: Text(
          'This is the cart screen',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
