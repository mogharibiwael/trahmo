import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trahmoo/core/route/app_routes.dart';
import 'package:trahmoo/core/style/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trahmoo/core/widget/button.dart';
import 'package:trahmoo/core/widget/text_field.dart';
import 'package:trahmoo/feature/Home/model/benefactor.dart';
import 'package:trahmoo/feature/product/controller/productDetails.dart';
import '../../../core/app_provider.dart';
import 'package:trahmoo/feature/Home/model/state.dart' as stateModel;
import '../controller/controller.dart';

class Details extends GetView<ProductDetailsController> {
  Details({Key? key}) : super(key: key);
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  stateModel.Tabraa state = Get.arguments as stateModel.Tabraa;
  List<Map<String, dynamic>> containerData = [
    {'number': 1000, 'id': 123, 'color': Colors.blue},
    {'number': 2000, 'id': 456, 'color': Colors.green},
    {'number': 3000, 'id': 789, 'color': Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();

    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController authorFamily = TextEditingController();
    TextEditingController authorFamilyPhone = TextEditingController();
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    void _onRefresh() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use refreshFailed()
      homeController.fetchState();
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
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
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
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
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                        child: Text(
                          "تفاصيل الحاله",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
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
                    child: Obx(() {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child:state.state!.is_from_app!? Image.network(
                                  "${AppProvider.baseUrl}${state.state?.image!}"):Image.network(
                                  "${AppProvider.baseUrl}/static/images${state.state?.image!}"),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Card(
                                    color: Colors.white70,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(state.state?.name ?? ""),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(':العنوان'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card(
                                    color: Colors.white70,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              state.state?.description ?? "",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(':الوصف'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card(
                                    color: Colors.white70,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${state.state?.amount}"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(':المبلغ'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card(
                                    color: Colors.white70,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${state.paid}"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(':المتبقي لإكمال الحالة'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 20),
                            child: Obx(() {
                              return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(containerData.length,
                                      (index) {
                                return GestureDetector(
                                    onTap: () {
                                      homeController.selectedContainerIndex.value=index;
                                      homeController.setAmount(containerData[homeController.selectedContainerIndex.value]['number'].toString());
                                    },
                                    child: Container(padding: EdgeInsets.all(5),decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        blurRadius: 20,
                                        color: Colors.black.withOpacity(.1),
                                      )
                                    ],color:homeController.selectedContainerIndex.value==index?  AppColors.buttonColor:Colors.grey,borderRadius: BorderRadius.circular(8)),height: 40,width: 100,child: Text(containerData[index]['number'].toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 20),),),);
                              }));

                            }),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                children: [
                                  Expanded(child: Text('مبلغ اخر')),
                                  Obx(
                                     () {
                                      return Expanded(
                                          flex: 3,
                                          child: GeneralTextFeild(
                                            controller: homeController.amountController.value,
                                            hintText: 'المبلغ',
                                            textInputType: TextInputType.text,
                                            hasValidate: false,
                                          ));
                                    }
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: homeController.isChecked.value,
                                    onChanged: (newValue) {
                                      print(newValue);
                                      homeController
                                          .changeCheckButton(newValue);
                                    },
                                    // optional parameters
                                    activeColor: Colors.green,
                                    checkColor: Colors.white,
                                    tristate: false,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  Text(
                                    "تبرع عن اهلك",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          homeController.isChecked.value
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        'اسم المتبرع عنه')),
                                                Expanded(
                                                    flex: 3,
                                                    child: GeneralTextFeild(
                                                      controller: authorFamily,
                                                      hintText:
                                                          'اسم المتبرع عنه',
                                                      textInputType:
                                                          TextInputType.text,
                                                      hasValidate:
                                                          homeController
                                                                  .isChecked
                                                                  .value
                                                              ? true
                                                              : false,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text('رقم الهاتف')),
                                                Expanded(
                                                    flex: 3,
                                                    child: GeneralTextFeild(
                                                      controller:
                                                          authorFamilyPhone,
                                                      hintText: 'رقم الهاتف',
                                                      textInputType:
                                                          TextInputType.text,
                                                      hasValidate:
                                                          homeController
                                                                  .isChecked
                                                                  .value
                                                              ? true
                                                              : false,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text('الاسم')),
                                          Expanded(
                                              flex: 3,
                                              child: GeneralTextFeild(
                                                controller: name,
                                                hintText: 'الاسم',
                                                textInputType:
                                                    TextInputType.text,
                                                hasValidate: true,
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(child: Text('رقم الهاتف')),
                                          Expanded(
                                              flex: 3,
                                              child: GeneralTextFeild(
                                                controller: phone,
                                                hintText: 'رقم الهاتف',
                                                textInputType:
                                                    TextInputType.text,
                                                hasValidate: true,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 18.0, left: 18, top: 10, bottom: 30),
                            child: AppButton(
                                formKey: globalKey,
                                text: "تبرع",
                                onpress: () async {
                                  if (globalKey.currentState!.validate()) {
                                    homeController.benefactor = Benefactor(
                                        name: name.text,
                                        phone: phone.text,
                                        amount: homeController.getAmountController,
                                        aotherBenefactor: authorFamily.text,
                                        aotherPhone: authorFamilyPhone.text);
                                    homeController.amount = homeController.getAmountController;
                                    homeController.id = state.id!;
                                    Get.toNamed(AppRoutes.payment);
                                  }
                                }),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
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
                        homeController.category_id.value =
                            homeController.categoryState[index].id!;
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
