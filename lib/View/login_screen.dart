import 'package:flutter/material.dart';
import 'package:kangru/Component/PadButton.dart';
import 'package:kangru/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _spinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              PadButton(
                  materialButton: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        _spinner = true;
                      });
                      try {
                        final loginUser =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                        if (loginUser != null) {
                          if (!mounted) return;
                          Navigator.of(context).pushNamed('loadingPage');
                        }
                        setState(() {
                          _spinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
//Implement login functionality.
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Log In',
                    ),
                  ),
                  colour: Colors.orangeAccent)
            ],
          ),
        ),
      ),
    );
  }
}
//hintText: 'Enter your password.'
