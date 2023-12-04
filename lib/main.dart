import 'package:chat_ai/controllers/theme_controller.dart';
import 'package:chat_ai/res/themes/theme.dart';
import 'package:chat_ai/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Chat Aizen',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: Get.find<ThemeController>().isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        home: const Splash(),
      );
    });
  }
}
