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
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: const [
            ProductsScreen(),
            CartScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
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
        iconSize: 30,
        selectedFontSize: 0, // no label
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedFontSize: 0, // no label
        unselectedItemColor: Colors.grey, // Set the color of unselected items
        // Set the background color
        onTap: _onItemTapped, // Adjust the icon size
      ),
    );
  }
}
