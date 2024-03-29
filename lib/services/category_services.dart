import 'dart:convert';
import 'package:http/http.dart' as http;

const url = "https://api.chucknorris.io/jokes/categories";
final uri = Uri.parse(url);

//List<String>> --> error
Future<List<dynamic>> getCategories() async {
  final res = await http.get(uri);
  final data = json.decode(res.body);
  return data as List<dynamic>;
}