import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class MyButton extends StatelessWidget {
  final bool isLoading;
  final bool switchValue;
  final Future<void> Function(bool) onToggle;

  const MyButton({
    super.key,
    required this.isLoading,
    required this.switchValue,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedToggleSwitch.dual(
          current: switchValue,
          first: false,
          second: true,
          spacing: 45,
          style: ToggleStyle(
            borderColor: Colors.transparent,
            indicatorColor: Colors.white,
            backgroundColor:
                switchValue ? Colors.pink[200] : Colors.blueGrey[300],
          ),
          animationDuration: Duration(milliseconds: 500),
          height: 60,
          loadingIconBuilder: (context, global) {
            return CupertinoActivityIndicator();
          },
          onChanged: (value) {
            if (!isLoading) onToggle(value);
          },
          iconBuilder: (value) => Icon(
            value ? Icons.power : Icons.power_off,
            color: value ? Colors.pink[300] : Colors.blueGrey,
            size: 32,
          ),
          textBuilder: (value) => Center(
            child: Text(
              value ? "Active" : "Inactive",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

