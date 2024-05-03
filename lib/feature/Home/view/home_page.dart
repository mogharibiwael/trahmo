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

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List imageCarousel = [
      'assets/image/donate4.jpeg',
      'assets/image/donate2.webp',
      'assets/image/donate3.jpeg',
    ];
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    HomeController homeController =
        Get.find<HomeController>();

    RefreshController _refreshController =
    RefreshController(initialRefresh: false);

    void _onRefresh() async{
      await Future.delayed(Duration(milliseconds: 1000));
      homeController.fetchState();
      _refreshController.refreshCompleted();
    }

    void _onLoading() async{
      await Future.delayed(Duration(milliseconds: 1000));
      homeController.fetchState();
      _refreshController.loadComplete();
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width*0.7,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: AppColors.buttonColor,),
                  accountName: Text(
                   '',
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(''),
                  currentAccountPictureSize: Size.square(50),

                ), //UserAccountDrawerHeader
              ), //DrawerHeader
              ListTile(
                leading: const Icon(Icons.upload),
                title:  Text('رفع حالة',style: TextStyle(fontSize: 20,color: AppColors.buttonColor),),
                onTap: () {
                  Get.toNamed(AppRoutes.uploadState);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title:  Text('الملف الشخصي',style: TextStyle(fontSize: 20,color: AppColors.buttonColor),),
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
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
        child: Column(
          children: [
            SizedBox(height: 40,),
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center
          ,children: [
              Expanded(child: IconButton(onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
                }, icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(alignment: Alignment.centerLeft,child: Icon(Icons.menu)),
              ),)),
              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("تراحموا",textAlign: TextAlign.end,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.buttonColor),),
              )),
            ],),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 14, top: 10),
              child: CarouselSlider(
                items: imageCarousel
                    .map((element) => ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.buttonColor,
                              ),
                              child: Image.asset(
                                element,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                        ))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true, aspectRatio: 1.0, enlargeCenterPage: true),
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))

                    ),
                    child: Text(
                      "حالات للتبرع",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
                    ))),
            Container(
              height: MediaQuery.of(context).size.height * 0.499,
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child: Obx(
                  () {
                    return !homeController.isLoading.value? ListView.builder(
                      itemCount: homeController.listStates.length,
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
                                            child: Row(
                                              children: [

                                                Expanded(child: Container(alignment: Alignment.center,decoration: BoxDecoration(
                                                    color: AppColors.buttonColor,
                                                  borderRadius: BorderRadius.circular(15)
                                                ),child: Text(homeController.listStates[index].category_name??""))),
                                                Expanded(
                                                  flex: 4,
                                                  child: Container(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                      homeController.listStates[index].state?.name??"",

                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                                                      Get.toNamed(AppRoutes.detailsPage,arguments:homeController.listStates[index] );
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
                    ):Center(child: CircularProgressIndicator(),);
                  }
                ),
              ),
            ),
          ],
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
      }),    );
  }
}
