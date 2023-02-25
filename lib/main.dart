import 'package:flutter/material.dart';
import 'package:kangru/View/loading.dart';
import 'package:kangru/View/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Kangru',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: const Mypage());
  }
}

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange),
      initialRoute: 'welcome',
      routes: {
        'loadingPage': (context) => const LoadingPage(),
        'welcome': (context) => WelcomeScreen(),
      },
    );
  }
}
