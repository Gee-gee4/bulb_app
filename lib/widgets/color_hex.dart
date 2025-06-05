import 'dart:ui';

import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  return Color(int.parse('0xFF$hex'));
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
Card myCard(String statusText,String timeText,String pmAmText) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    color: hexToColor('9b459e'),
    child: SizedBox(
      height: 120,
      width: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(statusText,style: TextStyle(color: Colors.white38,fontWeight: FontWeight.w500)),
          SizedBox(height: 5),
          Container(
            height: 40,
            width: 130,
            decoration: BoxDecoration(
              color:hexToColor('c365fc'),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Row(
                  children: [
                    Text(timeText,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),
                    Text(pmAmText,style: TextStyle(color: Colors.white24),)
                  ],
                ), Icon(Icons.keyboard_arrow_down)],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
