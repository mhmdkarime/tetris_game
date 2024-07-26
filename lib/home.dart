import 'package:flutter/material.dart';
import 'profile.dart';
import 'match_history.dart';
import 'player_list.dart';
import 'login_and_signup.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Profile>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
      appBar: AppBar(
        title: Text(user.toString(),style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScrenn()),
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
    )
    );
  }
}
