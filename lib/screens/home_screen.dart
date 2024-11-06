import 'package:digishop/constans.dart';
import 'package:digishop/controller/home_controller.dart';
import 'package:digishop/database/my_db.dart';
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
    String username = user.username.toString();
    size = MediaQuery.of(context).size;
    return BaseWidget(
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
                      icon2: Icons.account_circle_outlined,
                      icon1: Icons.shopping_cart,
                      onTapIcon1: () {
                        Get.toNamed(AppRoutes.profile);
                      },
                      onTapIcon2: () {
                        Get.toNamed(AppRoutes.basket);
                      },
                      moveHomeAdmin: () {
                        Get.toNamed(AppRoutes.adminHome, arguments: username);
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
                          Get.toNamed(AppRoutes.search);
                        },
                        style: TextStyle(
                          color: Colors.black,
                          decorationColor: Colors.grey.shade100,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'جستجو',
                          hintStyle: TextStyle(color: Colors.grey.shade600,fontSize: 20),
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
                              Get.toNamed(AppRoutes.showAllPro,
                                  arguments: '${categoryList[i].name}',
                                  parameters: {'username': username});
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
                            Get.toNamed(AppRoutes.showAllPro,
                                arguments: 'all',
                                parameters: {'username': username});
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
                  // SizedBox(
                  //   height: 100,
                  //   child: SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: Row(
                  //       children: [
                  //         for (int i = 0; i < 4; i++) ...[
                  //           GestureDetector(
                  //               onTap: () {
                  //                 String username = user.username.toString();
                  //                 Get.toNamed(
                  //                   AppRoutes.proDet,
                  //                   arguments: proLaptopList[i],
                  //                   parameters: {'username': username},
                  //                 );
                  //               },
                  //               child: ListView.builder(
                  //                 scrollDirection: Axis.horizontal,
                  //                 itemCount:
                  //                 controller.listProductsBestDb.length,
                  //                 itemBuilder: (context, index) {
                  //                   return BoxRowProduct(
                  //                       name: proLaptopList[i]
                  //                           .nameProduct
                  //                           .toString(),
                  //                       price:
                  //                       proLaptopList[i].price.toString(),
                  //                       image: proLaptopList[i]
                  //                           .imageAddress
                  //                           .toString());
                  //                 },
                  //               ))
                  //         ]
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Obx(
                    ()=> SizedBox(
                      height: 375,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.listProductsBestDb.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              String username = user.username.toString();
                              Get.toNamed(
                                AppRoutes.proDet,
                                arguments: controller.listProductsBestDb[index],
                                parameters: {'username': username},
                              );
                            },
                            child: BoxRowProduct(
                                name: controller
                                    .listProductsBestDb[index].nameProduct
                                    .toString(),
                                price: controller.listProductsBestDb[index].price
                                    .toString(),
                                image:
                                    proLaptopList[index].imageAddress.toString()),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
                            Get.toNamed(AppRoutes.showAllPro,
                                arguments: 'all',
                                parameters: {'username': username});
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
                        itemCount: controller.listProductsBestDb.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: ()async{
                              // print(controller.checkNameProductForDb("Surface Laptop 4-i5 1135G7 16GB 256SSD"));
                              // controller.listProductsBestDb[index].nameProduct.toString()
                              print(await onCheck());
                              print('??;;;;;_____====="""""""00000000');
                              print(controller.listProductsBestDb[index].nameProduct);
                              print(controller
                                  .listProductsBestDb[index].price);
                              print(controller.listProductsBestDb[index].id);
                              print('8s8s8s8s8s8s8s8s8s8s8s8');

                              String username = user.username.toString();
                              Get.toNamed(
                                AppRoutes.proDet,
                                arguments: controller.listProductsBestDb[index],
                                parameters: {'username': username},
                              );
                            },
                            child: BoxRowProduct(
                                name: controller
                                    .listProductsBestDb[index].nameProduct
                                    .toString(),
                                price: controller.listProductsBestDb[index].price
                                    .toString(),
                                image:
                                proLaptopList[index].imageAddress.toString()),
                          );
                        },
                      ),
                    ),
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0; i < 4; i++) ...[
                  //         GestureDetector(
                  //           onTap: () {
                  //             String username = user.username.toString();
                  //             Get.toNamed(
                  //               AppRoutes.proDet,
                  //               arguments: proLaptopList[i],
                  //               parameters: {'username': username},
                  //             );
                  //           },
                  //           child: BoxRowProduct(
                  //               name: proLaptopList[i].nameProduct.toString(),
                  //               price: proLaptopList[i].price.toString(),
                  //               image:
                  //                   proLaptopList[i].imageAddress.toString()),
                  //         )
                  //       ]
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            // const MyNavigationBar(),
          ],
        ),
      ),
    );
  }
}
Future onCheck()async{
  MyDb db = await MyDb();
  var result = await db.checkNameProductForDb('LOQ 15IRH8-i7 13620H 16GB 512SSD RTX4050');
  print(result);
  return result;
}