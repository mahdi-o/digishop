import 'dart:math';

import 'package:digishop/constans.dart';
import 'package:digishop/controller/mysearch_controller.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/Product.dart';
import '../models/User.dart';
import '../widgets/navbar_custom.dart';

class SearchScreen extends GetView<MySearchController> {
  SearchScreen({super.key});

  RxBool heartStatus = false.obs;
  Random random = Random();
  final User user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Obx(
      () => BaseWidget(
          color: Colors.white,
          bottomNavigation: null,
          appBar: null,
          floatingLocation: FloatingActionButtonLocation.startFloat,
          floating: FloatingActionButton(
            onPressed: () {
              Get.toNamed(AppRoutes.home,arguments: user);
            },
            elevation: 20,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.arrow_back_sharp,
              size: 33,
            ),
          ),
          child: Column(
            children: [
               Padding(
                padding:
                    EdgeInsets.only(right: height/6, left: 0, bottom: 10, top: 50),
                child: const Column(
                  children: [
                    // ویجت NavbarCustom ثابت
                    SizedBox(
                      height: 60, // ارتفاع ثابت برای هدر
                      child: NavbarCustom(
                        text1: 'جست و جو',
                        text2: '',
                        size1: 28,
                        size2: 26,
                        fontFace1: 'lalezarPlus',
                        fontFace2: 'lalezarPlus',
                        icon1: null,
                        icon2: null,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: Get.height,
                  height: 55,
                  decoration: BoxDecoration(
                      color: kPurpleLight,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey)),
                  child: TextField(
                    autofocus: true,
                    controller: controller.text,
                    style: TextStyle(
                      color: Colors.black,
                      decorationColor: Colors.grey.shade100,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'جستجو',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade600, fontSize: 20),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: IconButton(
                          onPressed: () {
                            controller.searching(controller.text.text.trim());
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.grey.shade600,
                            size: 27,
                          )),
                    ),
                  ),
                ),
              ),
              controller.listSearch.isEmpty
                  ? controller.listSearch.isEmpty &&
                          controller.text.text.isNotEmpty
                      ? Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 120.0),
                              child: Text(
                                'محصولی یافت نشد!',
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 30),
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 120.0),
                              child: Text(
                                'برای پیدا کردن محصول موردنظرتان جست و جو کنید',
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 20),
                              ),
                            ),
                          ),
                        )
                  : Expanded(
                      child: SizedBox(
                        height: Get.height,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: controller.listSearch.length,
                          itemBuilder: (context, index) {
                            Product product = controller.listSearch[index];
                            return Padding(
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
                                    Container(
                                      decoration: BoxDecoration(
                                          color: kPurple,
                                          borderRadius:
                                              BorderRadius.circular(150)),
                                      child: product.imageAddress != ''
                                          ? Image.asset(
                                              product.imageAddress.toString(),
                                              width: 150,
                                            )
                                          : CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/images/slider${random.nextInt(7) + 1}.jpg'),
                                              radius: 70,
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          width: 230,
                                          child: Text(
                                            product.nameProduct.toString(),
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
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
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  Get.toNamed(
                                                    AppRoutes.proDet,
                                                    arguments: {
                                                        'product':product,
                                                        'user':user,'roll':'home'
                                                      },
                                                  parameters: {'all':'all'});
                                                },
                                                child: const Text(
                                                  'جزئیات',
                                                  style: TextStyle(
                                                      fontFamily: 'lalezarPlus',
                                                      fontSize: 16),
                                                ),
                                              )),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (heartStatus.value ==
                                                    false) {
                                                  heartStatus.value = true;
                                                } else {
                                                  heartStatus.value = false;
                                                }
                                              },
                                              child: heartStatus.value == false
                                                  ? const Icon(
                                                      CupertinoIcons.heart,
                                                      color: kPurpleDark,
                                                      size: 27,
                                                    )
                                                  : const Icon(
                                                      CupertinoIcons.heart_fill,
                                                      color: kPinkDark,
                                                      size: 27,
                                                    ),
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
                    ),
            ],
          )),
    );
  }
}
