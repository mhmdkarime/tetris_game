import 'package:flutter/material.dart';


int rowLength = 10;
int colLength = 15;
class Tetris extends StatefulWidget {
  const Tetris({super.key});

  @override
  State<Tetris> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  Piece currentPiece = Piece(type: Tetromino.L);

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    Duration frameRate = const Duration(milliseconds: 400);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: GridView.builder(
          itemCount: rowLength * colLength,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: rowLength,
          ),
          itemBuilder: (context, index) {
            if (currentPiece.position.contains(index)){
              return
                Pixel(
                  color: Colors.yellow,
                  child: index.toString(),
                );
            }
            else{
              return
                Pixel(
                  color: Color.fromARGB(60, 60, 60, 100),
                  child: index.toString(),
                );
            }

                     },
        ),
      ),
    );
  }
}

class Pixel extends StatelessWidget {
  final Color color;
  final String child; // Change type to String

  Pixel({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center( // Center the text
        child: Text(
          child,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

enum Tetromino { L, J, I, O, S, Z, T }
enum Direction {left,right,down}

class Piece {
  Tetromino type;
  Piece({required this.type});

  List<int> position = [];

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [4, 14, 24, 25];
        break;
      default:

    }
  }
  void movePiece(Direction diraction) {
    switch (diraction) {
      case Direction.down:
        for (int i =0 ; i< position.length; i++){
          position[i]+= rowLength;
        }
        break;
      case Direction.left:
        for (int i =0 ; i< position.length; i++){
          position[i]-= 1;
        }
        break;
      case Direction.right:
        for (int i =0 ; i< position.length; i++){
          position[i]+= 1;
        }
        break;
      default:

    }
  }
}
