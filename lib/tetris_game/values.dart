import 'package:flutter/material.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
      (i) => List.generate(
    rowLength,
        (j) => null,
  ),
);

int rowLength = 10;
int colLength = 15;


enum Tetromino { L, J, I, O, S, Z, T }
enum Direction { left, right, down }


const Map<Tetromino ,Color> tetrominaColors ={
  Tetromino.L:Colors.orange,
  Tetromino.J:Colors.blueAccent,
  Tetromino.I:Colors.pinkAccent,
  Tetromino.O:Colors.yellow,
  Tetromino.S:Colors.green,
  Tetromino.Z:Colors.red,
  Tetromino.T:Colors.purple,

};

class Pixel extends StatelessWidget {
  final Color color;
  final String child;

  Pixel({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          child,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}