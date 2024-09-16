import 'package:get/get.dart';
import '../Services/storage_service.dart';
import 'app_theme.dart';

class ThemeController extends GetxController {
  final StorageService _storageService = StorageService();
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value =
        _storageService.loadThemeData(); // Load theme from storage
  }

  // Toggle between light and dark mode
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value; // Toggle the value
    if (isDarkMode.value) {
      Get.changeTheme(AppTheme.darkTheme);
    } else {
      Get.changeTheme(AppTheme.lightTheme);
    }
    _storageService
        .saveThemeData(isDarkMode.value); // Save the theme to storage
  }
}
