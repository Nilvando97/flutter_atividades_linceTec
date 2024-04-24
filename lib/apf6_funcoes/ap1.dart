import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PessoasProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Pessoas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pessoas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaPessoasCadrastrada(),
                  ),
                );
              },
              child: Text('Ver Lista de Pessoas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdicionarPessoa(),
                  ),
                );
              },
              child: Text('Incluir Pessoa'),
            ),
          ],
        ),
      ),
    );
  }
}

class ListaPessoasCadrastrada extends StatelessWidget {
void _deletarPessoa(BuildContext context, Pessoa pessoa) {
  Provider.of<PessoasProvider>(context, listen: false).deletarPessoa(pessoa);
}


  @override
  Widget build(BuildContext context) {
    final pessoasProvider = Provider.of<PessoasProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pessoas'),
      ),
      body: ListView.builder(
        itemCount: pessoasProvider.pessoas.length,
        itemBuilder: (context, index) {
          final pessoa = pessoasProvider.pessoas[index];
          return ListTile(
            title: Text(pessoa.NomeCompleto),
            subtitle: Text(pessoa.email),
            
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  Text(pessoa.bloodType),
                  IconButton(icon: Icon(Icons.delete),
                  onPressed: () {
                    _deletarPessoa(context, pessoa);
                  },)
                ],
              ),
            ),
            tileColor: _getTileColor(pessoa.bloodType),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdicionarPessoa(pessoa: pessoa),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getTileColor(String bloodType) {
    switch (bloodType) {
      case 'A+':
        return Colors.blue;
      case 'A-':
        return Colors.red;
      case 'B+':
        return Colors.purple;
      case 'B-':
        return Colors.orange;
      case 'O+':
        return Colors.green;
      case 'O-':
        return Colors.yellow;
      case 'AB+':
        return Colors.cyan;
      case 'AB-':
        return Colors.white;
      default:
        return Colors.grey;
    }
  }
}

class AdicionarPessoa extends StatefulWidget {
  final Pessoa? pessoa;

  AdicionarPessoa({this.pessoa});

  @override
  _AddEditPersonPageState createState() => _AddEditPersonPageState();
}

class _AddEditPersonPageState extends State<AdicionarPessoa> {
  late TextEditingController _NomeCompletoControler;
  late TextEditingController _emailController;
  late TextEditingController _TelefoneControler;
  late TextEditingController _githubController;
  late String _bloodType;

  @override
  void initState() {
    super.initState();
    _NomeCompletoControler =
        TextEditingController(text: widget.pessoa?.NomeCompleto ?? '');
    _emailController = TextEditingController(text: widget.pessoa?.email ?? '');
    _TelefoneControler = TextEditingController(text: widget.pessoa?.Telefone ?? '');
    _githubController =
        TextEditingController(text: widget.pessoa?.github ?? '');
    _bloodType = widget.pessoa?.bloodType ?? 'A+';
  }

  @override
  void dispose() {
    _NomeCompletoControler.dispose();
    _emailController.dispose();
    _TelefoneControler.dispose();
    _githubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pessoa == null ? 'Incluir Pessoa' : 'Editar Pessoa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _NomeCompletoControler,
              decoration: InputDecoration(labelText: 'Nome Completo'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            TextField(
              controller: _TelefoneControler,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            TextField(
              controller: _githubController,
              decoration: InputDecoration(labelText: 'Link do GitHub'),
            ),
            DropdownButtonFormField<String>(
              value: _bloodType,
              onChanged: (value) {
                setState(() {
                  _bloodType = value!;
                });
              },
              items: [
                'A+',
                'A-',
                'B+',
                'B-',
                'O+',
                'O-',
                'AB+',
                'AB-',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Tipo Sanguíneo'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final novaPessoa = Pessoa(
                  NomeCompleto: _NomeCompletoControler.text,
                  email: _emailController.text,
                  Telefone: _TelefoneControler.text,
                  github: _githubController.text,
                  bloodType: _bloodType,
                );

                Provider.of<PessoasProvider>(context, listen: false)
                    .salvarPessoa(novaPessoa);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

class Pessoa {
  final String NomeCompleto;
  final String email;
  final String Telefone;
  final String github;
  final String bloodType;

  Pessoa({
    required this.NomeCompleto,
    required this.email,
    required this.Telefone,
    required this.github,
    required this.bloodType,
  });
}

class PessoasProvider extends ChangeNotifier {
  List<Pessoa> _pessoas = [];

  List<Pessoa> get pessoas => _pessoas;

  void addPessoa(Pessoa pessoa) {
    _pessoas.add(pessoa);
    notifyListeners();
  }

  void atualizarPessoa(Pessoa oldPerson, Pessoa novaPessoa) {
    final index = _pessoas.indexOf(oldPerson);
    _pessoas[index] = novaPessoa;
    notifyListeners();
  }

  void deletarPessoa(Pessoa pessoa) {
    _pessoas.remove(pessoa);
    notifyListeners();
  }

  void salvarPessoa(Pessoa pessoa) {
    final existirPessoaIndex =
        _pessoas.indexWhere((p) => p.NomeCompleto == pessoa.NomeCompleto);
    if (existirPessoaIndex != -1) {
      _pessoas[existirPessoaIndex] = pessoa;
    } else {
      _pessoas.add(pessoa);
    }
    notifyListeners();
  }
}
