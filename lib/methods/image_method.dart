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

  final textDetector = ml.GoogleMlKit.vision.textDetector();

  ml.InputImage inputImage = ml.InputImage.fromFilePath(image.path);

  final ml.RecognisedText recognisedText =
      await textDetector.processImage(inputImage);

  String text = recognisedText.text;
  for (ml.TextBlock block in recognisedText.blocks) {
    final Rect rect = block.rect;
    final List<Offset> cornerPoints = block.cornerPoints;
    final String text = block.text;
    final List<String> languages = block.recognizedLanguages;

    for (ml.TextLine line in block.lines) {
      // Same getters as TextBlock
      for (ml.TextElement element in line.elements) {
        // Same getters as TextBlock
        dataText += element.text + " ";
      }
      dataText += '\n';
    }
  }

  // return [dataText, File(image.path)];
  return [dataText];
}
