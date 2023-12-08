import 'package:flutter/material.dart';
import 'package:student_online_market/database/accounts.dart';
import 'package:student_online_market/utils/reusable_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override 
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
          
                Image.asset("assets/static_images/online_market.png", height: 110),
          
                const SizedBox(height: 50),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF29953A),
                  ),
                ),
          
                const SizedBox(height: 50),
                reusableTextField("student email", false, _email),
          
                const SizedBox(height: 20),
                reusableTextField("password", true, _password),
          
                const SizedBox(height: 60),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 37, 161, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(180, 40),
                  ),
                  child: const Text(
                    'login',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    loginUser(_email.text, _password.text, context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}

