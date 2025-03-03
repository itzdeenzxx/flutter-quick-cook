class Recipe {
  final String name;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromRawString(String raw) {
    final lines = raw.split('\n');
    String name = 'เมนูแนะนำ';
    final ingredients = <String>[];
    final steps = <String>[];
    String currentSection = '';

    for (var line in lines) {
      line = line.trim();
      
      // ตรวจสอบส่วนหัวข้อ (รองรับรูปแบบต่างๆ)
      if (line.toLowerCase().contains('เมนูแนะนำ')) {
        currentSection = 'name';
        name = line.replaceAll(RegExp(r'เมนูแนะนำ:?'), '').trim();
      } else if (line.toLowerCase().contains('วัตถุดิบ')) {
        currentSection = 'ingredients';
      } else if (line.toLowerCase().contains('วิธีทำ')) {
        currentSection = 'steps';
      }

      // จัดการข้อมูลในแต่ละส่วน
      else if (currentSection == 'ingredients' && line.isNotEmpty) {
        if (line.startsWith('-') || line.startsWith('•')) {
          ingredients.add(line.replaceAll(RegExp(r'^[-\•\s]+'), '').trim());
        }
      } else if (currentSection == 'steps' && line.isNotEmpty) {
        if (RegExp(r'^\d+\.').hasMatch(line)) {
          steps.add(line.replaceAll(RegExp(r'^\d+\.\s*'), '').trim());
        }
      }
    }

    return Recipe(
      name: name,
      ingredients: ingredients,
      steps: steps,
    );
  }
}