class NoteModel {
  final int? id;
  final String title;
  final String description;
  final String date;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  static NoteModel fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["id"] as int,
        title: json["title"] as String,
        description: json["description"] as String,
        date: json["createdAt"],
      );
}
