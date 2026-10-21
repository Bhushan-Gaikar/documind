import 'package:flutter/material.dart';

import '../widgets/document_card.dart';
import 'add_document_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: _buildDocumentSection(),
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

  Widget _buildDocumentSection() {
    // Temporary sample document.
    // Later this will come from Riverpod + local database.
    return ListView(
      children: const [
        DocumentCard(
          title: 'Sample Invoice',
          documentType: 'Invoice',
          date: 'Today',
          icon: Icons.receipt_long_rounded,
        ),
        SizedBox(height: 12),
        DocumentCard(
          title: 'Identity Document',
          documentType: 'Identity',
          date: 'Yesterday',
          icon: Icons.badge_outlined,
        ),
      ],
    );
  }
}