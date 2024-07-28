import 'package:flutter/material.dart';
import 'values.dart';
class Piece {
  Tetromino type;
  Piece({required this.type});

  List<int> position = [];

  Color get color{
    return tetrominaColors[type] ?? const Color(0xFFFFFFFF);
  }

  void initializePiece() {

    if(isEasy) {
      switch (type) {
        case Tetromino.L:
          position = [-26, -16, -6, -5];
          break;
        case Tetromino.J:
          position = [-25, -15, -5, -6];
          break;
        case Tetromino.I:
          position = [-27, -26, -25, -24];
          break;
        case Tetromino.O:
          position = [-16, -15, -6, -5];
          break;
        case Tetromino.S:
          position = [-26, -25, -16, -17];
          break;
        case Tetromino.Z:
          position = [-27, -26, -16, -15];
          break;
        case Tetromino.T:
          position = [-26, -16, -6, -15];
          break;
        default:
      }
    }
    else if(isMedium){
      switch (type) {
        case Tetromino.L:
          position = [-38, -23, -8, -7];
          break;
        case Tetromino.J:
          position =[-38, -23, -8, -9];
          break;
        case Tetromino.I:
          position = [-39, -38, -37, -36];
          break;
        case Tetromino.O:
          position = [-38, -37, -23, -22];
          break;
        case Tetromino.S:
          position = [-38, -37, -23, -24];
          break;
        case Tetromino.Z:
          position = [-39, -38, -23, -22];
          break;
        case Tetromino.T:
          position = [-38, -23, -8, -22];
          break;
        default:
      }

    }
    else if (isHard){
      switch (type) {
        case Tetromino.L:
          position = [-51, -31, -11, -10];
          break;
        case Tetromino.J:
          position = [-51, -31, -11, -12];
          break;
        case Tetromino.I:
          position = [-52, -51, -50, -49];
          break;
        case Tetromino.O:
          position = [-51, -50, -31, -30];
          break;
        case Tetromino.S:
          position = [-51, -50, -31, -32];
          break;
        case Tetromino.Z:
          position = [-52, -51, -31, -30];
          break;
        case Tetromino.T:
          position = [-51, -31, -11, -30];
          break;
        default:
      }
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        position = position.map((p) => p + rowLength).toList();
        break;
      case Direction.left:
        position = position.map((p) => p - 1).toList();
        break;
      case Direction.right:
        position = position.map((p) => p + 1).toList();
        break;
      default:
    }
  }
  int rotationState=1;
  void rotatePiece(){
    List<int> newPosition =[];

    switch(type){
      case Tetromino.L:
        switch(rotationState){
          case 0 :
            newPosition=[
              position[1]-rowLength,
              position[1],
              position[1]+rowLength,
              position[1]+rowLength+1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 1 :
            newPosition=[
              position[1]-1,
              position[1],
              position[1]+1,
              position[1]+rowLength-1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
          case 2 :
            newPosition=[
              position[1]+rowLength,
              position[1],
              position[1]-rowLength,
              position[1]-rowLength-1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 3 :
            newPosition=[
              position[1]-rowLength+1,
              position[1],
              position[1]+1,
              position[1]-1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
        }break;
      case Tetromino.J:
        switch(rotationState){
          case 0 :
            newPosition=[
              position[1]-rowLength,
              position[1],
              position[1]+rowLength,
              position[1]+rowLength-1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 1 :
            newPosition=[
              position[1]-rowLength-1,
              position[1],
              position[1]-1,
              position[1]+1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
          case 2 :
            newPosition=[
              position[1]+rowLength,
              position[1],
              position[1]-rowLength,
              position[1]-rowLength+1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 3 :
            newPosition=[
              position[1]+1,
              position[1],
              position[1]-1,
              position[1]+rowLength+1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
        }break;
        case Tetromino.I:
        switch(rotationState){
          case 0 :
            newPosition=[
              position[1]-1,
              position[1],
              position[1]+1,
              position[1]+2,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 1 :
            newPosition=[
              position[1]-rowLength,
              position[1],
              position[1]+rowLength,
              position[1]+2*rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
          case 2 :
            newPosition=[
              position[1]+1,
              position[1],
              position[1]-1,
              position[1]-2,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 3 :
            newPosition=[
              position[1]+rowLength,
              position[1],
              position[1]-rowLength,
              position[1]-2*rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
        }break;
        case Tetromino.O:

        break;
        case Tetromino.S:
        switch(rotationState){
          case 0 :
            newPosition=[
              position[1],
              position[1]+1,
              position[1]+rowLength-1,
              position[1]+rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 1 :
            newPosition=[
              position[0]-rowLength,
              position[0],
              position[0]+1,
              position[0]+rowLength+1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
          case 2 :
            newPosition=[
              position[1],
              position[1]+1,
              position[1]+rowLength-1,
              position[1]+rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 3 :
            newPosition=[
              position[0]-rowLength,
              position[0],
              position[0]+1,
              position[0]+rowLength+1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
        }break;
        case Tetromino.Z:
        switch(rotationState){
          case 0 :
            newPosition=[
              position[0]+rowLength-2,
              position[1],
              position[2]+rowLength-1,
              position[3]+1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 1 :
            newPosition=[
              position[0]-rowLength+2,
              position[1],
              position[2]-rowLength+1,
              position[3]-1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
          case 2 :
            newPosition=[
              position[0]+rowLength-2,
              position[1],
              position[2]+rowLength-1,
              position[3]+1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 3 :
            newPosition=[
              position[0]-rowLength+2,
              position[1],
              position[2]-rowLength+1,
              position[3]-1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
        }break;
        case Tetromino.T:
        switch(rotationState){
          case 0 :
            newPosition=[
              position[2]-rowLength,
              position[2],
              position[2]+1,
              position[2]+rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 1 :
            newPosition=[
              position[1]-1,
              position[1],
              position[1]+1,
              position[1]+rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
          case 2 :
            newPosition=[
              position[1]-rowLength,
              position[1]-1,
              position[1],
              position[1]+rowLength,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            }
            break;
          case 3 :
            newPosition=[
              position[2]-rowLength,
              position[2]-1,
              position[2],
              position[2]+1,
            ];
            if(piecePositionIsValid(newPosition)){
              position =newPosition;
              rotationState = (rotationState+1)%4;
            };
            break;
        }break;
      default:
    }
  }

  bool positionIsValid(int position){
    int row = (position / rowLength).floor();
    int col = position % rowLength;
    if(row<0 || col<0 || gameBoard[row][col]!=null){
      return false;
    }
    else{
      return true;
    }

  }
  bool piecePositionIsValid(List<int>piecePosition){

    bool firstColOccupied =false;
    bool lastColOccupied =false;
    for(int pos in piecePosition){

      if(!positionIsValid(pos)){
        return false ;
      }

      int col = pos% rowLength;

      if(col==0){
        firstColOccupied=true;
      }
      if(col == rowLength-1){
        lastColOccupied =true;
      }
    }
    return !(firstColOccupied && lastColOccupied);
  }

}