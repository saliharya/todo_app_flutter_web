class TodoRequest {
  final String title;
  final bool completed;

  TodoRequest({
    required this.title,
    required this.completed,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }
}
