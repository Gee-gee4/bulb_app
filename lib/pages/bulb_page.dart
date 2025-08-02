import 'package:bulb_app/widgets/color_hex.dart';
import 'package:bulb_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BulbPage extends StatefulWidget {
  const BulbPage({super.key});

  @override
  State<BulbPage> createState() => _BulbPageState();
}

class _BulbPageState extends State<BulbPage> {
  bool isLoading = false;
  bool switchValue = false;

  @override
  void initState() {
    super.initState();
    fetchRelayStatus();
  }

  Future<void> fetchRelayStatus() async {
    try {
      final response = await http
          .get(Uri.parse("http://192.168.100.48/status"))
          .timeout(Duration(seconds: 3));
      if (response.statusCode == 200) {
        setState(() => switchValue = response.body.trim() == "on");
      }
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> toggleRelay(bool newValue) async {
    setState(() => isLoading = true);

    try {
      final endpoint = newValue ? "/on" : "/off";
      final response = await http
          .get(Uri.parse("http://192.168.100.48$endpoint"))
          .timeout(Duration(seconds: 3));

      if (response.statusCode == 200) {
        setState(() => switchValue = newValue);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("ESP not reachable"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/jelly/profile_p.jpeg'),
          ),
        ],
      ),
      body: Stack(
        children: [
          // New base background image
          Positioned.fill(
            child: Image.asset('assets/jelly/butter.jpeg', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                SizedBox(
                  height: 600,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/jelly/0027.png',
                    fit: BoxFit.cover,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 120,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green[200]?.withAlpha(
                          (0.5 * 255).round(),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          children: [
                            Text(
                              'Esp 01',
                              style: TextStyle(
                                fontSize: 24,
                                color: hexToColor('3e0014'),
                              ),
                            ),
                            Divider(color: hexToColor('e2b4c1')),
                            // hexToColor('e2b4c1')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Status: ',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.pink[100],
                                  ),
                                ),
                                Icon(
                                  isLoading ? Icons.sync : Icons.check_circle,
                                  color:
                                      isLoading
                                          ? Colors.orange
                                          : Colors.green[900],
                                  size: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green[200]?.withAlpha(
                          (0.5 * 255).round(),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Wifi',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: hexToColor('3e0014'),
                                  ),
                                ),
                                Icon(Icons.wifi, color: Colors.green[900]),
                              ],
                            ),
                            Divider(color: Colors.blueGrey),
                            Text(
                              'Connected: Genius ',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.pink[100],
                              ),
                            ),
                            Text(
                              'Schedule: 5.00 Pm ',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.pink[100],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  child: MyButton(
                    isLoading: isLoading,
                    switchValue: switchValue,
                    onToggle: toggleRelay,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
