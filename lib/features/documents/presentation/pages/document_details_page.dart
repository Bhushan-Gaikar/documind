import 'dart:io';

import 'package:flutter/material.dart';

import '../../../ai/data/mock_ai_repository.dart';
import '../../../ai/presentation/pages/classification_page.dart';
import '../../../ocr/data/ocr_service.dart';
import '../../domain/document.dart';

class DocumentDetailsPage extends StatelessWidget {
  final Document document;

  const DocumentDetailsPage({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final isPdf = document.type == DocumentType.pdf;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Document',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPreview(isPdf),
              const SizedBox(height: 24),
              _buildInformation(),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _runOcr(context),
                  icon: const Icon(Icons.text_snippet_outlined),
                  label: const Text('Extract Text'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreview(bool isPdf) {
    return Container(
      width: double.infinity,
      height: 360,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isPdf
          ? const Center(
        child: Icon(
          Icons.picture_as_pdf_rounded,
          size: 80,
        ),
      )
          : ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          File(document.path),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Document Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        _InfoRow(
          label: 'Name',
          value: document.name,
        ),
        _InfoRow(
          label: 'Type',
          value: document.type.name.toUpperCase(),
        ),
        _InfoRow(
          label: 'Created',
          value:
          '${document.createdAt.day}/${document.createdAt.month}/${document.createdAt.year}',
        ),
      ],
    );
  }
  Future<void> _runOcr(BuildContext context) async {
    if (document.type != DocumentType.image) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OCR currently works with images.'),
        ),
      );
      return;
    }

    final messenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    final ocrService = OcrService();

    try {
      final text = await ocrService.extractText(document.path);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop();

      await _classifyDocument(context, text);
    } catch (e) {
      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop();

      messenger.showSnackBar(
        SnackBar(
          content: Text('OCR failed: $e'),
        ),
      );
    } finally {
      await ocrService.dispose();
    }
  }

  Future<void> _classifyDocument(
      BuildContext context,
      String text,
      ) async {
    final repository = MockAiRepository();

    final classification =
    await repository.classifyDocument(text);

    if (!context.mounted) {
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ClassificationPage(
          classification: classification,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}