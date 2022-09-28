part of 'services.dart';

class DownloadServices {
  static Future<void> downloadUrl(String url, String text) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    if (statuses[Permission.storage]?.isGranted) {
      var dir = await DownloadsPathProvider.downloadsDirectory;
      if (dir != null) {
        String savename = text + ".webm";
        String savePath = dir.path + "/$savename";
        //output:  /storage/emulated/0/Download/banner.png

        try {
          await Dio().download(url, savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {
              print((received / total * 100).toStringAsFixed(0) + "%");
              //you can build progressbar feature too
            }
          });
          print("File is saved to download folder.");
        } on DioError catch (e) {
          print(e.message);
        }
      }
    } else {
      print("No permission to read and write.");
    }
  }
}
