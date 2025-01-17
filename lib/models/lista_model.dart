class ListaModel {
  String id;
  String title;
  bool isCompleted;

  ListaModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  // Converte para JSON para salvar em cache
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isCompleted': isCompleted,
  };

  // Converte de JSON para o modelo
  factory ListaModel.fromJson(Map<String, dynamic> json) {
    return ListaModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}
