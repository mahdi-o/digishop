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
import '../models/User.dart';
import '../widgets/navbar_custom.dart';

// class BasketScreen extends GetView<BasketController> {
//   BasketScreen({super.key});
//
//   Future<List<Product>> proListDb = MyDb().getProduct();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//           () => BaseWidget(
//         color: Colors.white,
//         appBar: null,
//         bottomNavigation: null,
//         child: controller.basketList.isEmpty
//             ? _buildEmptyBasketScreen(context)
//             : _buildBasketList(context),
//       ),
//     );
//   }
//
//   Widget _buildEmptyBasketScreen(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(color: Colors.white),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(
//             Icons.remove_shopping_cart_outlined,
//             size: 130,
//             color: Colors.black,
//           ),
//           const SizedBox(height: 30),
//           const Center(
//             child: Text(
//               'شما در حال حاضر هیچ سبد خریدی ندارید!',
//               style: TextStyle(fontSize: 24, color: Colors.black),
//             ),
//           ),
//           const SizedBox(height: 50),
//           CustomButton(
//             colorBtn: Colors.white,
//             textBtn: 'برگشت به صفحه اصلی',
//             textColor: kPurpleDark,
//             fontBtn: 'lalezarPlus',
//             fontSizeBtn: 22,
//             shadowColor: kPurpleDark,
//             onTapped: () {
//               FocusScope.of(context).unfocus();
//               Get.back();
//             },
//             splashColor: kPurpleDark,
//             borderColor: kPurpleDark,
//             widthBtn: 330,
//             heightBtn: 65,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBasketList(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 65),
//       child: Column(
//         children: [
//           _buildNavbar(context),
//           Expanded(
//             flex: 8,
//             child: ListView.builder(
//               itemCount: controller.basketList.length,
//               itemBuilder: (context, index) {
//                 Basket basket = controller.basketList[index];
//                 Product product = controller.productListFromBasket
//                     .firstWhere((p) => p.id == basket.productId);
//
//                 return _buildBasketItem(context, basket, product);
//               },
//             ),
//           ),
//           _buildBasketSummary(),
//           _buildCheckoutButton(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavbar(BuildContext context) {
//     return NavbarCustom(
//       text1: 'سبد',
//       text2: 'خرید',
//       size1: 30,
//       size2: 30,
//       fontFace1: 'Titr',
//       fontFace2: 'Titr',
//       icon1: Icons.delete_outline_rounded,
//       onTapIcon2: () {
//         dialogCustom('آیا از حذف همه سبدها اطمینان دارید؟', 16, () {
//           controller.deleteBaskets();
//           FocusScope.of(context).unfocus();
//           Get.back();
//         });
//       },
//       icon2: null,
//     );
//   }
//
//   Widget _buildBasketItem(BuildContext context, Basket basket, Product product) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 170,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     color: kPurpleLight, borderRadius: BorderRadius.circular(150)),
//                 child: Image.asset(
//                   product.imageAddress!.isEmpty
//                       ? proLaptopListCustom[
//                   Random().nextInt(10)]
//                       .imageAddress
//                       .toString()
//                       : product.imageAddress.toString(),
//                   width: 90,
//                 ),
//               ),
//               const SizedBox(width: 15),
//               Column(
//                 children: [
//                   SizedBox(
//                     height: 60,
//                     width: 230,
//                     child: Text(
//                       product.nameProduct.toString(),
//                       style: const TextStyle(fontSize: 15),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10.0),
//                     child: Row(
//                       children: [
//                         Text(
//                           separateDigits(int.parse(product.price!)),
//                           style: TextStyle(
//                             fontFamily: 'Titr',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: kPinkDark.withOpacity(0.7),
//                           ),
//                         ),
//                         const Text(
//                           ' تومان',
//                           style: TextStyle(
//                             fontFamily: 'Titr',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: kPinkDark,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   GestureDetector(
//                     onTap: () {
//                       FocusScope.of(context).unfocus();
//                       Get.toNamed('AppRoutes.proDet', arguments: product);
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: kPurpleDark),
//                         borderRadius: BorderRadius.circular(50),
//                         color: kPurpleLight,
//                       ),
//                       width: 110,
//                       height: 35,
//                       child: const Center(
//                         child: Text(
//                           'جزئیات',
//                           style: TextStyle(fontFamily: 'Titr', fontSize: 16),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Container(
//                     decoration: const BoxDecoration(
//                         color: kPurpleLight, shape: BoxShape.circle),
//                     height: 50,
//                     width: 50,
//                     child: Center(
//                       child: Text(
//                         'x${basket.count}',
//                         style: const TextStyle(
//                           color: kPinkDark,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Titr',
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   GestureDetector(
//                     onTap: () {
//                       controller.deleteItemInBaskets(basket.id!);
//                     },
//                     child: const Icon(
//                       Icons.delete_outline_rounded,
//                       size: 35,
//                       color: kPurpleDark,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const Divider(
//             color: kPurple,
//             thickness: 1,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBasketSummary() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'مجموع سبدها:',
//                 style: TextStyle(color: kPurpleDark, fontSize: 20),
//               ),
//               Text(
//                 'x${controller.countSum.value}',
//                 style: TextStyle(
//                   fontFamily: 'Titr',
//                   fontWeight: FontWeight.bold,
//                   color: kPinkDark,
//                   fontSize: 25,
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'جمع کل:',
//                 style: TextStyle(color: kPurpleDark, fontSize: 20),
//               ),
//               Text(
//                 '${separateDigits(controller.priceSum.value)} تومان',
//                 style: TextStyle(
//                   fontFamily: 'Titr',
//                   color: kPinkDark,
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCheckoutButton() {
//     return CustomButton(
//       colorBtn: kPurpleDark,
//       textBtn: 'خرید نهایی',
//       textColor: Colors.white,
//       fontBtn: 'Titr',
//       fontSizeBtn: 20,
//       splashColor: Colors.white,
//       shadowColor: Colors.pink.shade100,
//       borderColor: Colors.pink.shade50,
//       widthBtn: 250,
//       heightBtn: 50,
//       onTapped: () {
//         // controller.addOrders();
//         // FocusScope.of(context).unfocus();
//       },
//     );
//   }
// }
class BasketScreen extends GetView<BasketController> {
  BasketScreen({super.key});

  Future<List<Product>> proListDb = MyDb().getProduct();
  List<int> basketId = [];
  final User user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseWidget(
        color: Colors.white,
        appBar: null,
        bottomNavigation: null,
        floating: FloatingActionButton( onPressed: () {
          Get.toNamed(AppRoutes.home,arguments: user);
        },
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.arrow_back_sharp,
            size: 33,
          ),),
        floatingLocation: FloatingActionButtonLocation.startFloat,
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
                      textBtn: 'نمایش محصولات',
                      textColor: kPurpleDark,
                      fontBtn: 'lalezarPlus',
                      fontSizeBtn: 25,
                      shadowColor: kPurpleDark,
                      onTapped: () {
                        FocusScope.of(context).unfocus();
                        Get.toNamed(AppRoutes.showAllPro,
                            arguments: user,
                            parameters: {'all': 'all'});

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
                    GestureDetector(
                      onTap: () async {
                        print('start');
                        var rr = await controller.getBaskets();
                        print(rr);
                        print('var rr = await controller.getDataBaskets();');
                      },
                      child: NavbarCustom(
                        text1: ' سبد ',
                        text2: 'خرید',
                        size1: 30,
                        size2: 30,
                        fontFace1: 'Titr',
                        fontFace2: 'Titr',
                        icon1: Icons.delete_outline_rounded,
                        onTapIcon2: () {
                          dialogCustom(
                              'آیا از حذف همه سبدها اطمینان دارید؟', 16, () {
                            controller.deleteBaskets();
                            FocusScope.of(context).unfocus();
                            Get.back();
                          });
                        },
                        icon2: null,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: ListView.builder(
                        itemCount: controller.basketList.length,
                        itemBuilder: (context, index) {
                          Basket basket = controller.basketList[index];
                          Product? product;
                          print(controller.productListFromBasket.length);
                          print('pwwwwwwwwwwwwb');
                          // بررسی لیست محصولات فقط در صورتی که داده‌ای موجود باشد
                          if (controller.productListFromBasket.isNotEmpty) {
                            print('sub zeroooooooooooo');
                            // پیدا کردن محصول مربوطه با استفاده از یک جستجوی موثر
                            product =
                                controller.productListFromBasket.firstWhere(
                              (item) => item.id == basket.productId,
                              orElse: () =>
                                  Product(), // اگر محصول یافت نشد، یک محصول خالی برمی‌گرداند
                            );
                          } else {
                            print('bug freoooooooooooo');
                            product =
                                Product(); // اگر لیست خالی بود، محصول پیش‌فرض تخصیص داده می‌شود
                          }

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
                                          height: 40,
                                          width: 200,
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
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    Get.toNamed(
                                                        AppRoutes.proDet,
                                                        arguments: {
                                                          'product':product,
                                                          'user':user
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
                                                  fontSize: 16),
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
