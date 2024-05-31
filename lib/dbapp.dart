import 'package:hive_flutter/adapters.dart';

class Hivehelper {
  static late Box<String> imageBox;

  static Future<void> openImageBox() async {
    await Hive.initFlutter();
    imageBox = await Hive.openBox<String>('images');
  }

  static Future<void> imageSave(String imagePath) async {
    imageBox.add(imagePath);
  }

  static List<String> imagePathsStream() {
    return imageBox.values.toList();
  }

  static void deleteImage(int index) {
    imageBox.deleteAt(index);
  }
}
