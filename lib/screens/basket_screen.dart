import 'dart:math';
import 'package:digishop/constans.dart';
import 'package:digishop/controller/basket_controller.dart';
import 'package:digishop/models/Basket.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/screens/home_screen.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../widgets/navbar_custom.dart';

class BasketScreen extends GetView<BasketController> {
  BasketScreen({super.key});

  final User user = Get.arguments;
  final List<int> basketId = [];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => BaseWidget(
        appBar: null,
        bottomNavigation: null,
            onPressed: () {
              Get.offAllNamed(AppRoutes.home, arguments: user);
            },
        child: controller.basketList.isEmpty
            ? _buildEmptyBasket(context) :
            _buildBasketList(context),
      ),
    );
  }
  Widget _buildEmptyBasket(BuildContext context){
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.remove_shopping_cart_outlined,
            size: 130,
            color: Colors.black,
          ),
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text(
              'شما در حال حاضر هیچ سبد خریدی ندارید!',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomButton(
            colorBtn: Colors.white,
            textBtn: 'نمایش محصولات',
            textColor: kPurpleDark,
            fontBtn: 'lalezarPlus',
            fontSizeBtn: 25,
            shadowColor: kPurpleDark,
            onTapped: () async {
              FocusScope.of(context).unfocus();
              Get.toNamed(AppRoutes.showAllPro,
                  arguments: {'user': user, 'roll': 'home'},
                  parameters: {'all': 'all'});
            },
            splashColor: kPurpleDark,
            borderColor: kPurpleDark,
            widthBtn: 330,
            heightBtn: 65,
          ),
        ],
      ),
    );
  }

  Widget _buildBasketList(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(
          right: 10, left: 10, bottom: 20, top: 65),
      child: Column(
        children: [
          NavbarCustom(
            text1: ' سبد ',
            text2: 'خرید',
            size1: 30,
            size2: 30,
            fontFace1: 'Titr',
            fontFace2: 'Titr',
            icon1: Icons.delete_outline_rounded,
            onTapIcon2: () {
              dialogCustom('آیا از حذف همه سبدها اطمینان دارید؟', 20,
                      () async {
                   FocusScope.of(context).unfocus();
                    Get.back();
                    var result = await controller.deleteBaskets();
                    if (result != 0) {
                      FocusScope.of(context).unfocus();
                      Future.delayed(const Duration(milliseconds: 2500),
                              () {
                            Get.offAll(
                                  () => HomeScreen(), arguments: user,
                              // صفحه مقصد
                              transition: Transition.zoom,
                              // نوع انیمیشن
                              duration: const Duration(
                                  milliseconds: 500), // مدت زمان انیمیشن
                            );
                          });
                    }
                  });
            },
            icon2: null,
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: controller.basketList.length,
              itemBuilder: (context, index) {
                Basket basket = controller.basketList[index];
                Product? product;
                // بررسی لیست محصولات فقط در صورتی که داده‌ای موجود باشد
                if (controller.productListFromBasket.isNotEmpty) {
                  // پیدا کردن محصول مربوطه با استفاده از یک جستجوی موثر
                  product = controller.productListFromBasket.firstWhere(
                            (item) => item.id == basket.productId,
                        orElse: () =>
                            Product(), // اگر محصول یافت نشد، یک محصول خالی برمی‌گرداند
                      );
                } else {
                  product =
                      Product(); // اگر لیست خالی بود، محصول پیش‌فرض تخصیص داده می‌شود
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: kPurpleLight,
                                borderRadius:
                                BorderRadius.circular(150)),
                            child: Image.asset(
                              product.imageAddress!.isEmpty
                                  ? proLaptopListCustom[
                              Random().nextInt(10)]
                                  .imageAddress
                                  .toString()
                                  : product.imageAddress.toString(),
                              width: 100,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 25,
                                width: 200,
                                child: SingleChildScrollView(
                                  scrollDirection:Axis.horizontal,
                                  child: Text(
                                    product.nameProduct.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'BlackNorth',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      separateDigits(
                                        int.parse(
                                          product.price ?? '0',
                                        ),
                                      ),
                                      style: TextStyle(
                                          fontFamily: 'Titr',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kPinkDark
                                              .withOpacity(0.7)),
                                    ),
                                    Text(
                                      ' تومان',
                                      style: TextStyle(
                                          fontFamily: 'Titr',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kPinkDark
                                              .withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
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

                                            Get.toNamed(AppRoutes.proDet,
                                                arguments: {
                                                  'product': product,
                                                  'user': user,
                                                  'roll': 'home'
                                                },
                                                parameters: {
                                                  'all': 'all'
                                                });
                                          },
                                          child: const Text(
                                            'جزئیات',
                                            style: TextStyle(
                                                fontFamily: 'Titr',
                                                fontSize: 16),
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0,top: 10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: kPurpleLight,
                                      shape: BoxShape.circle),
                                  height: 55,
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      'x${basket.count}',
                                      style: const TextStyle(
                                          color: kPinkDark,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Titr',
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  dialogCustom(
                                      'آیا از حذف این سبد خرید اطمینان دارید؟',
                                      20, () async {
                                    Get.back();
                                    var result = await controller
                                        .deleteItemBaskets(
                                        basket.id!);
                                    if (result != 0) {
                                      FocusScope.of(context)
                                          .unfocus();
                                      Future.delayed(
                                          const Duration(
                                              milliseconds: 2500),
                                              () {
                                            Get.offAll(
                                                  () => HomeScreen(),
                                              arguments: user,
                                              // صفحه مقصد
                                              transition: Transition.zoom,
                                              // نوع انیمیشن
                                              duration: const Duration(
                                                  milliseconds:
                                                  500), // مدت زمان انیمیشن
                                            );
                                          });
                                    }
                                  });
                                },
                                child: const Icon(
                                  Icons.delete_outline_rounded,
                                  size: 35,
                                  color: kPurpleDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: kPurple,
                        indent: 1,
                        thickness: 1,
                        endIndent: 2,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'مجموع سبدها: ',
                        style: TextStyle(
                            color: kPurpleDark, fontSize: 20),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        'x${controller.countSum.value}',
                        style: TextStyle(
                            fontFamily: 'Titr',
                            fontWeight: FontWeight.bold,
                            color: kPinkDark.withOpacity(0.7),
                            fontSize: 25),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'جمع کل: ',
                        style: TextStyle(
                            color: kPurpleDark, fontSize: 20),
                      ),
                      Text(
                        '${separateDigits(controller.priceSum.value)} تومان',
                        style: TextStyle(
                            fontFamily: 'Titr',
                            color: kPinkDark.withOpacity(0.7),
                            fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomButton(
              colorBtn: Colors.white,
              textBtn: 'پرداخت',
              textColor: kPurpleDark,
              fontBtn: 'lalezarPlus',
              fontSizeBtn: 28,
              shadowColor: kPurpleDark,
              onTapped: () {
                controller.checkOutBasket(basketId);
              },
              splashColor: kPurpleDark,
              borderColor: kPurpleDark,
              widthBtn: 330,
              heightBtn: 65,
            ),
          )
        ],
      ),
    );
  }






}
