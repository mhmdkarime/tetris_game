import 'package:flutter/material.dart';
import 'profile_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Game',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
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
            Colors.black,
            Colors.blue
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
                child: Text('Play New Game',style: TextStyle(color: Colors.white)),
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
                child: Text('Match History'),
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
