import '../domain/ai_repository.dart';
import '../domain/document_classification.dart';

class MockAiRepository implements AiRepository {
  @override
  Future<DocumentClassification> classifyDocument(String text) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    final lowerText = text.toLowerCase();

    if (lowerText.contains('invoice') ||
        lowerText.contains('invoice number')) {
      return const DocumentClassification(
        category: DocumentCategory.invoice,
        confidence: 0.92,
        reason: 'The document contains invoice-related information.',
      );
    }

    if (lowerText.contains('receipt') ||
        lowerText.contains('total amount')) {
      return const DocumentClassification(
        category: DocumentCategory.receipt,
        confidence: 0.87,
        reason: 'The document contains receipt-related information.',
      );
    }

    if (lowerText.contains('account number') ||
        lowerText.contains('bank statement')) {
      return const DocumentClassification(
        category: DocumentCategory.bankStatement,
        confidence: 0.89,
        reason: 'The document appears to contain banking information.',
      );
    }

    return const DocumentClassification(
      category: DocumentCategory.other,
      confidence: 0.50,
      reason: 'The document could not be confidently classified.',
    );
  }
}