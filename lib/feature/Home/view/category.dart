import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trahmoo/core/style/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trahmoo/core/route/app_routes.dart';

import '../../../core/app_provider.dart';
import '../controller/controller.dart';

class Category extends GetView<HomeController> {
  Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    HomeController homeController =
    Get.find<HomeController>();

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
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use loadFailed(),if no data return,use LoadNodata()
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
        child: Obx(
           () {
            return homeController.isLoading==false? Column(
              children: [

                Container(
                  margin: EdgeInsets.only(top: 35),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))

                          ),
                          child: Text(
                            '${homeController.listStates2.isNotEmpty?homeController.listStates2[0].category_name :"المجموعة"}',
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
                          ))),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.82,
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child:  !homeController.isLoading.value? ListView.builder(
                            itemCount: homeController.listStates2.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),

                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    child: Stack(

                                      children: [
                                        // Image widget
                                        homeController.listStates[index].state!.is_from_app!? Image.network(
                                          "${AppProvider.baseUrl}'/static/images/'${homeController.listStates[index].state?.image}",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ):Image.network(

                                          "${AppProvider.baseUrl}${homeController.listStates[index].state?.image}",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                        // Overlay container with text and buttons
                                        Positioned.fill(
                                          child: Container(

                                            decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.4), // Set the desired overlay color and opacity
                                                borderRadius:BorderRadius.circular(15)
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  alignment: Alignment.topCenter,
                                                  padding: EdgeInsets.all(10),
                                                  color: Colors.white.withOpacity(0.8),
                                                  child: Text(
                                                    homeController.listStates2[index].state?.name??"",

                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor: AppColors.buttonColor
                                                          ),
                                                          onPressed: () {
                                                            Get.toNamed(AppRoutes.detailsPage,arguments:homeController.listStates2[index] );
                                                          },
                                                          child: Text('تفاصيل',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor: AppColors.buttonColor
                                                          ),

                                                          onPressed: () {
                                                            // Handle button 2 press
                                                          },
                                                          child: Text('تبرع الان',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ):Center(child: CircularProgressIndicator(),)

                  ),
                ),
              ],
            ):Center(child: CircularProgressIndicator());
          }
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
                      Get.toNamed(AppRoutes.home_page);
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
      }),    );
  }
}
