import 'package:flutter/material.dart';
import 'package:store/src/global_variables.dart';
import 'package:store/src/widgets/product_card.dart';
import 'package:store/src/screens/product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late List<String> filters;
  late String selectedFilter;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    filters = _generateFilters();
    selectedFilter = filters[0];

    _searchFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<String> _generateFilters() {
    final companyNames = products.map((product) => product['Company'] as String).toSet().toList();
    companyNames.sort();
    return ['All', ...companyNames];
  }

  List<Map<String, Object>> getFilteredProducts() {
    return products.where((product) {
      final matchesFilter = selectedFilter == 'All' || product['Company'] == selectedFilter;
      final matchesSearchQuery = searchQuery.isEmpty ||
          product.values.any((value) {
            return value.toString().toLowerCase().contains(searchQuery.toLowerCase());
          });
      return matchesFilter && matchesSearchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );
    return Column(
      children: [
        // <Title and Search>
        Row(
          children: [
            // <Title>
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Shoes\nCollection', style: Theme.of(context).textTheme.titleLarge),
            ),
            //</Title>

            // <Search>
            Expanded(
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                  hintText: _searchFocusNode.hasFocus ? '' : 'Search',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                              _searchController.clear();
                            });
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            //</Search>
          ],
        ),
        //</Title and Search>

        // <Filters>
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
                ),
              );
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        //</Filters>

        // <Product List>
        Expanded(
          child: ListView.builder(
            itemCount: getFilteredProducts().length,
            itemBuilder: (context, index) {
              final product = getFilteredProducts()[index];
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
                  backgroundColor:
                      index.isEven ? const Color.fromRGBO(216, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1),
                ),
              );
            },
          ),
        ),
        //</Product List>
      ],
    );
  }
}
