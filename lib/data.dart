import 'dart:convert';
import 'package:http/http.dart' as http;

/*
Future<void> fetchPosts() async {
  final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> posts = json.decode(response.body);
      for (var post in posts) {
        print(post['title']);
      }
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print("erreur ;: ${e}");
  }
}
*/
Future<List<Map<String, dynamic>>> fetchProductsFromApi() async {
  final response = await http.get(
    Uri.parse("https://fakestoreapi.com/products"),
  );

  if (response.statusCode == 200) {
    final List data = json.decode(response.body);
    return data.map((product) {
      return {
        "name": product['title'],
        "price": product['price'],
        'imageUrl': product['image'],
      };
    }).toList();
  } else {
    throw Exception('erreur');
  }
}
