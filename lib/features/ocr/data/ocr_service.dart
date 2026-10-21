import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrService {
  final TextRecognizer _textRecognizer =
  TextRecognizer(script: TextRecognitionScript.latin);

  Future<String> extractText(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);

    final recognizedText =
    await _textRecognizer.processImage(inputImage);

    return recognizedText.text;
  }

  Future<void> dispose() async {
    try {
      await _textRecognizer.close();
    } catch (e) {
      // Prevent plugin cleanup failure from crashing the app.
    }
  }
}