import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_online_market/accounts/login.dart';
import 'package:student_online_market/pages/home.dart';
import 'package:student_online_market/pages/profile.dart';

Future<void> createUser(email, password, BuildContext context) async {
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
    .then((value) {
      print("Created new account: \n$email    $password");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const UserProfile()),
      );
    }).onError((error, stackTrace) {
        print("Error: ${error.toString()}");
      });
}

Future<void> loginUser(email, password, BuildContext context) async {
  print("Login Method entered \n");
  // Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const MyApp()),
  //   );



  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
    print("===================Login successfully");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
  }).onError((error, stackTrace) {
    print("=================Error: ${error.toString()}");
  });
}

Future<void> logoutUser(BuildContext context) async {
  FirebaseAuth.instance.signOut().then((value) {
    print("Signed Out");
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const LoginPage()));
  });
}