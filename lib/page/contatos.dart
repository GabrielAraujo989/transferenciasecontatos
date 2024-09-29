// contatos.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Contato {
  final String nome;
  final String cpf;
  final String telefone;
  final String numeroConta;

  Contato(this.nome, this.cpf, this.telefone, this.numeroConta);

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      'numeroConta': numeroConta,
    };
  }

  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      json['nome'],
      json['cpf'],
      json['telefone'],
      json['numeroConta'],
    );
  }

  @override
  String toString() {
    return 'Contato{nome: $nome, cpf: $cpf, telefone: $telefone, numeroConta: $numeroConta}';
  }
}

class ContatosPage extends StatefulWidget {
  const ContatosPage({super.key});

  @override
  _ContatosPageState createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {
  List<Contato> _contatos = [];

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  Future<void> _carregarContatos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? contatosString = prefs.getString('contatos');

    if (contatosString != null) {
      final List<dynamic> listaDecodificada = jsonDecode(contatosString);
      setState(() {
        _contatos =
            listaDecodificada.map((item) => Contato.fromJson(item)).toList();
      });
    }
  }

  Future<void> _salvarContatos() async {
    final prefs = await SharedPreferences.getInstance();
    final String contatosString = jsonEncode(_contatos);
    prefs.setString('contatos', contatosString);
  }

  void _adicionarContato() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _controllerNome = TextEditingController();
        final TextEditingController _controllerCpf = TextEditingController();
        final TextEditingController _controllerTelefone =
            TextEditingController();
        final TextEditingController _controllerNumeroConta =
            TextEditingController();

        return AlertDialog(
          title: const Text('Adicionar Contato'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controllerNome,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _controllerCpf,
                decoration: const InputDecoration(labelText: 'CPF'),
              ),
              TextField(
                controller: _controllerTelefone,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              TextField(
                controller: _controllerNumeroConta,
                decoration: const InputDecoration(labelText: 'Número da Conta'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final contato = Contato(
                  _controllerNome.text,
                  _controllerCpf.text,
                  _controllerTelefone.text,
                  _controllerNumeroConta.text,
                );

                setState(() {
                  _contatos.add(contato);
                });
                _salvarContatos();
                Navigator.of(context).pop();
              },
              child: const Text('Adicionar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: ListView.builder(
        itemCount: _contatos.length,
        itemBuilder: (context, index) {
          final contato = _contatos[index];
          return Card(
            child: ListTile(
              title: Text(contato.nome),
              subtitle: Text(
                  'CPF: ${contato.cpf}\nTelefone: ${contato.telefone}\nConta: ${contato.numeroConta}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarContato,
        child: const Icon(Icons.add),
      ),
    );
  }
}
