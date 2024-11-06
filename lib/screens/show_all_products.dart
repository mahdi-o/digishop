import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_button.dart';

class ShowAllProducts extends GetView<ProductController> {
  ShowAllProducts({super.key});

  String argument = Get.arguments;
  String mapData = Get.parameters['username']!;
  MyDb myDb = Get.find<MyDb>();

  @override
  Widget build(BuildContext context) {
    print('tohi');
    print(argument);
    print('argoman');
    print(mapData);
    return Obx(
      () => BaseWidget(
        color: Colors.white,
        bottomNavigation: null,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              )),
        ),
        // controller.productBrand(context, argument,mapData),

        child: argument == 'all'
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: Get.height,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.listProductsDb.length,
                    itemBuilder: (context, index) {
                      print(controller.listProductsDb.length);
                      print('moshahede hame');
                      Product product = controller.listProductsDb[index];
                      // print(controller.listProductsDb.length);
                      // if(controller.listProductsDb[index].brand == argument){
                      //   print('boooood');
                      //   productBrand.add(controller.listProductsDb[index]);
                      //   print('add');
                      // }
                      // else{
                      //   print('naboooood');
                      // }
                      // Product product = productBrand[index];
                      return controller.listProductsDb.isEmpty
                          ? SizedBox(
                              height: Get.width / 0.7,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'شما در حال حاضر هیچ محصولی ندارید!',
                                      style: TextStyle(
                                          fontSize: 21, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 170,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: kPurple,
                                            borderRadius:
                                                BorderRadius.circular(150)),
                                        child:
                                        product.imageAddress != ''
                                            ? Image.asset(
                                                product.imageAddress.toString(),
                                                width: 150,
                                              )
                                            : const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/images/slider5.jpg'),
                                                radius: 70,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 80,
                                          width: 200,
                                          child: Center(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: SizedBox(
                                                width: 150,
                                                child: Text(
                                                  product.nameProduct
                                                      .toString(),
                                                  style: const TextStyle(
                                                     fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            '${separateDigits(int.parse(product.price.toString()))} تومان',
                                            style: TextStyle(
                                                fontFamily: 'Titr',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    kPinkDark.withOpacity(0.7)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Get.toNamed(
                                                      AppRoutes.adminProUpd,
                                                      arguments: product);
                                                },
                                                icon: const Icon(
                                                    Icons.edit_rounded)),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: kPurpleDark),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: kPurpleLight),
                                              width: 110,
                                              height: 35,
                                              child: Center(
                                                  child: GestureDetector(
                                                onTap: () {
                                                  // Get.toNamed(AppRoutes.proDet,arguments: product,parameters: {'username':nameUser});
                                                },
                                                child: const Text(
                                                  'جزئیات',
                                                  style: TextStyle(
                                                      fontFamily: 'Titr',
                                                      fontSize: 15),
                                                ),
                                              )),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const Icon(
                                              CupertinoIcons.heart,
                                              color: kPurpleDark,
                                              size: 27,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: Get.height,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.listProductsDb
                        .where((p) => p.brand == argument)
                        .toList()
                        .length,
                    itemBuilder: (context, index) {
                      print(controller.listProductsDb
                          .where((p) => p.brand == argument)
                          .toList()
                          .length);
                      print('moshahede hame');

                      Product product = controller.listProductsDb
                          .where((p) => p.brand == argument)
                          .toList()[index];

                      return controller.listProductsDb
                              .where((p) => p.brand == argument)
                              .toList()
                              .isNotEmpty
                          ? Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kPurple,
                                                borderRadius:
                                                    BorderRadius.circular(150)),
                                            child: product.imageAddress != ''
                                                ? Image.asset(
                                                    product.imageAddress
                                                        .toString(),
                                                    width: 150,
                                                  )
                                                : const CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        'assets/images/slider5.jpg'),
                                                    radius: 70,
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 80,
                                              width: 200,
                                              child: Center(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      product.nameProduct
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                '${separateDigits(int.parse(product.price.toString()))} تومان',
                                                style: TextStyle(
                                                    fontFamily: 'Titr',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: kPinkDark
                                                        .withOpacity(0.7)),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          AppRoutes.adminProUpd,
                                                          arguments: product);
                                                    },
                                                    icon: const Icon(
                                                        Icons.edit_rounded)),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: kPurpleDark),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: kPurpleLight),
                                                  width: 110,
                                                  height: 35,
                                                  child: Center(
                                                      child: GestureDetector(
                                                    onTap: () {
                                                      // Get.toNamed(AppRoutes.proDet,arguments: product,parameters: {'username':nameUser});
                                                    },
                                                    child: const Text(
                                                      'جزئیات',
                                                      style: TextStyle(
                                                          fontFamily: 'Titr',
                                                          fontSize: 15),
                                                    ),
                                                  )),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                const Icon(
                                                  CupertinoIcons.heart,
                                                  color: kPurpleDark,
                                                  size: 27,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: Get.width / 0.7,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'شما در حال حاضر هیچ محصولی ندارید!',
                                          style: TextStyle(
                                              fontSize: 21,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
