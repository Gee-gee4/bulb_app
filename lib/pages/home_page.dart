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
  String relayStatus = 'Fetching...'; // Add this below ledStatus
  final String espIp = "http://192.168.100.43"; // Genius network IP

  @override
  void initState() {
    super.initState();
    fetchStatus();
    fetchRelayStatus();
  }

  Future<void> toggleLED(bool value) async {
  final String ledRoute = value ? "/on" : "/off";
  final String relayRoute = value ? "/relay/on" : "/relay/off";

  try {
    final ledResponse = await http.get(Uri.parse('$espIp$ledRoute'));
    final relayResponse = await http.get(Uri.parse('$espIp$relayRoute'));

    if (ledResponse.statusCode == 200 && relayResponse.statusCode == 200) {
      print("LED: ${ledResponse.body}, Relay: ${relayResponse.body}");
      setState(() {
        ledStatus = ledResponse.body;
      });
      await fetchRelayStatus(); // <-- Add this to update UI
    } else {
      print(
        "Failed. LED code: ${ledResponse.statusCode}, Relay code: ${relayResponse.statusCode}",
      );
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
      await fetchRelayStatus(); // <-- Add this
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


  Future<void> fetchRelayStatus() async {
    try {
      final response = await http.get(Uri.parse('$espIp/relay/status'));
      if (response.statusCode == 200) {
        setState(() {
          relayStatus = response.body;
        });
      } else {
        setState(() {
          relayStatus = 'Error fetching relay status';
        });
      }
    } catch (e) {
      setState(() {
        relayStatus = 'Connection failed';
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

            Text(
              'Relay Status: $relayStatus',
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
