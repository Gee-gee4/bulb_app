import 'package:bulb_app/widgets/my_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstSwitchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF011C40),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/jelly/1 pinker.png',
              fit: BoxFit.fitHeight,
              height: 700,
            ),
            MyButton(),
          ],
        ),
      ),
    );
  }
}
