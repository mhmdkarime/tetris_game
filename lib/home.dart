import 'package:flutter/material.dart';
import 'package:tetris_game/tetris_game/values.dart';
import 'profile.dart';
import 'player_list.dart';
import 'package:provider/provider.dart';
import 'tetris_game/tetris.dart';
import 'login.dart';
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
  void _showSignOutDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("hello ${user.name} you are already logged in \n you want to sign out ? "),
            actions: [
              TextButton(
                  child: Text('Sign out'),
                onPressed: (){
                    setState(() {
                      user.isLogin=false;
                      user.ID=-1;
                    });
                    Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: Text('cancel'),
                onPressed: (){
                    Navigator.of(context).pop();
                },
              )
            ],
          );

         }
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
            user.isLogin?user.toString():'welcome , To sign in, click the button on \n the right of the screen',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.login),
              onPressed:() {
                if(!user.isLogin){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScrenn()),);
                }
                else{
                  _showSignOutDialog();
                }
              }
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(0, 102, 255, 0.7),
                Color.fromRGBO(0, 0, 255, 1),
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
