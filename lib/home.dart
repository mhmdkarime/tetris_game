import 'package:flutter/material.dart';
import 'package:tetris_game/tetris_game/values.dart';
import 'profile.dart';
import 'player_list.dart';
import 'login_and_signup.dart';
import 'package:provider/provider.dart';
import 'tetris_game/tetris.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _difficulty = 'Hard';
  String _color = 'Dark';


  void _showGameSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String tempDifficulty = _difficulty;
        String tempColor = _color;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Game Settings'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Difficulty:'),
                      DropdownButton<String>(
                        value: tempDifficulty,
                        items: <String>['Easy', 'Medium', 'Hard'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            if(newValue == 'Easy'){
                              isEasy=true;
                              isMedium=false;
                              isHard=false;
                            }
                            else if(newValue == 'Medium'){
                              isEasy=false;
                              isMedium=true;
                              isHard=false;
                            }
                            else{
                              isEasy=false;
                              isMedium=false;
                              isHard=true;
                            }
                            tempDifficulty = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Color:'),
                      DropdownButton<String>(
                        value: tempColor,
                        items: <String>['Dark', 'White'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            if(newValue == 'Dark'){
                              print("dark");
                               backGroundColor = Colors.black;
                               pixelColor = Color.fromRGBO(60, 60, 60, 1);
                               iconButtonsColor = Colors.white;
                            }
                            else{
                              print("white");
                               backGroundColor = Colors.white;
                               pixelColor = Color.fromRGBO(150, 150, 150, 1);
                               iconButtonsColor = Colors.black;
                            }
                            tempColor = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    setState(() {
                      _difficulty = tempDifficulty;
                      _color = tempColor;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Profile>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            user.toString(),
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
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
              ])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      if(isEasy){
                        rowLength=10;
                        colLength=15;
                      }else if(isMedium){
                        rowLength=15;
                        colLength=23;
                      }else if(isHard){
                        rowLength=20;
                        colLength=30;
                      }
                    });
                    gameBoard = List.generate(colLength, (i) => List.generate(rowLength, (j) => null,),);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tetris()),
                    );
                  },
                  child: SizedBox(
                    height: 70,
                    width: 200,
                    child: Center(
                      child: Text(
                        'Play New Game',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      if(isEasy){
                        rowLength=10;
                        colLength=15;
                      }else if(isMedium){
                        rowLength=15;
                        colLength=23;
                      }else if(isHard){
                        rowLength=20;
                        colLength=30;
                      }
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tetris()),
                    );
                  },
                  child: SizedBox(
                    height: 70,
                    width: 200,
                    child: Center(
                      child: Text(
                        'Resume game',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: _showGameSettingsDialog,
                  child: Text('Game setting', style: TextStyle(color: Colors.white)),
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
      ),
    );
  }
}
