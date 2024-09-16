import 'package:crypto_price_tracker/Features/crypto_prices/views/crypto_prices_view.dart';
import 'package:crypto_price_tracker/Services/firebase_messaging_service.dart';
import 'package:crypto_price_tracker/Theme/app_theme.dart';
import 'package:crypto_price_tracker/Theme/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put(FirebaseMessagingService().initialize());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeController.isDarkMode.value
          ? AppTheme.darkTheme
          : AppTheme.lightTheme,
      initialRoute: '/crypto_prices',
      getPages: [
        GetPage(
          name: '/crypto_prices',
          page: () => CryptoPricesView(),
        )
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
