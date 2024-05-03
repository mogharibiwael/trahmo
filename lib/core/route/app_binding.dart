import 'package:get/get.dart';
import 'package:trahmoo/feature/SignUp/controller/signup.dart';
import '../../feature/Home/controller/controller.dart';
import '../../feature/login/controller/login.dart';
import '../../feature/product/controller/productDetails.dart';


class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController(),permanent: true);

  }
}
class CatgeoryBinding extends Bindings{
  @override
  void dependencies() {

   HomeController data= Get.put(HomeController(),permanent: true);
    data.getTabraaByCategory();

  }
}
// class SignUpBinding extends Bindings{
//   @override
//   void dependencies() {
//
//     Get.put(SignUpController(),permanent: true);
//     Get.put(SignInController(),permanent: true);
//
//
//   }
// }
//
// class ProductBinding extends Bindings{
//   @override
//   void dependencies() {
//
//     Get.put(ProductDetailsController(),permanent: true);
//
//
//   }
// }
// class HomePageBinding extends Bindings{
//   @override
//   void dependencies() {
//
//     Get.put(ProductDetailsController(),permanent: true);
//
//
//   }
// }