import 'package:flutter/material.dart';
import 'ingredient_item.dart';

class RefrigeratorView extends StatelessWidget {
  final List<String> ingredients;
  final Function(int) onRemove;

  const RefrigeratorView({
    Key? key,
    required this.ingredients,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue[700],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.ac_unit, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'ตู้เย็นของฉัน',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ingredients.isEmpty
                ? const Center(
                    child: Text(
                      'ตู้เย็นว่างเปล่า\nกรุณาเพิ่มวัตถุดิบ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2,
                    ),
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      return IngredientItem(
                        name: ingredients[index],
                        onRemove: () => onRemove(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}