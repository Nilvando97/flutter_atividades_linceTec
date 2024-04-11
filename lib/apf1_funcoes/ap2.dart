import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Botão Correto',
      home: ButtonGame(),
    );
  }
}

class ButtonGame extends StatefulWidget {
  @override
  _ButtonGameState createState() => _ButtonGameState();
}

class _ButtonGameState extends State<ButtonGame> {
  String? _correctButton;
  int _attempts = 0;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _generateCorrectButton();
  }

  void _generateCorrectButton() {
    final Random random = Random();
    final List<String> buttons = ['A', 'B', 'C'];
    _correctButton = buttons[random.nextInt(3)];
  }

  void _checkButton(String buttonText) {
    if (buttonText == _correctButton) {
      setState(() {
        _gameOver = true;
        _attempts = 0;
      });
    } else {
      setState(() {
        _attempts++;
        if (_attempts == 2) {
          _gameOver = true;
        }
      });
    }
  }

  void _resetGame() {
    setState(() {
      _gameOver = false;
      _generateCorrectButton();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Botão Correto'),
      ),
      body: Center(
        child: _gameOver
            ? Container(
                color: _attempts == 2 ? Colors.red : Colors.green,
                child: _attempts == 2
                    ? const Text('Você perdeu',
                        style: TextStyle(fontSize: 24.0))
                    : const Text('Você ganhou',
                        style: TextStyle(fontSize: 24.0)),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _checkButton('A'),
                    child: const Text('A'),
                  ),
                  ElevatedButton(
                    onPressed: () => _checkButton('B'),
                    child: const Text('B'),
                  ),
                  ElevatedButton(
                    onPressed: () => _checkButton('C'),
                    child: const Text('C'),
                  ),
                ],
              ),
      ),
    );
  }
}
