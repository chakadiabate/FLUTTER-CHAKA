class Ticket {
  final String assignee;
  final String title;
  final String category;
  final String description;
  final String status;

  Ticket({
    required this.assignee,
    required this.title,
    required this.category,
    required this.description,
    this.status = 'En attente',
  });
}
