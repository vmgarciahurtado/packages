import 'dart:io';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:get/get.dart';

import 'i_unzip.dart';

class UnZipRepository extends IUnZip {
  @override
  Future unzipFile(String filePath, String fileName,
      {String directory = ''}) async {
    final zipFile = File('$filePath/$fileName');
    final destinationDir = Directory('$filePath/$directory');

    try {
      await ZipFile.extractToDirectory(
          zipFile: zipFile, destinationDir: destinationDir);
    } catch (e) {
      Get.printError(info: "error unzip $e");
    }
  }

  @override
  Future zipFile(
      {required String filePath,
      required String fileName,
      String directory = ''}) async {
    final dataDir = Directory('$filePath/$directory');
    try {
      final zipFile = File('$filePath/$fileName');

      if (zipFile.existsSync()) {
        zipFile.deleteSync(recursive: true);
      }

      await ZipFile.createFromDirectory(
          sourceDir: dataDir, zipFile: zipFile, recurseSubDirs: true);
    } catch (e) {
      Get.printError(info: "$e");
    }
  }
}
