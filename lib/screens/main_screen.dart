import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/app_sidebar.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppSidebar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(scaffoldKey: _scaffoldKey),
          const Center(child: Text("Корзина пуста")),
          const Center(child: Text("У вас пока нет заказов")),
        ],
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width <= 800
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              selectedItemColor: kPrimaryYellow,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Меню'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'Корзина',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt),
                  label: 'Заказы',
                ),
              ],
            )
          : null,
    );
  }
}
