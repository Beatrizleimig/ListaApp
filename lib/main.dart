import 'package:flutter/material.dart';
import 'package:lista_app/views/home_view.dart'; // Tela inicial
import 'package:lista_app/views/lista_form_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Lista',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent, // Cor de fundo do AppBar
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // Cor do título
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(), // Tela inicial
        '/lista_form': (context) => ListaFormView(onSave: () {
          // Passando a função 'onSave' como callback
          print('Tarefa salva!');
          // Aqui você pode definir a lógica para atualizar a lista de tarefas
        }),
      },
    );
  }
}
