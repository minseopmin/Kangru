import 'package:flutter/material.dart';
import 'package:kangru/View/loading.dart';
import 'package:kangru/View/login_screen.dart';
import 'package:kangru/View/registration_screen.dart';
import 'package:kangru/View/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

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
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _isLoggedIn = widget.isLoggedIn;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _isLoggedIn = user != null;
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool('isLoggedIn', _isLoggedIn);
        });
      });
    });
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kangru',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: _isLoggedIn ? const LoadingPage() : const WelcomeScreen(),
      routes: {
        'login_page': (context) => const LoginScreen(),
        'welcome': (context) => const WelcomeScreen(),
        'RegistrationScreen': (context) => const RegistrationScreen(),
        'loadingPage': (context) => const LoadingPage(),
      },
    );
  }

  @override
  void dispose() {
    if (mounted) {
      _prefs.setBool('isLoggedIn', _isLoggedIn);
    }
    super.dispose();
  }
}
