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
                              _confirmRemoval(index);
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

  Future<void> _confirmRemoval(int index) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Removal'),
          content: const Text('Are you sure you want to remove this item from the cart?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Text color
                backgroundColor: Theme.of(context).primaryColor, // Button color
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Text color
                backgroundColor: Theme.of(context).primaryColor, // Button color
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );

    if (confirm == true && mounted) {
      _removeItem(index);
    }
  }

  void _removeItem(int index) {
    setState(() {
      cart.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removed from cart'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
