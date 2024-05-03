import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trahmoo/core/route/app_routes.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trahmoo/core/style/app_colors.dart';
import 'package:trahmoo/core/widget/button.dart';
import 'package:trahmoo/feature/SignUp/controller/signup.dart';

import '../../../core/app_provider.dart';
import '../../product/controller/productDetails.dart';

class Cart extends StatefulWidget {


  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int activeIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var productController=Get.put(ProductDetailsController());


  String dropdownValueSize = 'm';
  String dropdownValueColor = 'red';
  var product=Get.arguments;


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        builder: (controller) =>
        (
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("Cart", style: TextStyle(color: Colors.black),),
                centerTitle: true,
                elevation: 0,
                actions: [
                  Icon(
                    Icons.share,
                    color: Colors.black,
                  )
                ],
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: Container(
                padding: EdgeInsets.all(16),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.99,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: AppColors.buttonColor)
                        ),
                        width:double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 2,child: Container(decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(width: 1,color: AppColors.buttonColor)
                                )
                            ),child: Image.network('${AppProvider.baseUrl}${product.images[0].image}'))),
                            Expanded(flex: 3,child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("name:${product.name }"),
                                  Text("price:${double.parse(product.price).round() }"),
                                  Text("description:${product.description }"),
                                ],
                              ),
                            )),
                            Expanded(child: Align(alignment: Alignment.topRight,child:Icon(Icons.more_vert,color: AppColors.buttonColor,) ,))
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),



                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width *0.3,
                        color: Color(0xffF2F2F2),
                        alignment: FractionalOffset.bottomCenter,
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            "Total",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "(excluding delivery)",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      flex: 4,
                                    ),
                                    Expanded(child: Text("${double.parse(product.price).round() }Ry"))
                                  ],
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Container(
                                child: Obx(
                                        () => controller.loading
                                        ? CircularProgressIndicator()
                                        :AppButton(
                                      formKey: formKey,
                                      text: "CHECKOUT",
                                      onpress: () async{
                                      var result=await productController.sendRequest(product.id);
                                      if (result == 200){
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.success,
                                          animType: AnimType.rightSlide,
                                          title: 'تم ارسال الطلب بنجاح',

                                          btnCancelOnPress: () {

                                          },
                                          btnOkOnPress: () {
                                            Get.toNamed(AppRoutes.home_page);
                                          },
                                        ).show();
                                      }else{
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.error,
                                          animType: AnimType.rightSlide,
                                          title: 'لم يتم ارسال الطلب ',
                                          desc: 'تاكد من الاتصال بالسيرفر',

                                          btnCancelOnPress: () {

                                          },
                                          btnOkOnPress: () {},
                                        ).show();
                                      }

                                        // controller.SignUp();
                                      },
                                    )

                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }






}
