import 'dart:math';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cor Aleatória',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomColorPage(),
    );
  }
}

class RandomColorPage extends StatefulWidget {
  @override
  _RandomColorPageState createState() => _RandomColorPageState();
}

class _RandomColorPageState extends State<RandomColorPage> {
  Color _textColor = Colors.black;

  void _mudarCor() {
    setState(() {
      _textColor = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cor Aleatória'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Toque no botão para mudar a cor',
              style: TextStyle(fontSize: 20.0, color: _textColor),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _mudarCor,
              child: const Text('Sortear cor'),
            ),
          ],
        ),
      ),
    );
  }
}
