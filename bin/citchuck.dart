import 'dart:io';
import 'package:citchuck/citchuck.dart' as citchuck;
import 'package:citchuck/services/category_services.dart';
import 'package:dotenv/dotenv.dart' as dotenv;

void main(List<String> arguments) async {
  //Cit Random:
  final cit = await citchuck.getCitAsync();
  print('Citazione randomica');
  print(cit);


  //Cit by fixed category:
  final resCit2 = await citchuck.getCitFromCategoryAsync("animal");
  print('Citazione categoria preimpostata');
  print(resCit2);


  //Cit by ".env" category:
  final env = dotenv.DotEnv()..load();
  final resCit = await citchuck.getCitFromCategoryAsync(env['category']!); // ! = assicuriamo dart che il valore non sarà nullo
  print('Citazione categoria preimpostata file ".env"');
  print(resCit);


  //Cit by input category:
  print('Citazione categoria da input utente');
  print("Scegli il numero di una categoria:");
  final cats = await getCategories();
  for (var i = 0; i < cats.length; i++) {
    print("$i - ${cats[i]}");
  }

  final catIndex = stdin.readLineSync();  //readLineSync -> input dell'utente
  print("Categoria scelta: $catIndex");
  final cat = cats[int.parse(catIndex!)];
  print ("Input utente: $cat");
  final quote = await citchuck.getCitBySearchAsync(cat);
  print (quote);

  final saveToFile = quote.toString();
  await File("quotes.txt").writeAsString(saveToFile);
}