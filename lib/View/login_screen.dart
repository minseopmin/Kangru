import 'package:flutter/material.dart';
import 'package:kangru/Component/PadButton.dart';
import 'package:kangru/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  String? _errorText;
  String? _passwordError;
  bool _spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _spinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
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
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email'),
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) {
                      if (email == null || !EmailValidator.validate(email)) {
                        return 'Enter a valid email';
                      } else if (_errorText != null) {
                        final errorMessage = _errorText;
                        _errorText = null;
                        return errorMessage;
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Enter min. 6 digit';
                    } else if (_passwordError != null) {
                      final errorMessage = _passwordError;
                      _passwordError = null;
                      return errorMessage;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                PadButton(
                    materialButton: MaterialButton(
                      onPressed: () async {
                        final isValid = _formKey.currentState!.validate();
                        if (!isValid) return;
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
                            setState(() {
                              _spinner = false;
                            });
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            setState(() {
                              _errorText = 'user-not-found';
                              _passwordError = null;
                            });
                          } else if (e.code == 'wrong-password') {
                            setState(() {
                              _passwordError = 'wrong-password';
                              _errorText = null;
                            });
                          }
                        }
                        setState(() {
                          _spinner = false;
                        });
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
      ),
    );
  }
}
