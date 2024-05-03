import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trahmoo/core/route/app_pages.dart';
import 'package:trahmoo/core/route/app_routes.dart';
void main() => runApp(HomeApp());
class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
       initialRoute:AppRoutes.home_page,
       getPages:AppPages.pages
    );
  }
}






