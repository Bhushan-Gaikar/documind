import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/document_repository.dart';
import '../../domain/document.dart';

final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  return DocumentRepository();
});

final documentProvider =
NotifierProvider<DocumentNotifier, List<Document>>(
  DocumentNotifier.new,
);

class DocumentNotifier extends Notifier<List<Document>> {
  late final DocumentRepository _repository;

  @override
  List<Document> build() {
    _repository = ref.read(documentRepositoryProvider);
    return [];
  }

  Future<void> pickDocument() async {
    final document = await _repository.pickDocument();

    if (document == null) {
      return;
    }

    state = [
      ...state,
      document,
    ];
  }

  Future<void> addScannedDocument(String imagePath) async {
    final document = await _repository.createDocumentFromImage(imagePath);

    if (document == null) {
      return;
    }

    state = [
      ...state,
      document,
    ];
  }

}