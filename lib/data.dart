import 'dart:convert';
import 'package:http/http.dart' as http;

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
