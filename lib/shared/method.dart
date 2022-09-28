part of 'shared.dart';

// String baseUrl = "http://172.16.102.56:3000";
String baseUrl = "https://macasantara-server.vercel.app";
String shareUID = "";
int timestamp = DateTime.now().millisecondsSinceEpoch;

String recentTime(String timeString) {
  int time = int.parse(timeString);
  if (time >= timestamp - 60 * 60 * 24 * 1000) {
    return "Beberapa jam yang lalu";
  } else if (time >= timestamp - 60 * 60 * 24 * 1000 * 7) {
    return "Beberapa hari yang lalu";
  } else if (time >= timestamp - 60 * 60 * 24 * 1000 * 30) {
    return "Beberapa minggu yang lalu";
  } else {
    return "Beberapa waktu yang lalu";
  }
}
