import 'package:flutter/material.dart';
import 'page/transferencia.dart'; // Certifique-se de que o caminho está correto
import 'page/contatos.dart'; // Certifique-se de que o caminho está correto
import 'page/home.dart'; // Certifique-se de que o caminho está correto

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/transferencias': (context) => const ListaTransferencia(),
  '/contatos': (context) => const ContatosPage(),
};
