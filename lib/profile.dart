
class Profile{
  int _ID;
  String _name;
  int _bestScore;
  bool _isLogin=false;
  List<int> _History =[];

  Profile(this._ID, this._name, this._bestScore);

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
    return 'Name : ${name} \n Best Score : ${bestScore} ';
  }
}


