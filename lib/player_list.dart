import 'package:flutter/material.dart';

class BestPlayerListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Best Player List'),
      ),
      body: Center(
        child: Text('Best Player List Page', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}