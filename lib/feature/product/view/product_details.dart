

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trahmoo/core/route/app_routes.dart';
import 'package:trahmoo/core/style/app_colors.dart';
import 'package:trahmoo/core/widget/button.dart';
import 'package:trahmoo/feature/SignUp/controller/signup.dart';
import 'package:trahmoo/feature/product/controller/productDetails.dart';

import '../../../core/app_provider.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails() ;


  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  var productController=Get.put(ProductDetailsController());

  var product=Get.arguments;
  int activeIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final image = [
    "assets/image/teshert_y.jpg",
    "assets/image/teshert_g.png",
    "assets/image/teshert_p.jpg",
  ];
  String dropdownValueSize = 'm';
  String dropdownValueColor = 'red';


  @override
  Widget build(BuildContext context) {
// print(product[0]);
  print(product['arg1'].images);
//     var productDetails=json.decode(product[]);
  // print(json.encode(product));
    return GetBuilder<SignUpController>(
        builder: (controller) =>
        (
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("T-shirts", style: TextStyle(color: Colors.black),),
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
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.99,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CarouselSlider.builder(
                          itemCount: product['arg1'].images.length,
                          itemBuilder: (context, index, realindex) {
                            final urlImage = '${AppProvider.baseUrl}${product['arg1'].images[index].image}';
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),




                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      urlImage,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              height: 300,


                              onPageChanged: (index, reason) =>
                                  setState(() => activeIndex = index))),
                      SizedBox(
                        height: 12,
                      ),
                      buildIndicator(),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border:
                                Border.all(width: 1, color: AppColors
                                    .buttonColor)),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,
                            child: DropdownButton<String>(
                                hint: Text(dropdownValueSize),
                                isExpanded: true,
                                value: dropdownValueSize,
                                items: <String>['m', 'xl', 'l', 's']
                                    .map<DropdownMenuItem<String>>((
                                    String value) {
                                  return DropdownMenuItem<String>(
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValueSize = newValue!;
                                  });
                                }),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                Border.all(width: 1, color: AppColors
                                    .buttonColor)),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.5,
                            child: DropdownButton<String>(
                                hint: Text("Color"),
                                isExpanded: true,
                                value: dropdownValueColor,
                                items: <String>[
                                  'black',
                                  'red',
                                  'blue',
                                  'yellow',
                                  'green'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValueColor = newValue!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          product['arg1'].description??"",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
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
                                      child: Text(
                                        "MARCELO BURLON COUNTY OF MILAN",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      flex: 8,
                                    ),
                                    Expanded(child: Text("150\$"))
                                  ],
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Container(
                                        child: Obx(
                                         () => controller.loading
                                         ? CircularProgressIndicator()
                                          :AppButton(
                                              formKey: formKey,
                                              text: "ADD TO BAG",
                                              onpress: () {
                                                print("product[0]");
                                                // print(productDetails[1]);
                                                print("product[0]");
                                                productController.productIdToRequest.value=product['arg1'].id;

                                                // productController.sendRequest();
                                                Get.toNamed(AppRoutes.cart_page,arguments: product['arg1']);
                                              },
                                            )

                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: Colors.white,
                                        height: 40,
                                        child: Icon(Icons.favorite_border),
                                      ))
                                ],
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


  Widget buildIndicator() {
    return AnimatedSmoothIndicator(

        effect: ExpandingDotsEffect(
            dotWidth: 15, activeDotColor: AppColors.buttonColor),
        activeIndex: activeIndex,
        count: image.length);
  }

  Widget builImage(String urlImage, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Image.asset(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }

}
