import 'dart:convert';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:tetris_game/player_list.dart';
import 'profile.dart';

String _baseURL='tetrisgame.atwebpages.com';
void getBestPlayer(Function(bool success) update) async {
  try {
    final url = Uri.http(_baseURL, 'SelectBestPlayers.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    bestPlayers.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Profile p = Profile( // create a product object from JSON row object
            0,
            row['name'],
            int.parse(row['best_score']),
        );
        bestPlayers.add(p); // add the product object to the _products list
      }
      update(true); // callback update method to inform that we completed retrieving data
    }
  }
  catch(e) {
    print('Error loading data with error ${e.toString()}');
    update(false); // inform through callback that we failed to get data
  }
}
