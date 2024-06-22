class ToDoItem {
  final String title;
  final String description;
  final STATE state;

  ToDoItem({required this.title, required this.description, required this.state});
}

enum STATE {
  notStarted,
  inProgress,
  onHold,
  done,
}