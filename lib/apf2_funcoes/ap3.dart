import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShapeScreen(),
    );
  }
}

class ShapeScreen extends StatefulWidget {
  @override
  _ShapeScreenState createState() => _ShapeScreenState();
}

class _ShapeScreenState extends State<ShapeScreen> {
  bool isCircle = true;
  Color formaCor = Colors.blue;

  void alterarForma() {
    setState(() {
      isCircle = !isCircle;
    });
  }

  void mudarCor() {
    setState(() {
      formaCor = Color(Random().nextInt(0xffffffff));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                color: formaCor,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: alterarForma,
              child: Text(
                  isCircle ? 'Alterar para quadrado' : 'Alterar para círculo'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: mudarCor,
              child: const Text('Cor aleatória'),
            ),
          ],
        ),
      ),
    );
  }
}
