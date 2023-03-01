import 'package:flutter/material.dart';
import 'package:kangru/View/firstPage.dart';
import 'package:kangru/View/loading.dart';
import 'package:kangru/View/login_screen.dart';
import 'package:kangru/View/registration_screen.dart';
import 'package:kangru/View/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  if (isLoggedIn == false) {
    await prefs.setBool('isLoggedIn', true);
  }

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = widget.isLoggedIn;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _isLoggedIn = user != null;
        if (_isLoggedIn) {
          // 로그인 상태를 저장합니다.
          SharedPreferences.getInstance().then((prefs) {
            prefs.setBool('isLoggedIn', true);
          });
        } else {
          // 로그아웃 상태를 저장합니다.
          SharedPreferences.getInstance().then((prefs) {
            prefs.setBool('isLoggedIn', false);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Kangru',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: _isLoggedIn ? const Mypage() : const WelcomeScreen(),
        routes: {
          'FirstPage': (context) => const FirstPage(),
          'login_page': (context) => const LoginScreen(),
          'loadingPage': (context) => const LoadingPage(),
          'welcome': (context) => const WelcomeScreen(),
          'RegistrationScreen': (context) => const RegistrationScreen(),
        });
  }
}

class Mypage extends StatelessWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange),
      initialRoute: 'FirstPage',
      routes: {
        'FirstPage': (context) => const FirstPage(),
        'loadingPage': (context) => const LoadingPage(),
        'welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}
