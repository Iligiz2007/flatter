import 'package:flutter/material.dart';

import '../constants.dart';
import '../data/food_data.dart';
import '../models/food_item.dart';
import '../widgets/food_card_vertical.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const HomeScreen({super.key, required this.scaffoldKey});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = "Все";

  @override
  Widget build(BuildContext context) {
    List<FoodItem> displayedItems = _selectedCategory == "Все"
        ? allFoodItems
        : allFoodItems
              .where((item) => item.category == _selectedCategory)
              .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
            ),
            const Text(
              "Челябинск",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Text(
                "Голоден?",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    "Поиск по меню",
                    style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryItem(Icons.restaurant, "Все"),
                  _buildCategoryItem(Icons.local_pizza, "Пицца"),
                  _buildCategoryItem(Icons.kebab_dining, "Кебаб"),
                  _buildCategoryItem(Icons.lunch_dining, "Бургер"),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(height: 1, color: Color(0xFFEEEEEE), thickness: 1),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: displayedItems.length,
              itemBuilder: (context, index) {
                return FoodCardVertical(item: displayedItems[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    bool isSelected = _selectedCategory == label;

    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? kPrimaryYellow.withOpacity(0.2)
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: kPrimaryYellow, width: 2)
                  : Border.all(color: Colors.grey.shade300),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.black : Colors.grey,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
