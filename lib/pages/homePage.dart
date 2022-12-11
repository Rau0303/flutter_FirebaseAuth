
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная страница'),

      ),
      body: SafeArea(
        child: Center(
          child: (user == null)
              ? const Text('Контент для НЕ зарегистрированных в системе')
              : const Text('Контент для зарегистрированных в системе'),
        ),
      ),
    );
  }
}
