import 'package:digishop/controller/Binding/app_binding.dart';
import 'package:digishop/services/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  AppBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.splash,
      getPages:AppRoutes.listGetPage,
      theme: ThemeData(
        fontFamily: 'lalezar'
      ),
      title: 'Digital Shoping',
      locale: const Locale('fa','IR'),
    );
  }
}



