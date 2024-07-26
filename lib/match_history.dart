import 'package:flutter/material.dart';

class MatchHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match History'),
      ),
      body: Center(
        child: Text('Match History Page', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}