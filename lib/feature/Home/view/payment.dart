import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trahmoo/core/route/app_routes.dart';
import 'package:trahmoo/core/style/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trahmoo/core/widget/button.dart';
import 'package:trahmoo/core/widget/text_field.dart';
import 'package:trahmoo/feature/product/controller/productDetails.dart';
import '../controller/controller.dart';

class Payment extends GetView<ProductDetailsController> {
  Payment({Key? key}) : super(key: key);
  GlobalKey<FormState> globalKey=GlobalKey<FormState>();
  TextEditingController kuremy=TextEditingController();
  @override
  Widget build(BuildContext context) {
    HomeController homeController =
    Get.find<HomeController>();
    TextEditingController amount=TextEditingController();
    TextEditingController name=TextEditingController();
    TextEditingController phone=TextEditingController();
    TextEditingController authorFamily=TextEditingController();
    TextEditingController authorFamilyPhone=TextEditingController();
    RefreshController _refreshController =
    RefreshController(initialRefresh: false);
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
          child: Container(
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
                        child: Text(
                          "تفاصيل الدفع",
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
                        height: MediaQuery.of(context).size.height * 0.05,
                        margin: EdgeInsets.only(bottom: 5),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "تفاصيل الشحن",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'Tajawal'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton( onPressed: () { Navigator.of(context).pop(); }, icon: Icon(Icons.arrow_forward),)
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.03,

                        width: double.infinity,
                        child: Text(
                          "الاجمالي",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Tajawal'),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ListTile(
                          trailing: Text(
                            "الشحن",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          title: Row(
                            children: [
                              Text("ريال"),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                '${homeController.benefactor.amount}',
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        height: MediaQuery.of(context).size.height * 0.03,

                        width: double.infinity,
                        child: Text(
                          "طريقة الدفع",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Tajawal'),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.311,
                        child: Directionality(

                          textDirection: TextDirection.rtl,
                          child: Column(

                            children: [

                              Obx(
                                 () {
                                  return Column(
                                    children: [
                                      RadioListTile<int>(
                                        value: 0,
                                        autofocus: true,
                                        groupValue: homeController.selectedPaymentOption2.value,
                                        onChanged: (int? value) {

                                            homeController.selectedPaymentOption2.value = value!;

                                        },
                                        title: Text(
                                          'الدفع عن طريق حوالة كريمي',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),

                                      ),
                                      GeneralTextFeild(controller: kuremy, hintText: "رقم الحوالة", textInputType: TextInputType.number, hasValidate: true,)
                                    ],
                                  );
                                }
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0,left:18,top: 10,bottom: 30 ),
                        child: AppButton(formKey: globalKey,text: "تبرع",onpress: ()async {
                          if (globalKey.currentState!.validate()) {
                            var result = await homeController.sendTabraaData(
                                homeController.amount, homeController.id,
                                homeController.benefactor);
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
