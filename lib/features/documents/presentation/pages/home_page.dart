import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/document.dart';
import '../providers/document_provider.dart';
import '../widgets/document_card.dart';
import 'add_document_page.dart';
import 'document_details_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DocuMind',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),

              const SizedBox(height: 24),

              Expanded(
                child: _buildDocumentSection(ref),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddDocumentPage(),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Document'),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Documents',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade900,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Scan, understand and manage your documents.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentSection(WidgetRef ref) {
    final documents = ref.watch(documentProvider);

    if (documents.isEmpty) {
      return Center(
        child: Text(
          'No documents yet',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 15,
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: documents.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final document = documents[index];

        return DocumentCard(
          title: document.name,
          documentType: document.type.name.toUpperCase(),
          date: _formatDate(document.createdAt),
          icon: document.type == DocumentType.pdf
              ? Icons.picture_as_pdf_outlined
              : Icons.image_outlined,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DocumentDetailsPage(
                  document: document,
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}