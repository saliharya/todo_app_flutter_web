class TodoResponse {
  final String id;
  final String title;
  final bool completed;

  TodoResponse({
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodoResponse.fromJson(Map<String, dynamic> json) {
    return TodoResponse(
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
