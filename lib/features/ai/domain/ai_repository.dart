import 'document_classification.dart';

abstract class AiRepository {
  Future<DocumentClassification> classifyDocument(String text);
}