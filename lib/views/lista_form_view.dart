import 'package:flutter/material.dart';
import 'package:lista_app/controllers/lista_controller.dart';
import '../models/lista_model.dart';

class ListaFormView extends StatelessWidget {
  final ListaModel? lista;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final ListaController _controller = ListaController();
  final Function onSave;

  ListaFormView({this.lista, required this.onSave}) {
    if (lista != null) {
      _titleController.text = lista!.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lista == null ? 'Nova Tarefa' : 'Editar Tarefa'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título da Tarefa',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Por favor, insira um título válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (lista == null) {
                      _controller.addLista(ListaModel(
                        id: DateTime.now().toString(),
                        title: _titleController.text,
                      ));
                    } else {
                      _controller.updateLista(
                        ListaModel(
                          id: lista!.id,
                          title: _titleController.text,
                          isCompleted: lista!.isCompleted,
                        ),
                      );
                    }

                    final snackBar = SnackBar(content: Text('Tarefa salva com sucesso!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.pop(context);
                    onSave(); // Atualiza a lista ao salvar
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('Salvar', style: TextStyle(fontSize: 18 , color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
