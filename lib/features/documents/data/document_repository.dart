import 'package:file_picker/file_picker.dart';

import '../domain/document.dart';

class DocumentRepository {
  Future<Document?> pickDocument() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (files.isEmpty) {
      return null;
    }

    final file = files.first;

    if (file.path == null || file.path!.isEmpty) {
      return null;
    }

    final extension = file.extension?.toLowerCase();

    return Document(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: file.name,
      path: file.path!,
      type: extension == 'pdf'
          ? DocumentType.pdf
          : DocumentType.image,
      createdAt: DateTime.now(),
    );
  }
}