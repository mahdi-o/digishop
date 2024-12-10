import 'dart:math';
import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:digishop/widgets/row_details_models.dart';
import 'package:digishop/widgets/star_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/basket_controller.dart';
import '../models/User.dart';
import '../services/routes.dart';
import '../widgets/navbar_custom.dart';

class ProductDetails extends GetView<ProductController> {
  ProductDetails({super.key});
  final Product product = Get.arguments['product'];
  final User user = Get.arguments['user'];
  final String roll = Get.arguments['roll'];
  final String brandHomeScreen = Get.parameters['all']!;
  final BasketController basket = BasketController();

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    int? lengthStar = product.star;
    return BaseWidget(color: Colors.white,
      bottomNavigation: null,
      appBar:null,
      floatingLocation: FloatingActionButtonLocation.startFloat,
      floating: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.showAllPro,arguments: {'user':user,'roll':roll},parameters: {'all':brandHomeScreen});
        },
        elevation: 20,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_sharp,
          size: 33,
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding:
              EdgeInsets.only(right: height/7.5, left: 0, bottom: 0, top: 50),
              child: const Column(

                children: [
                  // ویجت NavbarCustom ثابت
                  SizedBox(
                    height: 60, // ارتفاع ثابت برای هدر
                    child: NavbarCustom(
                      text1: 'مشخصات محصول',
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
                    const Divider(endIndent: 0.9,indent: 0.2,thickness: 0.4,color: Colors.grey,height: 1.5),

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
                        height: 200,
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
                        RowDetailsModels(
                            typeRow: 'product',title: 'حافظه رم', body: product.ram.toString()),
                        RowDetailsModels(
                            typeRow: 'product', title: 'تعداد', body: product.count.toString()),
                        RowDetailsModels(
                            typeRow: 'product', title: 'قطر صفحه نمایش', body: product.screen.toString()),
                        RowDetailsModels(
                            typeRow: 'product',title: 'پردازنده', body: product.cpu.toString()),
                        RowDetailsModels(
                            typeRow: 'product',title: 'حافظه داخلی', body: product.hard.toString()),


                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: CustomButton(
                            colorBtn: Colors.white,
                            textBtn: 'اضافه به سبد خرید',
                            textColor: kPurpleDark,
                            fontBtn: 'lalezarPlus',
                            fontSizeBtn: 28,
                            shadowColor: kPurpleDark,
                            onTapped: () {
                              basket.addBasketToDb(
                                  "${user.username},${product.id}", user.username, product.id, 1.toInt(), 0,0);

                              Get.snackbar(
                                '',
                                '',
                                titleText: const Text(
                                  'افزودن به سبد خرید',
                                  style: TextStyle(fontSize: 20, color: Colors.white),
                                ),
                                messageText: const Text(
                                  'محصول با موفقیت در سبد خرید اضافه شد',
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                backgroundColor: kPurpleDark,
                                colorText: Colors.white,
                                icon: const Icon(Icons.add_shopping_cart_rounded,size: 35,color: Colors.white,),
                                shouldIconPulse: false,
                                duration: const Duration(milliseconds: 1500),
                              );
                            },
                            splashColor: kPurpleDark,
                            borderColor: kPurpleDark,
                            widthBtn: 330,
                            heightBtn: 65,
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
    );
  }
}
