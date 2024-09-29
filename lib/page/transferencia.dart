// page/transferencias.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert'; // Para converter para JSON
import '../theme.dart'; // Certifique-se de ter seu arquivo de tema

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controllerCampoValor = TextEditingController();

  FormularioTransferencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nova Transferência",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Editor(
            controlador: _controllerCampoNumeroConta,
            rotulo: 'Número da conta',
            dica: '0000',
          ),
          Editor(
            controlador: _controllerCampoValor,
            rotulo: 'Valor',
            dica: '0,00',
            icone: Icons.monetization_on,
          ),
          ElevatedButton(
            onPressed: () {
              _criarTransferencia(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Confirmar',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }

  void _criarTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controllerCampoNumeroConta.text);
    final double? valor =
        double.tryParse(_controllerCampoValor.text.replaceAll(',', '.'));

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(
          context, transferenciaCriada); // Retorna a transferência criada
    } else {
      // Exibe um aviso se os dados não forem válidos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados inválidos!')),
      );
    }
  }
}

class ListaTransferencia extends StatefulWidget {
  const ListaTransferencia({super.key});

  @override
  State<StatefulWidget> createState() => _ListaTransferenciaState();
}

class _ListaTransferenciaState extends State<ListaTransferencia> {
  final List<Transferencia> _transferencias = [];

  @override
  void initState() {
    super.initState();
    _carregarTransferencias();
  }

  Future<void> _carregarTransferencias() async {
    final prefs = await SharedPreferences.getInstance();
    final String? transferenciasString = prefs.getString('transferencias');

    if (transferenciasString != null) {
      final List<dynamic> listaDecodificada = jsonDecode(transferenciasString);
      setState(() {
        _transferencias.addAll(listaDecodificada
            .map((item) => Transferencia.fromJson(item))
            .toList());
      });
    }
  }

  Future<void> _salvarTransferencias() async {
    final prefs = await SharedPreferences.getInstance();
    final String transferenciasString = jsonEncode(_transferencias);
    prefs.setString('transferencias', transferenciasString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transferências",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, index) {
          final transferencia = _transferencias[index];
          return Dismissible(
            key: Key(transferencia.toString()),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              setState(() {
                _transferencias.removeAt(index);
              });
              _salvarTransferencias();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transferência excluída')),
              );
            },
            child: ItemTransferencia(transferencia),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navegarParaFormulario(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navegarParaFormulario(BuildContext context) async {
    final Transferencia? transferenciaRecebida = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return FormularioTransferencia();
      }),
    );

    if (transferenciaRecebida != null) {
      setState(() {
        _transferencias.add(transferenciaRecebida);
      });
      _salvarTransferencias(); // Salvar transferências quando uma nova é adicionada
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia, {super.key});

  @override
  Widget build(BuildContext context) {
    final formatador = NumberFormat.currency(
      locale: 'pt_BR', // Formatação para o Brasil
      symbol: 'R\$',
      decimalDigits: 2,
    );

    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on, color: Colors.green),
        title: Text(
            formatador.format(_transferencia.valor)), // Formatação do valor
        subtitle: Text(
            'Conta: ${_transferencia.numeroConta}'), // Alterado para incluir 'Conta:'
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  Map<String, dynamic> toJson() {
    return {
      'valor': valor,
      'numeroConta': numeroConta,
    };
  }

  factory Transferencia.fromJson(Map<String, dynamic> json) {
    return Transferencia(
      json['valor'],
      json['numeroConta'],
    );
  }

  @override
  String toString() {
    return 'Transferência{valor: $valor, numeroConta: $numeroConta}';
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  const Editor(
      {super.key, this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone, color: Colors.green) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
