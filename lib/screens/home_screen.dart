import 'package:digishop/constans.dart';
import 'package:digishop/controller/home_controller.dart';
import 'package:digishop/models/Category.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/box_row_product.dart';
import 'package:digishop/widgets/category_container.dart';
import 'package:digishop/widgets/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../widgets/navbar_custom.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});
  late Size size;
  final User user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Obx(
      ()=> BaseWidget(
        floatingActionButton: false,
        color: Colors.white,
        bottomNavigation: null,
        appBar: null,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 5),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, top: 65),
                      child: NavbarCustom(
                        text1: ' دیجی ',
                        text2: 'شاپ',
                        size1: 30,
                        size2: 30,
                        fontFace1: 'Titr',
                        fontFace2: 'Titr',
                        icon2: Icons.account_circle_outlined,
                        icon1: Icons.shopping_cart,
                        onTapIcon1: () {
                          FocusScope.of(context).unfocus();
                          Get.offAllNamed(AppRoutes.profile,arguments: user);
                        },
                        onTapIcon2: () {
                          FocusScope.of(context).unfocus();
                          Get.offAllNamed(AppRoutes.basket,arguments: user);
                        },
                        moveHomeAdmin: () {
                          FocusScope.of(context).unfocus();
                          Get.offAllNamed(AppRoutes.adminHome, arguments: user);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Divider(color: Colors.grey.shade300, thickness: 2),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30, top: 15),
                      child: Container(
                        width: 400,
                        height: 55,
                        decoration: BoxDecoration(
                            color: kPurpleLight,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey)),
                        child: TextField(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.toNamed(AppRoutes.search,
                                arguments: user);
                          },
                          style: TextStyle(
                            color: Colors.black,
                            decorationColor: Colors.grey.shade100,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'جستجو',
                            hintStyle: TextStyle(
                                color: Colors.grey.shade600, fontSize: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.grey.shade600,
                              size: 27,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const CustomSlider(),
                    const SizedBox(
                      height: 30,
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < categoryList.length; i++) ...[
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Get.toNamed(
                                  AppRoutes.showAllPro,
                                  arguments: {'user':user,'roll':'home'},
                                  parameters: {'all': '${categoryList[i].name}'},
                                );
                              },
                              child: CategoryContainer(
                                image: categoryList[i].imageAddress.toString(),
                              ),
                            )
                          ]
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          const Text('لپتاپ های برگزیده',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Titr')),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Get.toNamed(AppRoutes.showAllPro,
                                  arguments: {'user':user,'roll':'home'},
                                  parameters: {'all': 'all'});
                            },
                            child: Text(
                              'مشاهده همه',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: kPinkDark.withOpacity(0.8),
                                  fontFamily: 'Titr'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                          SizedBox(
                        height: 375,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.listProductsBestDb.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Get.toNamed(
                                  AppRoutes.proDet,
                                  arguments: {'product':controller.listProductsBestDb[index], 'user':user,'roll':'home'},
                                parameters: {'all':'all'}
                                );
                              },
                              child: BoxRowProduct(
                                  name: controller.listProductsBestDb[index].nameProduct
                                      .toString(),
                                  price:controller.listProductsBestDb[index].price
                                      .toString(),
                                  image: proLaptopList[index]
                                      .imageAddress
                                      .toString()),
                            );
                          },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          const Text('لپتاپ های پرفروش',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Titr')),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Get.toNamed(AppRoutes.showAllPro,
                                  arguments: {'user':user,'roll':'home'},
                                  parameters: {'all': 'all'});
                            },
                            child: Text(
                              'مشاهده همه',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: kPinkDark.withOpacity(0.8),
                                  fontFamily: 'Titr'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                        Obx(
                          ()=> SizedBox(
                          height: 375,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:controller.listProductsBestDb.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  Get.toNamed(
                                      AppRoutes.proDet,
                                      arguments: {'product':controller.listProductsBestDb[index], 'user':user,'roll':'home'},
                                      parameters: {'all':'all'}
                                  );
                                },
                                child: BoxRowProduct(
                                    name:controller.listProductsBestDb[index].nameProduct
                                        .toString(),
                                    price:controller.listProductsBestDb[index].price
                                        .toString(),
                                    image: proLaptopList[index]
                                        .imageAddress
                                        .toString()),
                              );
                            },
                          ),
                      ),
                        ),
                  ],
                ),
              ),
              // const MyNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }
}

