enum DocumentCategory {
  invoice,
  receipt,
  identity,
  agreement,
  bankStatement,
  other,
}

class DocumentClassification {
  final DocumentCategory category;
  final double confidence;
  final String reason;

  const DocumentClassification({
    required this.category,
    required this.confidence,
    required this.reason,
  });
}