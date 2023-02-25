import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../Component/PadButton.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation animationColor;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1), //how long does it go on,
      vsync: this,
      //upperBound: 100.0,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animationColor = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animationColor.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 70,
                ),
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: animation.value * 100,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const Text(
                  '韓グル',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            PadButton(
              materialButton: MaterialButton(
                onPressed: () {
                  null;
                },
                minWidth: 200.0,
                height: 42.0,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Log in',
                        speed: const Duration(milliseconds: 100)),
                  ],
                ),
              ),
              colour: Colors.orangeAccent,
            ),
            PadButton(
                materialButton: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/RegistrationScreen');
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                  ),
                ),
                colour: Colors.orange),
          ],
        ),
      ),
    );
  }
}
