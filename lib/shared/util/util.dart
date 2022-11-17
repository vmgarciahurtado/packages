import 'dart:io';
import 'dart:math';
import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:geolocator/geolocator.dart';

class Util {
  static final device = _Device._();
  static final data = _Data._();
}

class _Data {
  _Data._();

  double getDouble(String number) {
    try {
      return double.parse(number);
    } catch (e) {
      Get.printError(info: "$e");
      return 0.0;
    }
  }

  int getInt(String number) {
    try {
      return int.parse(number);
    } catch (e) {
      Get.printError(info: "$e");
      return 0;
    }
  }

  bool getBool(String string) {
    try {
      if (string == 'true') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Get.printError(info: "$e");
      return false;
    }
  }

  String getFieldDynamicValue(dynamic origen, String campo) {
    String value = "";
    value = origen.dynamicValue!.entries
        .where((element) => element.key == campo)
        .first
        .value;
    return value;
  }

  String completeFormatOrder(String orderValue) {
    String value = "";

    if (orderValue.length == 1) {
      value = '00$orderValue';
    } else if (orderValue.length == 2) {
      value = '0$orderValue';
    } else {
      value = orderValue;
    }

    return value;
  }
}

class _Device {
  _Device._();

  Future getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  Future<String> calculateTimeDifferenceBetween(
      DateTime startDate, DateTime endDate) async {
    return '${startDate.difference(endDate).inMinutes.abs()}';
  }

  Future<bool> getInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  String getCurrentDate() {
    var now = DateTime.now();
    String formatter = DateFormat('yyyy-MM-dd').format(now);
    return formatter;
  }

  String getCurrentDateWhitFormat(String format) {
    var now = DateTime.now();
    String formatter = DateFormat(format).format(now);
    return formatter;
  }

  String getCurrentDateTime() {
    var now = DateTime.now();
    String formatter = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    return formatter;
  }

  int getCurrentYear() {
    var now = DateTime.now();
    int currentYear = now.year;
    return currentYear;
  }

  int getCurrentMonth() {
    var now = DateTime.now();
    int currentMonth = now.month;
    return currentMonth;
  }

  int getCurrentWeek() {
    String date = DateTime.now().toString();
    String firstDay = date.substring(0, 8) + '01' + date.substring(10);
    int weekDay = DateTime.parse(firstDay).weekday;
    DateTime testDate = DateTime.now();
    int weekOfMonth;

    weekDay--;
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    weekDay++;

    if (weekDay == 7) {
      weekDay = 0;
    }
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    return weekOfMonth;
  }

  int getCurrentWeekDay() {
    var now = DateTime.now();
    int currentWeekDay = now.weekday;
    return currentWeekDay;
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position = Position(
        longitude: 0.0,
        latitude: 0.0,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0);

    if (!await getInternet()) {
      return position;
    }

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return position;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return position;
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getAppDirectory() async {
    var documentDirectory = await getApplicationDocumentsDirectory();

    String directory = documentDirectory.path;

    return directory;
  }

  Future<String> saveImageInLocalPath(Uri url, String name) async {
    var response = await get(url);
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/images";
    var filePathAndName = documentDirectory.path + '/images/' + name;

    await Directory(firstPath).create(recursive: true);
    File file = File(filePathAndName);
    file.writeAsBytesSync(response.bodyBytes);

    return filePathAndName;
  }
}
