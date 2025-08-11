import 'package:flutter/material.dart';

class CategoryGrid extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategoryGrid({super.key, required this.onCategorySelected});

  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  String? _selectedCategory;

  final Map<String, IconData> _categories = {
    'Alimentação': Icons.restaurant,
    'Transporte': Icons.directions_car,
    'Moradia': Icons.home,
    'Lazer': Icons.sports_esports,
    'Saúde': Icons.favorite,
    'Educação': Icons.school,
    'Salário': Icons.attach_money,
    'Outros': Icons.circle,
  };

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final categoryName = _categories.keys.elementAt(index);
        final categoryIcon = _categories.values.elementAt(index);
        final isSelected = _selectedCategory == categoryName;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategory = categoryName;
            });
            widget.onCategorySelected(categoryName);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xff4f46e5) : const Color(0xffe2e8f0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  categoryIcon,
                  color: isSelected ? Colors.white : const Color(0xff1e293b),
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : const Color(0xff1e293b),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}