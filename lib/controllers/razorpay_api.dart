import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/items_model.dart';

class RazorpayAPI {
  static const String baseUrl = 'https://api.razorpay.com/v1/items';
  static final String basicAuth =
      'Basic ${base64Encode(utf8.encode('rzp_test_qzRrLnPouG96ZZ:hDvjAXqIOA3zKcW4pzBeHhPS'))}';

  static createItem(Item item) async {
    try {
      await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': basicAuth,
        },
        body: {
          "name": item.name,
          "description": item.description,
          "amount": "5000",
          "currency": "INR"
        },
      );
    } catch (e) {
      print("error : $e");
    }
  }

  static Future<List<Item>> getItems() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': basicAuth,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> a = data['items'];
      return a.map((e) => Item.fromJson(e)).toList();
    } else {
      print('Failed to get');
      return <Item>[];
    }
  }

  static updateItem(Item item) async {
    try{
      final response = await http.patch(
        Uri.parse('$baseUrl/${item.id}'),
        headers: {
          'Authorization': basicAuth,
        },
        body: {
          "name": item.name,
          "description": item.description
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    }catch(e){
      print("error : $e");
    }
  }

  static Future<void> deleteItem(String itemId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$itemId'),
      headers: {
        'Authorization': basicAuth,
      },
    );

    if (response.statusCode == 200) {
      print('Item deleted successfully');
    }
  }
}
