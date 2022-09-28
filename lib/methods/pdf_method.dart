part of 'methods.dart';

Future<File> getFilePDF() async {
  FilePickerResult result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path);
    return file;
  } else {
    // User canceled the picker
    return null;
  }
}

  // Future<PdfPageImage> _renderPage(PdfDocument document, int pageNumber) async {
  //   final page = await document.getPage(pageNumber);
  //   final pageImage = await page.render(
  //     width: page.width * 2,
  //     height: page.height * 2,
  //     format: PdfPageFormat.PNG,
  //   );
  //   await page.close();
  //   return pageImage;
  // }
