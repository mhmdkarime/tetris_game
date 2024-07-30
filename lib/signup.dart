import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'profile.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSignUp = true;

  Future<void> _signUp() async {
    final response = await http.post(
      Uri.parse('http://tetrisgame.atwebpages.com/InsertUser.php'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'name': _nameController.text,
        'gmail': _gmailController.text,
        'password': _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["success"] != null) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Account successfully created",
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server error: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(246, 1, 255, 1.0),
                Color.fromRGBO(246, 1, 255, 0.4),
              ]),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 20.0, left: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.navigate_before),
                  ),
                  Text(
                    'Hello\nSign Up!',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40), // Add spacing to push the fields down
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        label: Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(104, 253, 2, 1.0),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _gmailController,
                      decoration: InputDecoration(
                        label: Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(104, 253, 2, 1.0),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Color.fromRGBO(104, 253, 2, 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 70),
                    Container(
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(
                              56, 253, 2, 1.0)),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () {
                          _signUp();
                        },
                        child: Center(
                          child: Text('Sign Up', style: TextStyle(fontSize: 30)),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(height: 20), // Add spacing to push the fields up when keyboard appears
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}