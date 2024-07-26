import 'package:flutter/material.dart';
import 'package:tetris_game/profile.dart';
import 'match_history.dart';
import 'player_list.dart';
import 'login_and_signup.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: PlayGamePage(),
    );
  }
}

class PlayGamePage extends StatelessWidget {
  Profile user = Profile(1,'your name',0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.toString(),style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loginScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.deepPurpleAccent,

          ])
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  // Navigate to play new game page
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => page()),
                  // );
                },
                child: SizedBox(
                  height: 70,
                  width: 200
                  ,child:Center(
                  child: Text('Play New Game',style: TextStyle(color: Colors.white ,fontSize: 25)) ,
                ),
              ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MatchHistoryPage()),
                  );
                },
                child: Text('Match History',style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.leaderboard, color: Colors.white),
              onPressed: () {
                // Navigate to best player list page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BestPlayerListPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
