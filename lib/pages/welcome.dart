import 'package:flutter/material.dart';
import '../accounts/login.dart';
import '../accounts/signup.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Market',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 26, 192, 67)),
        useMaterial3: false,
      ),
      home: const WelcomePageDesign()
    );
  }
}

class WelcomePageDesign extends StatefulWidget {
  const WelcomePageDesign({super.key});

  @override
  State<WelcomePageDesign> createState() => _WelcomePageDesignState();
}

class _WelcomePageDesignState extends State<WelcomePageDesign> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset("assets/static_images/online_market.png", height: 270),

              const SizedBox(height: 70),
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF29953A),
                ),
              ),

              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 37, 161, 56),
                      
                      minimumSize: const Size(140, 40),
                    ),
                    child: const Text(
                      'login',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    onPressed:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                    }
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 37, 161, 56),
                      minimumSize: const Size(140, 40),
                    ),
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    onPressed:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupPage()),
                      );
                  }
                  )
                ]
              )
            ],
          ),
        ),
      ),
      );
  }
}
