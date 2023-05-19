class Todos {
  final String? id;
  final String? title;

  Todos({this.id, this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': title,
    };
  }

  factory Todos.fromMap(Map<String, dynamic> map) {
    return Todos(
      id: map['id'],
      title: map['todo'],
    );
  }
}
