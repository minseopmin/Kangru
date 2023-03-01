import 'package:flutter/material.dart';
import 'package:kangru/Component/PadButton.dart';
import 'package:kangru/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:email_validator/email_validator.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  String? _emailErrorText;
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
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 300.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) {
                      if (email == null || !EmailValidator.validate(email)) {
                        return 'Enter a valid email';
                      } else if (_emailErrorText != null) {
                        final errorText = _emailErrorText;
                        _emailErrorText = null;
                        return errorText;
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Enter min. 6 digit';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 24.0,
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
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            if (!mounted) return;
                            Navigator.of(context).pushNamed('loadingPage');
                          }
                          setState(() {
                            _spinner = false;
                          });
                        } on FirebaseAuthException catch (e) {
                          print(e.code);
                          if (e.code == 'email-already-in-use') {
                            setState(() {
                              _emailErrorText =
                                  'This email is already registered';
                            });
                          }
                          setState(() {
                            _spinner = false;
                          });
                        } //Implement registration functionality.
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    colour: Colors.orange),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
