class ItemModel {
  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;

  ItemModel({
    this.id,
    required this.title,
    required this.description,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  ItemModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
  }) {
    return ItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(id, title, description, createdAt);

  @override
  String toString() {
    return 'ItemModel{id: $id, title: $title, description: $description, createdAt: $createdAt}';
  }
}
