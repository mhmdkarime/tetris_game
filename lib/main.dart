import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile.dart'; // Import the user model
import 'home.dart'; // Import your home page

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Profile(0, '', 0),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
