import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'profile.dart'; // Import the user model

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['error'])),
        );
      } else {
        // Update global or state-managed user profile
        Provider.of<Profile>(context, listen: false).updateProfile(
          int.parse(data['id'].toString()),
          data['name'],
          int.parse(data['bestScore'].toString()),
        );

        // Navigate to another screen or update UI
        user.isLogin =true;
        Navigator.of(context).pop(); // Navigate to the previous screen
      }
    } catch (e) {
      print('An error occurred: $e');
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
                Colors.blueAccent,
                Colors.deepPurple,
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
                    SizedBox(height: 40), // Add spacing to push the fields down
                    TextField(
                      controller: _gmailController,
                      decoration: InputDecoration(
                        label: Text(
                          'Gmail',
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
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () async {
                          await _login();
                        },
                        child: Center(
                          child: Text('Sign in', style: TextStyle(fontSize: 30)),
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
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUp()),
                                );
                              },
                              child: Center(
                                child: Text('Sign up', style: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                Colors.blueAccent,
                Colors.deepPurple,
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
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _gmailController,
                      decoration: InputDecoration(
                        label: Text(
                          'Gmail',
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
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
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
