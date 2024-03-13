import "dart:convert";
import "package:http/http.dart" as http;
//import "package:dotenv/dotenv.dart" as uri;

const stringUrl = "https://api.chucknorris.io/jokes/random?format=json";
const stringWithCategory = "https://api.chucknorris.io/jokes/random?category={category}";
const stringSearch = "https://api.chucknorris.io/jokes/search";
final url = Uri.parse(stringUrl);
final urlWithSearchSegment = Uri.parse(stringSearch);

Future<Cit> getCitAsync() async {
  final res = await http.get(url);
  return Cit.fromJson(res.body);
}

Future<Cit> getCitFromCategoryAsync(String category) async {
  final urlWithCategory = url.replace(queryParameters: {'category': category});
  final res = await http.get(urlWithCategory);
  return Cit.fromJson(res.body);
}

Future<List<Cit>> getCitBySearchAsync(String searchParam) async {
  final urlWithSearch = urlWithSearchSegment.replace(queryParameters: {'query': searchParam});
  final res = await http.get(urlWithSearch);
  final data = json.decode(res.body);
  final list = data['result'] as List;
  final cfs = list.map((e) => Cit.fromMap(e as Map<String, dynamic>)).toList();
  return cfs;
}

class Cit {
  String id;
  String cit;
  String createdAt;

  Cit({required this.id,required this.cit,required this.createdAt});

  //factory method -> "nome classe"."nome metodo"
  factory Cit.fromJson(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    return Cit.fromMap(data);
  }

  factory Cit.fromMap(Map<String, dynamic> map){
    final fact = Cit(id: map['id'],cit: map['value'],createdAt: map['created_at']);
    return fact;
  }

  @override
  String toString() {
    return """
      ID: $id
      Date: $createdAt
      Quote: $cit
      
    """;
  }
}