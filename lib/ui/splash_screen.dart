import 'package:flutter/material.dart';
import 'package:pagination/utils/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigatToHome();
  }

  Future navigatToHome() async {
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, homeRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/welcome.gif",
              height: 200.0,
              width: 200.0,
            ),
            const Text(
              "Welcome",
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
