import 'package:flutter/material.dart';
import 'package:store/src/global_variables.dart';
import 'package:store/src/widgets/product_card.dart';
import 'package:store/src/screens/product_screen.dart';

// =================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  // --------------------------------

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
// =================================

class _HomeScreenState extends State<HomeScreen> {
  final List<String> filters = const [
    'All',
    'Adidas',
    'Nike',
    'Bata',
  ];
  late String selectedFilter;
  // --------------------------------

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }
  // --------------------------------

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // <header + search>
            Row(
              children: [
                //<header>
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('Shoes\nCollection', style: Theme.of(context).textTheme.titleLarge),
                ),
                // </header>

                //<search>
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                // </search>
              ],
            ),
            // </header + search>

            // <brand filters>
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        child: Chip(
                          label: Text(filter),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: selectedFilter == filter
                              ? Theme.of(context).colorScheme.primary
                              : const Color.fromRGBO(245, 247, 249, 1),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: const BorderSide(color: Color.fromRGBO(225, 227, 229, 1)),
                        ),
                      ));
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            // </brand filters>

            // <products>
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(product: product),
                        ),
                      );
                    },
                    child: ProductCard(
                      title: product['title'] as String,
                      price: product['price'] as double,
                      image: product['imageUrl'] as String,
                      backgroundColor: index.isEven
                          ? const Color.fromRGBO(216, 240, 253, 1)
                          : const Color.fromRGBO(245, 247, 249, 1),
                    ),
                  );
                },
              ),
            )
            // </products>
          ],
        ),
      ),
    );
  }
}
