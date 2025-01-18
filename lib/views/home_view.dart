import 'package:flutter/material.dart';
import 'package:lista_app/controllers/lista_controller.dart';
import 'package:lista_app/views/lista_form_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ListaController _controller = ListaController();
  Map<String, bool> _isIconRed = {};


  Future<void> _updateList() async {
    await _controller.loadListas();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
        future: _controller.loadListas(), // Aguarda o carregamento das listas
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Exibe um carregando
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar as tarefas.'));
          }


          final sortedListas = _controller.listas
            ..sort((a, b) => a.isCompleted ? 1 : -1);

          return ListView.builder(
            itemCount: sortedListas.length,
            itemBuilder: (context, index) {
              final lista = sortedListas[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 4,
                child: ListTile(
                  title: Text(
                    lista.title,
                    style: TextStyle(
                      decoration: lista.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  leading: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Checkbox(
                      key: ValueKey<bool>(lista.isCompleted),
                      value: lista.isCompleted,
                      onChanged: (value) {
                        setState(() {
                          _controller.toggleListaCompletion(lista.id);
                        });
                      },
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: _isIconRed[lista.id] == true ? Colors.red : Colors.black, // Vermelho se clicado
                    ),
                    onPressed: () {
                      setState(() {
                        _isIconRed[lista.id] = true; // Altera a cor para vermelho
                        Future.delayed(Duration(milliseconds: 500), () {
                          setState(() {
                            _controller.removeLista(lista.id);
                          });
                        });
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListaFormView(
                          lista: lista,
                          onSave: _updateList,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListaFormView(onSave: _updateList),
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
