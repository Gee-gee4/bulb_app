// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isToggled = true; //the switch is on kama its true
  String ledStatus = 'Fetching...'; //Stores the current LED status on or off
  final String espIp = "http://192.168.100.43"; // Genius network IP

  @override
  void initState() {
    super.initState();
    fetchStatus(); // Fetch once on app start
    // // Poll every 3 seconds
    // Timer.periodic(Duration(seconds: 3), (timer) {
    //   fetchStatus();
    // });
  }

  Future<void> toggleLED(bool value) async {
    final String route = value ? "/on" : "/off";
    try {
      final response = await http.get(Uri.parse('$espIp$route'));
      if (response.statusCode == 200) {
        print("ESP response: ${response.body}");
        setState(() {
          ledStatus = response.body;
        });
      } else {
        print("Failed to toggle LED. Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchStatus() async {
    try {
      final response = await http.get(Uri.parse('$espIp/status'));
      if (response.statusCode == 200) {
        setState(() {
          ledStatus = response.body;
          isToggled = response.body.trim() == 'on';
        });
      } else {
        setState(() {
          ledStatus = 'Error fetching status';
        });
      }
    } catch (e) {
      setState(() {
        ledStatus = 'Connection failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isToggled ? 'ON' : 'OFF'),
            Switch(
              value: isToggled,
              onChanged: (value) {
                setState(() {
                  isToggled = value;
                });
                toggleLED(value);
              },
            ),
            const SizedBox(height: 40),
            Text(
              'Status from ESP: $ledStatus',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchStatus,
              child: const Text("Refresh Status"),
            ),
          ],
        ),
      ),
    );
  }
}
