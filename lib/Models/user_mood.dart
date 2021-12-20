class UserMood {
  final int? id;
  final String mood_name;
  final String? note;
  final String mood_image;
  final String date;

  UserMood(
      {this.id,
      required this.mood_name,
      required this.mood_image,
      required this.date,
      this.note});

  UserMood.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        mood_image = res["mood_image"],
        mood_name = res["mood_name"],
        note = res["note"],
        date = res["date"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'mood_name': mood_name,
      'mood_image': mood_image,
      'note': note,
      'date': date
    };
  }
}
