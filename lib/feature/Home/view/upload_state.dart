import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trahmoo/core/route/app_routes.dart';
import 'package:trahmoo/core/style/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trahmoo/core/widget/button.dart';
import 'package:trahmoo/core/widget/text_field.dart';
import 'package:trahmoo/feature/product/controller/productDetails.dart';
import '../controller/controller.dart';

class UploadState extends GetView<ProductDetailsController> {



  UploadState({Key? key}) : super(key: key);
  GlobalKey<FormState> globalKey=GlobalKey<FormState>();
  TextEditingController kuremy=TextEditingController();



  @override
  Widget build(BuildContext context) {
    HomeController homeController =
    Get.find<HomeController>();

    RefreshController _refreshController =
    RefreshController(initialRefresh: false);
    ImagePicker _imagePicker = ImagePicker();

    Future<void> selectImage() async {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

      homeController.setImageFile(File(pickedFile!.path));

    }


    void _onRefresh() async{
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use refreshFailed()
      homeController.fetchState();
      _refreshController.refreshCompleted();
    }
    void _onLoading() async{
      await Future.delayed(Duration(milliseconds: 1000));
      homeController.fetchState();
      _refreshController.loadComplete();
    }




    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: ( context, mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Form(
          key: globalKey,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child:   Container(
              margin: EdgeInsets.only(top: 10),
              child: ListView(
                children: [

                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))

                          ),
                          child: const Text(
                            "رفع حالة",
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
                          ))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes the shadow position
                          ),
                        ],
                      ),
                      child: Column(children: [

                        Container(
                          height: MediaQuery.of(context).size.height * 0.03,
                          margin: EdgeInsets.all(10),

                          width: double.infinity,
                          child: const Text(
                            "بيانات الحالة",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Tajawal'),
                          ),
                        ),
                        Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 10,left: 10,top: 20,bottom: 5)

                        ,child: Text("الاسم",style: TextStyle(fontSize: 16),)),
                        GeneralTextFeild(hasValidate: true, controller: homeController.name, hintText: "ادخل اسم للحالة", textInputType: TextInputType.text),
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 10,left: 10,top: 20,bottom: 5)

                            ,child: Text("المبلغ",style: TextStyle(fontSize: 16),)),
                        GeneralTextFeild(hasValidate: true, controller: homeController.amountStateController, hintText: "ادخل المبلغ المستحق للدفع", textInputType: TextInputType.text),
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 10,left: 10,top: 20,bottom: 5)

                            ,child: Text("الوصف",style: TextStyle(fontSize: 16),)),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextField(
                            controller: homeController.description,
                            maxLines: 6, // Allow multiple lines
                            decoration: InputDecoration(
                              hintText: 'Enter description',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 10,left: 10,top: 20,bottom: 5)

                            ,child: Text("العنوان",style: TextStyle(fontSize: 16),)),
                        GeneralTextFeild(hasValidate: true, controller: homeController.addressController, hintText: "ادخل عنوان للحالة", textInputType: TextInputType.text),
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 10,left: 10,top: 20,bottom: 5)

                            ,child: Text("المستفيد",style: TextStyle(fontSize: 16),)),
                        GeneralTextFeild(hasValidate: true, controller: homeController.beneficiaryName, hintText: "ادخل اسم المستفيد", textInputType: TextInputType.text),
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 10,left: 10,top: 20,bottom: 5)

                            ,child: Text("عنوان المستفيد ",style: TextStyle(fontSize: 16),)),
                        GeneralTextFeild(hasValidate: true, controller: homeController.beneficiaryAddress, hintText: "ادخل عنوان المستفيد", textInputType: TextInputType.text),
                        Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 10,left: 10,top: 20,bottom: 5)
                            ,child: Text(" رقم تلفون المستفيد",style: TextStyle(fontSize: 16),)),
                        GeneralTextFeild(hasValidate: true, controller: homeController.beneficiaryPhone, hintText: "ادخل رقم تلفون المستفيد او احد اقربائة", textInputType: TextInputType.text),
                        Container(
                            margin: EdgeInsets.only(top: 10,bottom: 5),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 10,left: 10,top: 20,bottom: 5)
                            ,child: Text("اختر المجموعة التي يجب ان تظهر فيها الحالة",style: TextStyle(fontSize: 16),)),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(

                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: InputBorder.none, // Remove the bottom line
                               // Choose your desired color
                            ),
                            value: homeController.selectedItem,
                            onChanged: (newValue) {

                              homeController.selectedItem = newValue;
                              print(homeController.selectedItem);
                              print('---------');

                            },
                          items:  homeController.categoryState.value.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value.name,
                                child: Text(value.name!),
                              );
                            }).toList(),
                            hint: Text('اختر المجموعة'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,bottom: 5),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 10,left: 10,top: 20,bottom: 5)
                            ,child: Text("صورة بطاقة شخصية للمستفيد او ولي الامر",style: TextStyle(fontSize: 16),)),
                    InkWell(
                      onTap: (){
                        print('yes');
                        selectImage();
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                               () {
                                return CircleAvatar(
                                  radius: 80.0,
                                  backgroundColor: AppColors.buttonColor,
                                  backgroundImage: homeController.imageFile.value != null
                                      ? FileImage(homeController.imageFile.value!)
                                      : null,
                                  child: homeController.imageFile.value == null
                                      ? Icon(Icons.add_a_photo, size: 50.0)
                                      : null,
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                          padding: const EdgeInsets.only(right: 18.0,left:18,top: 10,bottom: 30 ),
                          child: AppButton(formKey: globalKey,text: "تبرع",onpress: ()async {
                            if (globalKey.currentState!.validate()) {
                              var result = await homeController.uploadState();
                              if (result == 200) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'تم ارسال التبرع بنجاح',
                                  desc: 'شكرا لمساهمتكم',

                                  btnOkOnPress: () {
                                    Get.toNamed(AppRoutes.home_page);
                                  },
                                )
                                  ..show();
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'لم تكتمل العملية',
                                  desc: 'الرجاء التأكد من البيانات المدخلة',

                                  btnOkOnPress: () {},
                                )
                                  ..show();
                              }
                            }
                          }
                          ),
                        ),
                      ],),
                    ),
                  ),
                  SizedBox(height: 50,)

                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  // Static GButton
                  GButton(
                    icon: Icons.home,
                    text: 'الرئسية',
                    onPressed: () {
                      // Handle onPressed for the static tab
                    },
                  ),
                  // Dynamic tabs generated from homeController.categoryState
                  ...List.generate(
                    homeController.categoryState.length,
                        (index) => GButton(
                      icon: Icons.category,
                      text: homeController.categoryState[index].name!,
                      onPressed: () {
                        homeController.category_id.value=homeController.categoryState[index].id!;
                        homeController.getTabraaByCategory();
                        Get.toNamed(AppRoutes.category);
                      },
                    ),
                  ),
                ],
                selectedIndex: 0,
                onTabChange: (index) {
                  // homeController.selectedIndex = index;
                  // scaffoldKey.currentState!.openEndDrawer();
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
