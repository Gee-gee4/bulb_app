import 'package:bulb_app/widgets/color_hex.dart';
import 'package:bulb_app/widgets/my_button.dart';
import 'package:bulb_app/widgets/my_slider.dart';
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
      backgroundColor: hexToColor('00033a'),
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/jelly/1 pinker.png',
                      fit: BoxFit.fitHeight,
                      height: 700,
                    ),
                  ],
                ),
                MyButton(),
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: MediaQuery.of(context).size.height / 2 - 100,
            child: SizedBox(height: 200, width: 15, child: MySlider()),
          ),
        ],
      ),
    );
  }
}
