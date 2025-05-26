import 'package:bulb_app/widgets/color_hex.dart';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double currentValue = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RotatedBox(
          quarterTurns: -1,
          child: Slider(
            value: currentValue,
            min: 0,
            max: 10,
            //divisions: 4,
            //label: currentValue.toString(),
            activeColor: hexToColor('3D474E'),
            onChanged: (value) {
              setState(() {
                currentValue = value;
              });
            },
          ),
        ),
        //Text(currentValue.toString(), style: TextStyle(fontSize: 7,color: Colors.white)),
      ],
    );
  }
}
