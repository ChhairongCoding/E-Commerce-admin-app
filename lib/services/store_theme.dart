import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StoreTheme {
  final box = GetStorage();
  final key = "isDarkMode";

  void themCheck(RxBool data) {
    box.write(key, data.value);
  }

  bool loadTheme() {
    return box.read(key) ?? false;
  }
}
