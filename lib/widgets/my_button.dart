import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyButton extends StatefulWidget {
  const MyButton({super.key});

  @override
  State<MyButton> createState() => _ButtonState();
}

class _ButtonState extends State<MyButton> {
  bool firstSwitchValue = false;
  bool isLoading = false;
  final String espIP = "http://192.168.100.48";

  @override
  void initState() {
    super.initState();
    fetchRelayStatus();
  }

  Future<void> fetchRelayStatus() async {
    try {
      final response = await http
          .get(Uri.parse("$espIP/status"))
          .timeout(Duration(seconds: 3));
      if (response.statusCode == 200) {
        setState(() => firstSwitchValue = response.body.trim() == "on");
      }
    } catch (e) {
      // Optional: Show warning ESP not reachable
    }
  }

  Future<void> toggleRelay(bool newValue) async {
    setState(() => isLoading = true);

    try {
      final endpoint = newValue ? "/on" : "/off";
      final response = await http
          .get(Uri.parse("$espIP$endpoint"))
          .timeout(Duration(seconds: 3));

      if (response.statusCode == 200) {
        setState(() => firstSwitchValue = newValue);
      } else {
        showError("Unexpected response from ESP.");
      }
    } catch (e) {
      showError("Cannot reach ESP. Is the bulb switch ON and on same Wi-Fi?");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showError(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedToggleSwitch.dual(
          current: firstSwitchValue,
          first: false,
          second: true,
          spacing: 45,
          style: ToggleStyle(
            borderColor: Colors.transparent,
            indicatorColor: Colors.white,
            backgroundColor: firstSwitchValue ? Colors.green : Colors.red,
          ),
          animationDuration: Duration(milliseconds: 500),
          height: 60,
          loadingIconBuilder: (context, global) {
            return CupertinoActivityIndicator(); // always show loading indicator if defined
          },
          onChanged: (value) {
            if (!isLoading) toggleRelay(value);
          },
          iconBuilder:
              (value) => Icon(
                value ? Icons.power : Icons.power_off,
                color: value ? Colors.green : Colors.red,
                size: 32,
              ),
          textBuilder:
              (value) => Center(
                child: Text(
                  value ? "Active" : "Inactive",
                  style: TextStyle(fontSize: 18),
                ),
              ),
        ),
      ],
    );
  }

  Row myRowStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Status: "),
        Icon(
          isLoading ? Icons.sync : Icons.check_circle,
          color: isLoading ? Colors.orange : Colors.green,
        ),
      ],
    );
  }
}
