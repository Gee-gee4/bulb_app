import 'package:bulb_app/widgets/color_hex.dart';
import 'package:bulb_app/widgets/my_button.dart';
import 'package:flutter/material.dart';

class BulbPage extends StatefulWidget {
  const BulbPage({super.key});

  @override
  State<BulbPage> createState() => _BulbPageState();
}

class _BulbPageState extends State<BulbPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [Icon(Icons.person)],
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
                        color: Colors.grey[600]?.withAlpha((0.9 * 255).round()),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Status: ',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.pink[100],
                                  ),
                                ),
                                Icon(
                                  Icons.circle,
                                  color: Colors.green[900],
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
                        color: Colors.grey[600]?.withAlpha((0.9 * 255).round()),
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
                            Divider(color: hexToColor('e2b4c1')),
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

                MyButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
