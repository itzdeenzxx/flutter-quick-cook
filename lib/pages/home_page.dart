import 'package:flutter/material.dart';
import '../widgets/refrigerator_view.dart';
import '../api/patumma_service.dart';
import '../models/recipe_model.dart';
import 'results_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _ingredientController = TextEditingController();
  final List<String> _ingredients = [];
  bool _isLoading = false;
  final String _sessionId = DateTime.now().millisecondsSinceEpoch.toString();

  void _addIngredient() {
    if (_ingredientController.text.trim().isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientController.text.trim());
        _ingredientController.clear();
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() => _ingredients.removeAt(index));
  }

  Future<void> _getRecipe() async {
    if (_ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('โปรดเพิ่มวัตถุดิบก่อน')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final recipe = await PatummaService.getRecipe(
        ingredients: _ingredients.join(", "),
        sessionId: _sessionId,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(recipe: recipe),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตู้เย็นของฉัน'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ResultsPage()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: RefrigeratorView(ingredients: _ingredients, onRemove: _removeIngredient)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientController,
                    decoration: const InputDecoration(
                      labelText: 'เพิ่มวัตถุดิบ',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addIngredient(),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: _addIngredient),
              ],
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getRecipe,
        icon: const Icon(Icons.restaurant),
        label: const Text('สร้างเมนู'),
      ),
    );
  }
}