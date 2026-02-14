class Privacypolicymodel {
  final String id;
  final String key;
  final String audience;
  final String content;
  final bool isActive;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  Privacypolicymodel({
    required this.id,
    required this.key,
    required this.audience,
    required this.content,
    required this.isActive,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Privacypolicymodel.fromJson(Map<String, dynamic> json) {
    return Privacypolicymodel(
      id: json['_id'] ?? '',
      key: json['key'] ?? '',
      audience: json['audience'] ?? '',
      content: json['content'] ?? '',
      isActive: json['isActive'] ?? false,
      title: json['title'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "key": key,
      "audience": audience,
      "content": content,
      "isActive": isActive,
      "title": title,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
