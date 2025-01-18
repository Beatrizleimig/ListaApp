class ListaModel {
  String id;
  String title;
  bool isCompleted;

  ListaModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });


  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isCompleted': isCompleted,
  };


  factory ListaModel.fromJson(Map<String, dynamic> json) {
    return ListaModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}
