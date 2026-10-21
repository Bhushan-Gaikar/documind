enum DocumentType {
  image,
  pdf,
}

class Document {
  final String id;
  final String name;
  final String path;
  final DocumentType type;
  final DateTime createdAt;

  const Document({
    required this.id,
    required this.name,
    required this.path,
    required this.type,
    required this.createdAt,
  });
}