
import 'package:flutter/cupertino.dart';

class Profile extends ChangeNotifier{
  int _ID;
  String _name;
  int _bestScore;
  bool _isLogin=false;
  List<int> _History =[];

  Profile(this._ID, this._name, this._bestScore);

  void updateProfile(int id, String name, int bestScore) {
    _ID = id;
    _name = name;
    _bestScore = bestScore;
    notifyListeners();
  }
  List<int> get History => _History;

  set History(List<int> value) {
    _History = value;
  }

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
  }

  int get bestScore => _bestScore;

  set bestScore(int value) {
    _bestScore = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get ID => _ID;

  set ID(int value) {
    _ID = value;
  }
  @override
  String toString() {
    return ' ${name} \n Best Score : ${bestScore} ';
  }
}
Profile user = Profile(1,'yourname',0);

