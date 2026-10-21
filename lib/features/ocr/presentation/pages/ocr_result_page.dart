import 'package:flutter/material.dart';

class OcrResultPage extends StatelessWidget {
  final String text;

  const OcrResultPage({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Extracted Text',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: text.trim().isEmpty
              ? Center(
            child: Text(
              'No text detected in this document.',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          )
              : SingleChildScrollView(
            child: SelectableText(
              text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}