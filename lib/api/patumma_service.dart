import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/recipe_model.dart';

class PatummaService {
  static const String _apiKey = 'kOOudAlAEDw4J2CbSeKZSXRVkpB37Wc3';
  static const String _packageName = 'ai4thai-lib';
  static const String _baseUrl = 'https://api.aiforthai.in.th';

  static Future<Recipe> getRecipe({
    required String ingredients,
    required String sessionId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/pathumma-chat'),
        headers: {
          'accept': 'application/json; charset=UTF-8',
          'Apikey': _apiKey,
          'X-lib': _packageName,
        },
        body: {
          'context': ingredients,
          'prompt': '''
            โปรดคิดเมนูอาหารโดยใช้วัตถุดิบต่อไปนี้เท่านั้น **ห้ามเพิ่มวัตถุดิบอื่นใดนอกเหนือจากนี้**:
            
            เงื่อนไขสำคัญ:  
            - ใช้เฉพาะวัตถุดิบที่ระบุด้านบนเท่านั้น  
            - หากต้องใช้เครื่องปรุงพื้นฐาน (เช่น น้ำมัน เกลือ น้ำตาล) ให้ระบุในวัตถุดิบตั้งแต่แรก  
            - หากมีวัตถุดิบอื่นในวิธีทำ **ให้ตอบว่า "ไม่สามารถสร้างเมนูได้ตามวัตถุดิบที่มี"**  
            
            รูปแบบการตอบกลับ (**ต้องปฏิบัติตามโครงสร้างนี้ทุกประการ**):
            เมนูแนะนำ: [ชื่อเมนู]
            วัตถุดิบ:
            - [วัตถุดิบ1]
            - [วัตถุดิบ2]
            วิธีทำ:
            1. [ขั้นตอนที่1]
            2. [ขั้นตอนที่2]
          ''',
          'sessionid': sessionId,
          'temperature': '0.2',
        },
      ).timeout(const Duration(seconds: 30));

      print('API Response Raw: ${utf8.decode(response.bodyBytes)}');
      return _parseResponse(response);
    } catch (e) {
      throw Exception('API Error: ${e.toString()}');
    }
  }

  static Recipe _parseResponse(http.Response response) {
    if (response.statusCode == 200) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      return Recipe.fromRawString(decoded['response']);
    } else {
      throw Exception('Failed with status: ${response.statusCode}');
    }
  }
}
