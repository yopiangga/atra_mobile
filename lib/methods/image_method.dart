part of 'methods.dart';

Future<File> actionGetImage() async {
  dynamic img = await getImageGallery();
  if (img != null) {
    dynamic image = await cropImage(img);
    if (image != null) {
      return image;
    }
  }
  return null;
}

Future<File> getImageGallery() async {
  File imageFile;
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return null;

  imageFile = File(image.path);
  return imageFile;
}

Future<File> getImageCamera() async {
  File imageFile;
  var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
      preferredCameraDevice: CameraDevice.rear);
  if (image == null) return null;

  imageFile = File(image.path);
  return imageFile;
}

Future<File> cropImage(File imageFile) async {
  CroppedFile cropped = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 100,
  );

  File temp;

  if (cropped == null) {
    temp = imageFile;
  } else {
    temp = File(cropped.path);
  }

  return temp;
}

Future<List<dynamic>> textClassification(File image) async {
  String dataText = "";

  if (image == null) return null;

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  final RecognizedText recognizedText = await textRecognizer
      .processImage(imageLabelling.InputImage.fromFile(image));

  for (TextBlock block in recognizedText.blocks) {
    for (TextLine line in block.lines) {
      for (TextElement element in line.elements) {
        dataText += element.text + " ";
      }
      dataText += '\n';
    }
  }

  // return [dataText, File(image.path)];
  return [dataText];
}

Future<List<imageLabelling.ImageLabel>> imageClassification(img) async {
  if (img == null) return null;

  final imageLabeler = imageLabelling.ImageLabeler(
      options: imageLabelling.ImageLabelerOptions(confidenceThreshold: 0.5));
  List<imageLabelling.ImageLabel> labels =
      await imageLabeler.processImage(imageLabelling.InputImage.fromFile(img));

  for (imageLabelling.ImageLabel label in labels) {
    final String text = label.label;
    final int index = label.index;
    final double confidence = label.confidence;
  }

  return labels;
}
