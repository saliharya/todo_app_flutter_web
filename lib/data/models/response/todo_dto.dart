class TodoDto {
  final String id;
  final String title;
  final bool completed;

  TodoDto({
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodoDto.fromJson(Map<String, dynamic> json) {
    return TodoDto(
      id: json['id'].toString(),
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
