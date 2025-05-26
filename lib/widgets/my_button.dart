import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  const MyButton({super.key});

  @override
  State<MyButton> createState() => _ButtonState();
}

class _ButtonState extends State<MyButton> {
    bool firstSwitchValue = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              child: IconTheme.merge(
                data: IconThemeData(color: Colors.white),
                child: AnimatedToggleSwitch.dual(
                  current: firstSwitchValue,
                  first: false,
                  second: true,
                  spacing: 45,
                  animationDuration: Duration(milliseconds: 600),
                  style: ToggleStyle(
                    borderColor: Colors.transparent,
                    indicatorColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                  customStyleBuilder: (context, local, global) {
                    if (global.position <= 0) {
                      ToggleStyle(backgroundColor: Colors.red);
                    }
                    return ToggleStyle(
                      backgroundGradient: LinearGradient(
                        colors: [Colors.green, Colors.red],
                        stops: [
                          global.position -
                              (1 - 2 * max(0, global.position - 0.5)) * 0.7,
                          global.position +
                              max(0, 2 * (global.position - 0.5)) * 0.7,
                        ],
                      ),
                    );
                  },
                  borderWidth: 6,
                  height: 60,
                  loadingIconBuilder:
                      (context, global) => CupertinoActivityIndicator(
                        color: Color.lerp(
                          Colors.red,
                          Colors.green,
                          global.position,
                        ),
                      ),
                  onChanged:
                      (value) => setState(() => firstSwitchValue = value),
                  iconBuilder:
                      (value) =>
                          value
                              ? Icon(
                                Icons.power_outlined,
                                color: Colors.green,
                                size: 32,
                              )
                              : Icon(
                                Icons.power_settings_new_outlined,
                                color: Colors.red,
                                size: 32,
                              ),
                  textBuilder:
                      (value) =>
                          value
                              ? Center(
                                child: Text(
                                  'Active',
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                              : Center(
                                child: Text(
                                  'Inactive',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                ),
              ),
            );
  }
}