// routes.dart
import 'package:flutter/material.dart';
import 'page/transferencia.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/transferencias': (context) => const ListaTransferencia(),
  '/contatos': (context) => const ContactScreen(),
};

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const Center(
        child: Text('Bem-vindo à Home'),
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
      ),
      body: const Center(
        child: Text('Tela de Contatos'),
      ),
    );
  }
}
