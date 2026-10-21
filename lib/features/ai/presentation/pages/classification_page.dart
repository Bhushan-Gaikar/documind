import 'package:flutter/material.dart';

import '../../domain/document_classification.dart';

class ClassificationPage extends StatelessWidget {
  final DocumentClassification classification;

  const ClassificationPage({
    super.key,
    required this.classification,
  });

  @override
  Widget build(BuildContext context) {
    final category = _categoryName(
      classification.category,
    );

    final confidence =
    (classification.confidence * 100).toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Classification',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Document Type',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Confidence',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: classification.confidence,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 8),
            Text(
              '$confidence%',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Why?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              classification.reason,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryName(DocumentCategory category) {
    switch (category) {
      case DocumentCategory.invoice:
        return 'Invoice';
      case DocumentCategory.receipt:
        return 'Receipt';
      case DocumentCategory.identity:
        return 'Identity Document';
      case DocumentCategory.agreement:
        return 'Agreement';
      case DocumentCategory.bankStatement:
        return 'Bank Statement';
      case DocumentCategory.other:
        return 'Other';
    }
  }
}