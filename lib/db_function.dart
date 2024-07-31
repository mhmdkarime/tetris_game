import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:tetris_game/player_list.dart';
import 'profile.dart';
import 'tetris_game/tetris.dart';
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
        Profile p = Profile(
            0,
            row['name'],
            int.parse(row['best_score']),
        );
        bestPlayers.add(p);
      }
      update(true);
    }
  }
  catch(e) {
    print('Error loading data with error ${e.toString()}');
    update(false);
  }
}

Future<void> insertBestScore(int id, int bestScore) async {
  try {
    final url = Uri.http(_baseURL, 'InsertBestScore.php', {
      'id': '$id',
      'best_score': '$bestScore',
    });
    final response = await http.get(url).timeout(const Duration(seconds: 5));


    if (response.statusCode == 200) {
      if (response.body.contains("Best score updated successfully")) {

      } else {
        print('Error message from server: ${response.body}');
      }
    } else {
      print('Failed to update best score. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error updating best score: ${e.toString()}');
  }
}

void editBestScore(int id,int bestS) async{

   await insertBestScore(id, bestS);

}
