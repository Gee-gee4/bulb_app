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
      // Colors.grey[900],
      body: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                Image.asset(
                  'assets/jelly/sea bg.jpeg', // replace with your image path
                  fit: BoxFit.cover, // makes it fill the screen
                ),
                Container(
                  color: Colors.black54,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ],
            ),
          ),

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
                Text('Schedule', style: TextStyle(color: Colors.white)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myCard('Active', '6.00 ', 'PM'),
                    myCard('Inactive', '11.00 ', 'PM'),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: MediaQuery.of(context).size.height / 2 - 100,
            child: SizedBox(height: 200, width: 15, child: MySlider()),
          ),
          Positioned(
            right: 20,
            top: MediaQuery.of(context).size.height / 2 - 100,
            child: SizedBox(child: MyButton()),
          ),
          Positioned(
            left: 20,
            top: MediaQuery.of(context).size.height / 2 - 380,
            child: SizedBox(
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
