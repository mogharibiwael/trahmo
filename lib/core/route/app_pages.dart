


import 'package:trahmoo/feature/Home/view/category.dart';
import 'package:trahmoo/feature/login/view/login.dart';
import 'package:get/get.dart';
import 'package:trahmoo/core/route/app_binding.dart';
import 'package:trahmoo/core/route/app_routes.dart';
import 'package:trahmoo/feature/Home/view/home_page.dart';
import 'package:trahmoo/feature/SignUp/view/sign_up.dart';
import 'package:trahmoo/feature/cart/view/cart.dart';

import '../../feature/Home/view/details.dart';
import '../../feature/Home/view/payment.dart';
import '../../feature/Home/view/upload_state.dart';
import '../../feature/product/view/product_details.dart';

abstract class AppPages {

  static final pages = [
    // GetPage(
    //   name: AppRoutes.signUp_page,
    //   page: () =>  SignUP(),
    //   bindings: [SignUpBinding()],
    //
    // ),
    // GetPage(
    //   name: AppRoutes.login,
    //   page: () =>  Login(),
    //   bindings: [SignUpBinding()],
    //
    // ),
    // GetPage(
    //   name: AppRoutes.ProductDetails_page,
    //   page: () =>  ProductDetails(),
    //   bindings: [ProductBinding()],
    //
    // ),
    GetPage(
      name: AppRoutes.cart_page,
      page: () =>  Cart(),
      bindings: [],

    ),
    GetPage(
      name: AppRoutes.home_page,
      page: () =>  HomePage(),
      bindings: [InitialBinding()],

    ),
    GetPage(
      name: AppRoutes.detailsPage,
      page: () =>  Details(),
      bindings: [InitialBinding()],

    ),
    GetPage(
      name: AppRoutes.payment,
      page: () =>  Payment(),
      bindings: [InitialBinding()],

    ),
  GetPage(
      name: AppRoutes.category,
      page: () =>  Category(),
      bindings: [InitialBinding()],

    ),
    GetPage(
      name: AppRoutes.uploadState,
      page: () =>  UploadState(),
      bindings: [InitialBinding()],

    ),

    ];
}