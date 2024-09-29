import 'package:flutter/material.dart';
import 'page/transferencia.dart'; // Caminho para a página de transferências
import 'page/contatos.dart'; // Caminho para a página de contatos
import 'page/home.dart'; // Caminho para a página inicial
import 'routes.dart'; // Arquivo com as rotas definidas
import 'theme.dart'; // Tema

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme, // Tema personalizado, se houver
      initialRoute: '/', // Define a rota inicial como HomeScreen
      routes: appRoutes, // Mapeia as rotas a partir do arquivo routes.dart
    );
  }
}

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _selectedIndex = 0;

  // Lista de widgets que correspondem a cada item da BottomNavigationBar
  static const List<Widget> _pages = <Widget>[
    HomeScreen(), // Página inicial
    ListaTransferencia(), // Página de transferências
    ContatosPage(), // Página de contatos
  ];

  // Função para definir o índice da página atual
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicativo de Transferências'),
      ),
      body: _pages[
          _selectedIndex], // Mostra a página correspondente ao item selecionado
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Indica o item selecionado
        onTap: _onItemTapped, // Chama a função ao selecionar um item
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Transferências',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contatos',
          ),
        ],
      ),
    );
  }
}
