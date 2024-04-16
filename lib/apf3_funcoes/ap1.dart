import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulário ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Formulario(),
    );
  }
}

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  int _idade = 0;
  bool _inativo = false;

  void _salvarFormulario() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _inativo = _inativo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome é obrigatório';
                  } else if (value.length < 3) {
                    return 'O nome precisa ter pelo menos 3 letras';
                  } else if (!value
                      .substring(0, 1)
                      .toUpperCase()
                      .contains(RegExp(r'[A-Z]'))) {
                    return 'O nome precisa começar com letra maiúscula';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Idade',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A idade é obrigatória';
                  } else if (int.tryParse(value) == null) {
                    return 'A idade precisa ser um número válido';
                  } else if (int.parse(value) < 18) {
                    return 'A idade precisa ser maior ou igual a 18';
                  }
                  return null;
                },
                onSaved: (value) {
                  _idade = int.parse(value!);
                },
              ),
              Row(
                children: [
                  const Text('Inativo: '),
                  Checkbox(
                    value: _inativo,
                    onChanged: (value) {
                      setState(() {
                        _inativo = value!;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _salvarFormulario,
                child: const Text('Salvar'),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                color: _inativo ? Colors.grey : Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nome: $_nome'),
                    Text('Idade: $_idade'),
                    Text('Inativo: $_inativo'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
