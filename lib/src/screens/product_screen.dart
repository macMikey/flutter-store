import 'package:flutter/material.dart';
import 'package:store/src/global_variables.dart'; // Corrected import path

class ProductScreen extends StatefulWidget {
  final Map<String, Object> product;

  const ProductScreen({super.key, required this.product});

  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  num? selectedSize;
  int? selectedChipIndex;

  @override
  Widget build(BuildContext context) {
    final productId = widget.product['id'] as String?;
    final productTitle = widget.product['title'] as String?;
    final productImageUrl = widget.product['imageUrl'] as String?;
    final productPrice = widget.product['price'] as num?;
    final productSizes = widget.product['sizes'] as List<num>?;
    final productCompany = widget.product['company'] as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        children: [
          if (productTitle != null) Text(productTitle, style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          if (productImageUrl != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(productImageUrl),
            ),
          const Spacer(flex: 2),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (productPrice != null) Text('\$ $productPrice', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                if (productSizes != null)
                  Expanded(
                    child: ListView.builder(
                      itemCount: productSizes.length,
                      itemBuilder: (context, index) {
                        final size = productSizes[index];
                        final isSelected = selectedChipIndex == index;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ChoiceChip(
                            label: Text(size.toString()),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                selectedChipIndex = selected ? index : null;
                                selectedSize = selected ? size : null;
                              });
                            },
                            selectedColor: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    onPressed: selectedSize != null
                        ? () {
                            if (selectedSize != null &&
                                productId != null &&
                                productTitle != null &&
                                productPrice != null &&
                                productCompany != null &&
                                productImageUrl != null) {
                              cart.add({
                                'id': productId,
                                'title': productTitle,
                                'price': productPrice,
                                'size': selectedSize as num, // Ensure selectedSize is of type num
                                'company': productCompany,
                                'imageUrl': productImageUrl,
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to cart!'),
                                ),
                              );
                              setState(() {
                                selectedChipIndex = null;
                                selectedSize = null;
                              });
                            }
                          }
                        : null, // Disable button if no size is selected
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedSize != null
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey, // Change color if disabled
                      minimumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 20.0), // Add space between icon and label
                      child: Icon(Icons.shopping_cart, color: Colors.black),
                    ),
                    label: const Text('Add to Cart', style: TextStyle(color: Colors.black, fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
