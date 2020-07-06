import 'package:flutter/material.dart';
import 'package:todo_app_getx/product/views/add_product.view.dart';
import 'package:todo_app_getx/product/views/edit_product.view.dart';
import 'package:todo_app_getx/product/views/product_list.view.dart';
import 'package:todo_app_getx/product/views/user_products.view.dart';
import 'package:todo_app_getx/widgets/app_drawer.dart';

class SnapSell extends StatefulWidget {
  @override
  _SnapSellState createState() => _SnapSellState();
}

class _SnapSellState extends State<SnapSell> {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currentIndex = pageController.page.toInt();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: <Widget>[
          ProductListPage(),
          AddProductPage(),
          UserProductsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.blue.withOpacity(.1),
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          pageController.animateToPage(
            value,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 400),
          );
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("Shop")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo), title: Text("Add")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profile")),
        ],
      ),
    );
  }
}
