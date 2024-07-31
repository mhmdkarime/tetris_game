import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tetris_game/tetris_game/values.dart';
import 'profile.dart';
import 'signup.dart';
import 'package:encrypt_shared_preferences/provider.dart';

class LoginScrenn extends StatefulWidget {
  const LoginScrenn({super.key});

  @override
  State<LoginScrenn> createState() => _LoginScrennState();
}

class _LoginScrennState extends State<LoginScrenn> {
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {

    try {
      final response = await http.post(
        Uri.parse('http://tetrisgame.atwebpages.com/CheckUser.php'),
        body: {
          'gmail': _gmailController.text,
          'password': _passwordController.text,
        },
      );

      final data = json.decode(response.body);

      if (data['error'] != null) {
        print(data['error']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['error'])),
        );
      } else {
        user = Provider.of<Profile>(context, listen: false);
        user.updateProfile(
          int.parse(data['id'].toString()),
          data['name'],
          int.parse(data['bestScore'].toString()),
        );

        highestScore=int.parse(data['bestScore'].toString());
        user.isLogin = true;
        Navigator.of(context).pop(); // Navigate to the previous screen
      }
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
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
                Color.fromRGBO(255, 100, 0, 1),
                Color.fromRGBO(255, 100, 0, 0.55),
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
                    'Hello\nSign In!',
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
                    SizedBox(height: 40),
                    // Add spacing to push the fields down
                    TextField(
                      controller: _gmailController,
                      decoration: InputDecoration(
                        label: Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
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
                            color: Colors.blue,
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
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.black),
                        ),
                        onPressed: () async {
                          await _login();
                        },
                        child: Center(
                          child: Text('Sign in',
                              style: TextStyle(fontSize: 30)),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            width: 101,
                            height: 20,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                    Color>(Colors.blue),
                                foregroundColor: MaterialStateProperty.all<
                                    Color>(Colors.black),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()),
                                );
                              },
                              child: Center(
                                child: Text(
                                    'Sign up', style: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Add spacing to push the fields up when keyboard appears
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