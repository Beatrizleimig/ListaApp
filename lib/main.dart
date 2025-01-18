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
          backgroundColor: Colors.blueAccent,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        '/lista_form': (context) => ListaFormView(onSave: () {

          print('Tarefa salva!');

        }),
      },
    );
  }
}
