import 'package:flutter/material.dart';
import 'package:store/src/screens/products_screen.dart';
import 'package:store/src/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [
            ProductsScreen(),
            CartScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey, // Set the color of unselected items
        backgroundColor: Colors.white, // Set the background color
        onTap: _onItemTapped,
//        iconSize: 30, // Adjust the icon size
        selectedFontSize: 12, // Adjust the selected font size
        unselectedFontSize: 10, // Adjust the unselected font size
      ),
    );
  }
}
