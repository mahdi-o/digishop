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

class ProductDetails extends GetView<ProductController> {
  ProductDetails({super.key});
  final Product product = Get.arguments;
  String mapData = Get.parameters['username']!;
  BasketController basket = BasketController();


  @override
  Widget build(BuildContext context) {
    int? lengthStar = product.star;
    return BaseWidget(color: Colors.white,
      bottomNavigation: null,
      appBar:
      AppBar(
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
      child: SingleChildScrollView(
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
                  width: 300,
                ) : Image.asset(
                  product.imageAddress.toString(),
                  fit: BoxFit.cover,
                  width: 300,
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
                    height: 20,
                  ),

                  CustomButton(
                    colorBtn: Colors.white,
                    textBtn: 'اضافه به سبد خرید',
                    textColor: kPurpleDark,
                    fontBtn: 'lalezarPlus',
                    fontSizeBtn: 28,
                    shadowColor: kPurpleDark,
                    onTapped: () {
                      print(mapData);
                      print('map data up');

                      print(product.id);
                      print("product_id up");
                      print(product.nameProduct);

                      basket.addBasketToDb(
                          "$mapData,${product.id}", mapData, product.id, 1.toInt(), 0);
                      Get.snackbar(
                        'افزودن به سبد خرید',
                        'کالا با موفقیت در سبد خرید اضافه شد',
                        backgroundColor: kPurpleDark,
                        colorText: Colors.white,
                        icon: const Icon(Icons.add_shopping_cart_rounded,size: 30,color: Colors.white,),
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
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
