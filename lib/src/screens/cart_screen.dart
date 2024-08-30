import 'package:flutter/material.dart';
import 'package:store/src/global_variables.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = cart.fold(0, (sum, item) => sum + (item['price'] as num));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Center(
        child: cart.isEmpty
            ? const Text(
                'Cart Empty',
                style: TextStyle(fontSize: 36, color: Colors.black),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final cartItem = cart[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(cartItem['imageUrl'].toString()),
                            radius: 30,
                          ),
                          title: Text(cartItem['title'].toString(), style: Theme.of(context).textTheme.bodySmall),
                          subtitle: Row(
                            children: [
                              Text("Size: ${cartItem['size']}", style: const TextStyle(fontSize: 14)),
                              const Spacer(),
                              Text("\$${cartItem['price']}", style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                cart.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Item removed from cart'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.grey[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$$totalPrice',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
