import 'package:get_storage/get_storage.dart';

class StorageService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  // Save the theme mode (true for dark, false for light)
  void saveThemeData(bool isDarkMode) {
    _box.write(_key, isDarkMode);
  }

  // Load the theme mode from storage
  bool loadThemeData() {
    return _box.read(_key) ?? false;
  }
}
