import 'package:flutter/material.dart';

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
            const Row(
              children: [
                //<header>
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Shoes\nCollection',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                // </header>

                //<search>
                Expanded(
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
                              ? Theme.of(context).primaryColor
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
          ],
        ),
      ),
    );
  }
}
