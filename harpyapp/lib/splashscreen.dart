import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplahsScreen extends StatefulWidget {
  final String title;
  const SplahsScreen({required this.title, super.key});

  @override
  State<SplahsScreen> createState() => _SplahsScreenState();
}

class _SplahsScreenState extends State<SplahsScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushNamed(
            context, currentUser != null ? "home" : "signin"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: const Color.fromRGBO(192, 137, 81, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo_white.png",
              width: MediaQuery.of(context).size.width * 3 / 4,
            ),
            const Text(
              "Harpy for Job",
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
            const SizedBox(
              height: 50,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
