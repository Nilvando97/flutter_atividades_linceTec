import 'package:flutter/material.dart';
import 'dart:math';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

enum JogoEstado { Jogando, Ganhou, Perdeu }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final random = Random();

  var botaoCorreto = 0;
  var clicks = 0;
  var estado = JogoEstado.Jogando;
  var vitorias = 0;
  var derrotas = 0;

  // Esse método é chamado somente uma vez, ao iniciar o state
  @override
  void initState() {
    super.initState();

    // Escolher um número de 0 a 2 para identificar escolher o botão correto
    botaoCorreto = random.nextInt(3);
  }

  // Tratar a tentativa do usuário
  void tentativa(int opcao) {
    setState(() {
      // Verificar se o jogo já foi finalizado
      if (estado != JogoEstado.Jogando) {
        return;
      }

      // Verificar se a opção escolhida está correta
      if (opcao == botaoCorreto) {
        estado = JogoEstado.Ganhou;
        vitorias++;
      } else {
        // Se estiver errada, incrementa o contador de clicks
        clicks++;
        if (clicks >= 2) {
          estado = JogoEstado.Perdeu;
          derrotas++;
        }
      }
    });
  }

  // Reiniciar o jogo
  void reiniciarJogo() {
    setState(() {
      botaoCorreto = random.nextInt(3);
      clicks = 0;
      estado = JogoEstado.Jogando;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (estado) {
      case JogoEstado.Jogando:
        return Column(
          children: [
            ElevatedButton(
              child: const Text('A'),
              onPressed: () {
                tentativa(0);
              },
            ),
            ElevatedButton(
              child: const Text('B'),
              onPressed: () {
                tentativa(1);
              },
            ),
            ElevatedButton(
              child: const Text('C'),
              onPressed: () {
                tentativa(2);
              },
            ),
          ],
        );
      case JogoEstado.Ganhou:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.green,
              child: const Text('Você ganhou'),
            ),
            ElevatedButton(
              onPressed: reiniciarJogo,
              child: const Text('Jogar novamente'),
            ),
            Text('Vitórias: $vitorias, Derrotas: $derrotas'),
          ],
        );
      case JogoEstado.Perdeu:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.red,
              child: const Text('Você perdeu'),
            ),
            ElevatedButton(
              onPressed: reiniciarJogo,
              child: const Text('Tentar novamente'),
            ),
            Text('Vitórias: $vitorias, Derrotas: $derrotas'),
          ],
        );
    }
  }
}
