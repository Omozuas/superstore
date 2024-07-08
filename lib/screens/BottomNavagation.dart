import 'package:flutter/material.dart';
import 'package:superstore/apis/models/listOfProductItem.dart';
import 'package:superstore/screens/cartScreen.dart';
import 'package:superstore/screens/productScreen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  List<Item> cart = []; // Assuming you have an Item class defined elsewhere
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void addToCart(Item product) {
    setState(() {
      cart.add(product);
    });
  }

  void removeFromCart(Item product) {
    setState(() {
      cart.remove(product);
    });
  }

  Widget _buildSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return ProductScreen(
          cart: cart,
          addToCart: addToCart,
        );
      case 1:
        return CartPage(
          cart: cart,
          removeFromCart: removeFromCart,
        );
      default:
        return ProductScreen(
          cart: cart,
          addToCart: addToCart,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    int cartItemCount = cart.length;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 235, 235),
      body: _buildSelectedScreen(),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () => _onItemTapped(0),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.home_outlined,
                      color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _onItemTapped(1),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Icon(
                          Icons.shopping_basket_outlined,
                          color:
                              _selectedIndex == 1 ? Colors.black : Colors.grey,
                        ),
                        if (cart.isNotEmpty)
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                '$cartItemCount',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      'Cart',
                      style: TextStyle(
                        color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
