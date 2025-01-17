import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lista_model.dart';


class LocalStorageService {
  final String _key = 'tasks';

  Future<List<ListaModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data != null) {
      final List<dynamic> jsonData = json.decode(data);
      return jsonData.map((json) => ListaModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> saveListas(List<ListaModel> listas) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(listas.map((lista) => lista.toJson()).toList());
    prefs.setString(_key, jsonData);
  }
}
