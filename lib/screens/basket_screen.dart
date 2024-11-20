import 'dart:math';

import 'package:digishop/constans.dart';
import 'package:digishop/controller/basket_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Basket.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/navbar_custom.dart';

class BasketScreen extends GetView<BasketController> {
  BasketScreen({super.key});

  Future<List<Product>> proListDb = MyDb().getProduct();
  List<int> basketId = [];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseWidget(
        color: Colors.white,
        appBar: null,
        bottomNavigation: null,
        child: controller.basketList.isEmpty
            ? Container(
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
                      textBtn: 'برگشت به صفحه اصلی',
                      textColor: kPurpleDark,
                      fontBtn: 'lalezarPlus',
                      fontSizeBtn: 22,
                      shadowColor: kPurpleDark,
                      onTapped: () {
                        FocusScope.of(context).unfocus();
                        Get.back();
                      },
                      splashColor: kPurpleDark,
                      borderColor: kPurpleDark,
                      widthBtn: 330,
                      heightBtn: 65,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(
                    right: 10, left: 10, bottom: 20, top: 65),
                child: Column(
                  children: [
                    NavbarCustom(
                      text1: ' سبد ',
                      text2: 'خرید',
                      size1: 30,
                      size2: 30,
                      fontFace1:'Titr',
                      fontFace2: 'Titr',
                      icon1: Icons.delete_outline_rounded,
                      onTapIcon2: () {
                        dialogCustom('آیا از حذف همه سبدها اطمینان دارید؟',16, () {
                          controller.deleteBaskets();
                          FocusScope.of(context).unfocus();
                          Get.back();
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
                          basketId.add(basket.id!);
                          print(basket.productId! - 1);
                          print(
                              'basket.productId! - 1basket.productId! - 1basket.productId! - 1basket.productId! - 1');

                          print(
                              '${controller.productListFromBasket.length} dish dish dish');
                          print('*************************');
                          print(basket.nameBasket);
                          print(basket.productId);
                          print('*************************');

                          print(controller.productListFromBasket.length);

                          print('&&&&&&&&&&&&&&&&&&&&&&&');
                          Product product = controller
                              .productListFromBasket[basket.productId! - 1];

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 170,
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
                                        width: 90,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          width: 230,
                                          child: Text(
                                            product.nameProduct.toString(),
                                            style: const TextStyle(
                                              fontSize: 15,
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
                                                    int.parse(product.price!)),
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
                                                      'AppRoutes.proDet,arguments: product');
                                                },
                                                child: GestureDetector(
                                                  onTap: () {
                                                    String username = basket
                                                        .usernameId
                                                        .toString();
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    Get.toNamed(
                                                        AppRoutes.proDet,
                                                        arguments: product,
                                                        parameters: {
                                                          'username': username
                                                        });
                                                  },
                                                  child: const Text(
                                                    'جزئیات',
                                                    style: TextStyle(
                                                        fontFamily: 'Titr',
                                                        fontSize: 16),
                                                  ),
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
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: kPurpleLight,
                                              shape: BoxShape.circle),
                                          height: 50,
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
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.deleteItemInBaskets(
                                                basket.id!);
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
                          // return Text(basket.count.toString(),//style: TextStyle(fontSize: 80, color: Colors.red),);
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
              ),
      ),
    );
  }
}
