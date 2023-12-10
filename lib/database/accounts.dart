import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_online_market/accounts/login.dart';
import 'package:student_online_market/pages/home.dart';
import 'package:student_online_market/pages/profile.dart';
import 'package:super_tooltip/super_tooltip.dart';




Future<void> createUser(email, password, BuildContext context) async {
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
    .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const UserProfile()),
      );
    }).onError((error, stackTrace) {
        SuperTooltip(
          content: Text('Error: ${error.toString()}'),
          popupDirection: TooltipDirection.down,
        );
      });
}

Future<void> loginUser(email, password, BuildContext context) async {
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
    SuperTooltip(
      content: const Text('Login successfully'),
      popupDirection: TooltipDirection.down,
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
  }).onError((error, stackTrace) {
    SuperTooltip(
      content: Text('Error: ${error.toString()}'),
      popupDirection: TooltipDirection.down,
    );
  });
}

Future<void> logoutUser(BuildContext context) async {
  FirebaseAuth.instance.signOut().then((value) {
    SuperTooltip(
      content: Text('Signed out'),
      popupDirection: TooltipDirection.down,
    );
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const LoginPage()));
  });
}