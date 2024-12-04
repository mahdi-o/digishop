import 'dart:math';
import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:digishop/widgets/row_details_product.dart';
import 'package:digishop/widgets/star_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/basket_controller.dart';
import '../widgets/navbar_custom.dart';

class ProductDetails extends GetView<ProductController> {
  ProductDetails({super.key});
  final Product product = Get.arguments;
  String mapData = Get.parameters['username']!;
  BasketController basket = BasketController();
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    int? lengthStar = product.star;
    return BaseWidget(color: Colors.white,
      bottomNavigation: null,
      appBar:null,
      // AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: GestureDetector(
      //       onTap: () {
      //         Get.back();
      //       },
      //       child: const Icon(
      //         Icons.arrow_back_ios_rounded,
      //         color: Colors.black,
      //       )),
      // ),
      floatingLocation: FloatingActionButtonLocation.startFloat,
      floating: FloatingActionButton(
        onPressed: () {
          Get.back();
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
            EdgeInsets.only(right: height/6.5, left: 0, bottom: 0, top: 50),
            child: const Column(
              children: [
                // ویجت NavbarCustom ثابت
                SizedBox(
                  height: 60, // ارتفاع ثابت برای هدر
                  child: NavbarCustom(
                    text1: 'جزئیات محصول',
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
          SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Center(
                      child: GestureDetector(
                    onTap: () async {
                      await basket.getDataBaskets();
                    },
                    child: product.imageAddress!.isEmpty ?  Image.asset(
                      proLaptopList[Random().nextInt(10)].imageAddress.toString(),
                      fit: BoxFit.cover,
                      width: 270,
                    ) : Image.asset(
                      product.imageAddress.toString(),
                      fit: BoxFit.cover,
                      width: 250,
                    ),
                  )),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 350,
                            child: Text(
                              product.nameProduct.toString(),
                              style:
                                  const TextStyle(fontSize: 19, color: kPurpleDark),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          StarCustom(lengthStar: lengthStar!),
                          const Spacer(),
                          Text(
                            '${separateDigits(int.parse(product.price.toString()))} ت',
                            style: const TextStyle(fontSize: 20, color: kPinkDark),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      RowDetailsProduct(
                          title: 'حافظه رم', body: product.ram.toString()),
                      RowDetailsProduct(
                          title: 'تعداد', body: product.count.toString()),
                      RowDetailsProduct(
                          title: 'قطر صفحه نمایش', body: product.screen.toString()),
                      RowDetailsProduct(
                          title: 'پردازنده', body: product.cpu.toString()),
                      RowDetailsProduct(
                          title: 'حافظه داخلی', body: product.hard.toString()),
                      const SizedBox(
                        height: 40,
                      ),

                      CustomButton(
                        colorBtn: Colors.white,
                        textBtn: 'اضافه به سبد خرید',
                        textColor: kPurpleDark,
                        fontBtn: 'lalezarPlus',
                        fontSizeBtn: 28,
                        shadowColor: kPurpleDark,
                        onTapped: () {
                          basket.addBasketToDb(
                              "$mapData,${product.id}", mapData, product.id, 1.toInt(), 0);
                          Get.snackbar(
                            'افزودن به سبد خرید',
                            'کالا با موفقیت در سبد خرید اضافه شد',
                            backgroundColor: kPurpleDark,
                            colorText: Colors.white,
                            icon: const Icon(Icons.add_shopping_cart_rounded,size: 35,color: Colors.white,),
                            shouldIconPulse: false,
                          );
                        },
                        splashColor: kPurpleDark,
                        borderColor: kPurpleDark,
                        widthBtn: 330,
                        heightBtn: 65,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
