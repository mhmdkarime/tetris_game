import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home:
      Scaffold(
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
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Hello\nSign in!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child:  Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                            label: Text('Gmail',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Colors.blue,
                            ),)
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                            label: Text('Password',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Colors.blue,
                            ),)
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const SizedBox(height: 70,),
                      Container(
                          width: 200,

                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:MaterialStateProperty.all<Color>(Colors.blue),
                              foregroundColor:MaterialStateProperty.all<Color>(Colors.black),
                            ),
                              onPressed: (){},
                              child: Center(child:  Text('Sign in' ,style: TextStyle(fontSize: 30),)))),
                      const SizedBox(height: 50,),
                       Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Don't have account?",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),),
                        Container(
                            width: 100,
                            height: 20,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:MaterialStateProperty.all<Color>(Colors.blue),
                                  foregroundColor:MaterialStateProperty.all<Color>(Colors.black),
                                ),
                                onPressed: (){},
                                child: Center(child:  Text('Sign in' ,style: TextStyle(fontSize: 15),)))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
