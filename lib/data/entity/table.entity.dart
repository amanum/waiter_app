class TableEntity {
  final int id;
  final String title;

  const TableEntity({
    required this.id,
    required this.title,
  });

  TableEntity copyWith({
    int? id,
    String? title,
  }) {
    return TableEntity(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory TableEntity.fromJson(Map<String, dynamic> json) {
    return TableEntity(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TableEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title);

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  @override
  String toString() {
    return 'TableEntity{ id: $id, title: $title, }';
  }
}
