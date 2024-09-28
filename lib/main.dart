import 'package:flutter/material.dart';
import 'page/transferencia.dart';
import 'routes.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  // Lista de widgets que correspondem a cada item da BottomNavigationBar
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    ListaTransferencia(),
    ContactScreen(),
  ];

  // Função para definir o índice da página atual
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aplicativo de Transferências'),
        ),
        body: _pages[_selectedIndex], // Mostra a página correspondente
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on), label: 'Transferências'),
            BottomNavigationBarItem(
                icon: Icon(Icons.contacts), label: 'Contatos'),
          ],
          currentIndex: _selectedIndex, // Indica o item selecionado
          onTap: _onItemTapped, // Chama a função ao selecionar um item
        ),
      ),
    );
  }
}
