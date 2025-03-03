import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class ResultsPage extends StatelessWidget {
  final Recipe? recipe;

  const ResultsPage({super.key, this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ผลลัพธ์เมนูอาหาร')),
      body: recipe == null 
          ? _buildEmptyState() 
          : _buildRecipeCard(recipe!),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.fastfood, size: 60, color: Colors.grey),
          const SizedBox(height: 20),
          Text(
            'ยังไม่มีเมนูอาหาร',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    final hasValidData = 
      recipe.name.isNotEmpty &&
      recipe.ingredients.isNotEmpty &&
      recipe.steps.isNotEmpty;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (hasValidData) ...[
          _buildSection('เมนู', recipe.name, Icons.restaurant_menu, Colors.blue),
          _buildSection('วัตถุดิบ', recipe.ingredients.join('\n'), Icons.shopping_basket, Colors.green),
          _buildSection('วิธีทำ', recipe.steps.join('\n\n'), Icons.list_alt, Colors.orange),
        ] else 
          _buildErrorWidget(),
      ],
    );
  }

  Widget _buildSection(String title, String content, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1),
            Text(content, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Card(
      color: Colors.red[100],
      margin: const EdgeInsets.all(16),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          '⚠️ ไม่สามารถประมวลผลข้อมูลได้\nโปรดตรวจสอบวัตถุดิบหรือลองอีกครั้ง',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  }
}