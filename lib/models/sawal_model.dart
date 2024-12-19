class SawalModel {
  final String id;
  final String content;
  final String category;
  final String date;

  SawalModel({
    required this.id,
    required this.content,
    required this.category,
    required this.date,
  });

  factory SawalModel.fromJson(Map<String, dynamic> json) {
    return SawalModel(
      id: json['id'],
      content: json['content'],
      category: json['category'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'category': category,
      'date': date,
    };
  }
}
