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
  Piece currentPiece = Piece(type: Tetromino.I);
  bool gameOver =false;
  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();
    Duration frameRate;

    if (isHard) {
      frameRate = Duration(milliseconds: (400 - (score/2)).clamp(100,400).toInt()); // Ensure non-negative and reasonable values
    } else if (isMedium) {
      frameRate = Duration(milliseconds: (500 - (score/1.5)).clamp(100,500).toInt());
    } else if (isEasy) {
      frameRate = Duration(milliseconds: (700 - (score)).clamp(100,700).toInt());
    } else {
      throw ArgumentError('No difficulty level set');
    }

    gameLoop(frameRate);
  }


  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
          clearLines();
          handleLanding();
          if(gameOver==true){
            timer.cancel();
            showGameOverDialog();
          }
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
      if(isGameOver()){
        gameOver = true;
      }

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

 void clearLines(){

    for(int row = colLength-1;row>=0;row-- ){
      bool rowIsFull=true;
      for(int col =0 ;col<rowLength ;col++){
        if(gameBoard[row][col] ==null) {
          rowIsFull = false;
          break;
        }
      }
      if(rowIsFull){
        for(int r = row ; r>0;r--){
          gameBoard[r] = List.from(gameBoard[r-1]);
        }
        gameBoard[0]=List.generate(row, (index) =>null);
        score+=20;
      }
    }
 }
 bool isGameOver(){
    for(int col =0; col<rowLength;col++){
      if(gameBoard[0][col]!=null){
        return true;
      }
    }
    return false;
 }
 void showGameOverDialog(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text('Game Over'),
      content: Text("your score is: $score"),
      actions: [
        TextButton(onPressed: (){
          resetGame();
          Navigator.pop(context);
        }, child: Text('play again')),
        TextButton(onPressed: (){
          returnToHomePage();

        }, child: Text('return to home page'))

      ],
    )
    );

 }
 void resetGame(){
    gameBoard = List.generate(
     colLength,
         (i) => List.generate(
       rowLength,
           (j) => null,
     ),
   );
  gameOver = false;
   if(score > highestScore){
     highestScore = score;
   }
   score = 0;
   createNewPiece();
   startGame();
 }

 void returnToHomePage(){
   gameBoard = List.generate(
     colLength,
         (i) => List.generate(
       rowLength,
           (j) => null,
     ),
   );
   if(score > highestScore){
     highestScore = score;
   }
   score = 0;
   Navigator.pop(context);
   Navigator.of(context).pop();

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
                      );
                  }
                  else if(gameBoard[row][col] != null ){
                    final Tetromino? tetrominoType =gameBoard[row][col];
                    return Pixel(color: tetrominaColors[tetrominoType]!);
              
                  }
                  else{
                    return
                      Pixel(
                        color: Color.fromARGB(60, 60, 60, 100),
                      );
                  }
                },
              ),
            ),
            Text('Score: $score',style: TextStyle(color: Colors.white),),
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







