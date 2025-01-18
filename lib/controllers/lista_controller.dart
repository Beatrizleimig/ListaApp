import 'package:shared_preferences/shared_preferences.dart';
import '../models/lista_model.dart';
import 'dart:convert';

class ListaController {
  List<ListaModel> listas = [];
  final String _key = 'listas';

  ListaController() {
    _loadListas();
  }

  Future<void> loadListas() async {
    await _loadListas();
  }

  Future<void> _loadListas() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data != null) {
      final List<dynamic> jsonData = json.decode(data);
      listas = jsonData.map((json) => ListaModel.fromJson(json)).toList();
    }
  }

  // Adiciona uma nova tarefa
  Future<void> addLista(ListaModel lista) async {
    listas.add(lista);
    await _saveListas(); // Salva as listas
  }

  // Atualiza uma tarefa existente
  Future<void> updateLista(ListaModel updatedLista) async {
    final index = listas.indexWhere((lista) => lista.id == updatedLista.id);
    if (index != -1) {
      listas[index] = updatedLista;
      await _saveListas();
    }
  }

  // Remove uma tarefa
  Future<void> removeLista(String id) async {
    listas.removeWhere((lista) => lista.id == id);
    await _saveListas();
  }

  // Marca a tarefa como completada ou não
  Future<void> toggleListaCompletion(String id) async {
    final lista = listas.firstWhere((lista) => lista.id == id);

    // Atualiza
    lista.isCompleted = !lista.isCompleted;

    await _saveListas();
  }



  // Salva as listas no SharedPreferences
  Future<void> _saveListas() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(listas.map((lista) => lista.toJson()).toList());
    await prefs.setString(_key, jsonData);
  }
}
