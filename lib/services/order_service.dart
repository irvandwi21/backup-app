import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  static const String baseUrl =
      "http://192.168.202.151:8000/api";

  Future<bool> createOrder({
    required int productId,
    required int quantity,
  }) async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    String? token =
        prefs.getString("token");

    final response = await http.post(
      Uri.parse("$baseUrl/orders"),

      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },

      body: {
        "product_id": productId.toString(),
        "quantity": quantity.toString(),
      },
    );

    print(response.body);

    return response.statusCode == 200 ||
        response.statusCode == 201;
  }
}