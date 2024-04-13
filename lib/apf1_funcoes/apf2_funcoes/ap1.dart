import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Retângulos coloridos'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                  margin: const EdgeInsets.all(8),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.green,
                  margin: const EdgeInsets.all(8),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                  margin: const EdgeInsets.all(8),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.purple,
                  margin: const EdgeInsets.all(8),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.cyan,
                  margin: const EdgeInsets.all(8),
                ),
              ],
            ),
            Container(
              width: 50,
              height: 100,
              color: Colors.purple,
              margin: const EdgeInsets.all(8),
            ),
            Container(
              width: 50,
              height: 100,
              color: Colors.cyan,
              margin: const EdgeInsets.all(8),
            ),
          ],
        ),
      ),
    );
  }
}
