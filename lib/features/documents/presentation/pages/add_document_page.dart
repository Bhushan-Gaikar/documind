import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../scanner/presentation/pages/scanner_page.dart';
import '../providers/document_provider.dart';

class AddDocumentPage extends ConsumerWidget {
  const AddDocumentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Document',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How would you like to add it?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose a source to start processing your document.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),

              _DocumentSourceCard(
                icon: Icons.document_scanner_rounded,
                title: 'Scan Document',
                description: 'Use your camera to scan a document.',
                  onTap: () async {
                    final imagePath = await Navigator.of(context).push<String>(
                      MaterialPageRoute(
                        builder: (_) => const ScannerPage(),
                      ),
                    );

                    if (!context.mounted || imagePath == null) {
                      return;
                    }

                    // We'll connect this captured image to the Document model
                    // in the next step.
                  },
              ),

              const SizedBox(height: 16),

              _DocumentSourceCard(
                icon: Icons.photo_library_outlined,
                title: 'Upload Image',
                description: 'Select a document image from your device.',
                onTap: () async {
                  await ref
                      .read(documentProvider.notifier)
                      .pickDocument();

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),

              const SizedBox(height: 16),

              _DocumentSourceCard(
                icon: Icons.picture_as_pdf_outlined,
                title: 'Upload PDF',
                description: 'Select an existing PDF document.',
                onTap: () async {
                  await ref
                      .read(documentProvider.notifier)
                      .pickDocument();

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentSourceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _DocumentSourceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}