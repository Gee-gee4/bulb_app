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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: MyButton()),
          
        ],
      ),
    );
  }
}
