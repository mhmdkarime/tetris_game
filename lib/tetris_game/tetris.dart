import 'dart:async';
import 'dart:math';
import 'values.dart';
import 'piece.dart';

import 'package:flutter/material.dart';



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
    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
          handleLanding();
          currentPiece.movePiece(Direction.down);

      });
    });
  }

  bool checkCollision(Direction direction) {

    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= colLength || col < 0 || col >= rowLength || (row >= 0 && gameBoard[row][col] != null)) {
        return true;
      }

    }
    return false;
  }

  void handleLanding() {
    // Place the piece on the board
    if(checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;

        }
      }
      // Create a new piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType = Tetromino.values[rand.nextInt(Tetromino.values.length)];
    setState(() {
      currentPiece = Piece(type: randomType);
      currentPiece.initializePiece();
    });
  }
  void moveLeft(){
     if(!checkCollision(Direction.left)){
        setState(() {
          currentPiece.movePiece(Direction.left);
        });

     }
  }
  void moveRotate(){
  setState(() {
    currentPiece.rotatePiece();
  });

  }
  void moveRight(){
    if(!checkCollision(Direction.right)){
      setState(() {
        currentPiece.movePiece(Direction.right);
      });

    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: rowLength * colLength,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLength,
                ),
                itemBuilder: (context, index) {
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;
              
                  if (currentPiece.position.contains(index)){
                    return
                      Pixel(
                        color: Colors.yellow,
                        child: index.toString(),
                      );
                  }
                  else if(gameBoard[row][col] != null ){
                    final Tetromino? tetrominoType =gameBoard[row][col];
                    return Pixel(color: tetrominaColors[tetrominoType]!, child: '');
              
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
            Padding(
              padding: const EdgeInsets.only(top:  50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: moveLeft, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),
                  IconButton(onPressed: moveRotate, icon: Icon(Icons.rotate_right),color: Colors.white),
                  IconButton(onPressed: moveRight, icon: Icon(Icons.arrow_forward_ios),color: Colors.white),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}







