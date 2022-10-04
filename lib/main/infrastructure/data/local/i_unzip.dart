abstract class IUnZip {
  Future unzipFile(String filePath, String fileName, {String directory = ''});
  Future zipFile(
      {required String filePath,
      required String fileName,
      String directory = ''});
}
