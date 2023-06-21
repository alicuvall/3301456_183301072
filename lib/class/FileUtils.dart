import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  static Future<File> get dosyayiGetir async {
    final path = await getFilePath;
    return File('$path/logs.txt');
  }
  static Future<File> dosyayaKeydet(String data) async {
    final file = await dosyayiGetir;
    return file.writeAsString(data, mode: FileMode.append);
  }
  static Future<String> dosyadanOku() async {
    try {
      final file = await dosyayiGetir;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return "";
    }
  }
}