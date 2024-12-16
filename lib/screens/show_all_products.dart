import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import 'admin_home_screen.dart';

class ShowAllProducts extends GetView<ProductController> {
  ShowAllProducts({super.key});

  final User user = Get.arguments['user'];
  final String roll = Get.arguments['roll'];
  final String brandHomeScreen = Get.parameters['all']!;
  final RxList<Product> products = <Product>[].obs;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Product>>(
      future: controller.getProducts(), // متد بارگذاری محصولات از دیتابیس
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return mainWidget(
              context, const CircularProgressIndicator()); // نمایش لودینگ
        } else if (snapshot.hasError) {
          return mainWidget(
            context,
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Text(
                  'خطا در بارگذاری داده ها!',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 30),
                ),
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return mainWidget(
            context,
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 120.0),
                child: Text(
                  'محصولی یافت نشد!',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 30),
                ),
              ),
            ),
          );
        }
        if (brandHomeScreen == 'all') {
          products.value = snapshot.data!;
        } else {
          for (var item in snapshot.data!) {
            if (item.brand == brandHomeScreen) {
              // چک کردن وجود محصول در لیست قبل از اضافه کردن آن
              if (!products.any((existingItem) =>
              existingItem.nameProduct == item.nameProduct)) {
                products.add(item);
              }
            }
          }
        }
        return mainWidget(
          context,
          products.isEmpty
              ?
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 120.0),
              child: Text(
                'محصولی یافت نشد!',
                style:
                TextStyle(color: Colors.grey.shade600, fontSize: 30),
              ),
            ),
          )
              :
          Obx(
              ()=> ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: products.length,
            itemBuilder: (context, index) {
                final product = products[index];
                final RxBool heartStatus = false.obs;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            _buildProductImage(product),
                            const SizedBox(width: 5),
                            _buildProductInfo(product, context,heartStatus),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Colors.grey),
                  ],
                );
            },
          ),
              ),
        );
      },
    );
  }

Widget _buildProductImage(Product product) {
  return Padding(
    padding:  EdgeInsets.only(
      right: roll=='admin'?10.0:0.0,
    ),
    child: Container(
      decoration: BoxDecoration(
        color: kPurple,
        borderRadius: BorderRadius.circular(140),
      ),
      child: product.imageAddress != null && product.imageAddress!.isNotEmpty
          ? Image.asset(product.imageAddress!, width: 140)
          : const CircleAvatar(
        backgroundImage: AssetImage('assets/images/slider5.jpg'),
        radius: 70,
      ),
    ),
  );
}

Widget _buildProductInfo(Product product, context, RxBool heartStatus) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 200,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                product.nameProduct ?? '',
                style: const TextStyle(fontSize: 18, fontFamily: 'BlackNorth'),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 15),
          child: Text(
            '${separateDigits(int.parse(product.price.toString()))} تومان',
            style: TextStyle(
              fontFamily: 'Titr',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kPinkDark.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Get.toNamed(
                    AppRoutes.adminProUpd,
                    arguments: {'product': product, 'user': user},
                    parameters: {'all': brandHomeScreen}
                );
              },
              icon: roll == 'admin' ? const Icon(
                  Icons.edit_rounded, color: kPurpleDark) : const Icon(null),
            ),
             SizedBox(width: roll=='admin'?5:0),
            _buildDetailsButton(product,context,heartStatus),
             SizedBox(width: roll=='admin'?20:0),

            GestureDetector(
              onTap:roll=='admin'? () async {
                dialogCustom(
                    'آیا از حذف این محصول اطمینان دارید؟', 20, () async {
                  Get.back();
                  var result = await controller.deleteProduct(product.id ?? -1);
                  if (result != 0) {
                    FocusScope.of(context).unfocus();
                    controller.clear();
                    Future.delayed(const Duration(milliseconds: 2500), () {
                      Get.off(
                            () => AdminHomeScreen(), arguments: user,
                        // صفحه مقصد
                        transition: Transition.zoom,
                        // نوع انیمیشن
                        duration: const Duration(
                            milliseconds: 500), // مدت زمان انیمیشن
                      );
                    });
                  }
                });
              }:(){},
              child: roll == 'admin' ? const Icon(
                Icons.delete_outline_rounded,
                size: 35,
                color: kPurpleDark,
              ) : const Icon(null),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget mainWidget(BuildContext context, Widget child) {
  return BaseWidget(
        bottomNavigation: null,
      onPressed: ()async {
       await Get.toNamed(roll=='admin'?AppRoutes.adminHome:AppRoutes.home, arguments: user);
      },
        appBar: null,
        child:
        contentBaseWidget('محصولات', roll == 'admin' ? Icons.delete_outline_rounded : null, () async {
          roll == 'admin' ? dialogCustom(
              'آیا از حذف تمامی محصولات اطمینان دارید؟',
              20, () async {
            Get.back();
            var result = await controller.deleteProducts();
            if (result != 0) {
              FocusScope.of(context).unfocus();
              Future.delayed(const Duration(milliseconds: 2500), () {
                Get.off(
                      () => AdminHomeScreen(), arguments: user,
                  // صفحه مقصد
                  transition: Transition.zoom,
                  // نوع انیمیشن
                  duration: const Duration(
                      milliseconds: 500), // مدت زمان انیمیشن
                );
              });
            }
          }):(){};
        }, child)
    );
}

Widget _buildDetailsButton(Product product,BuildContext context,heartStatus) {
  return
  roll == 'home'?
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
                    fontFamily: 'lalezar',
                    fontSize: 18),
              ),
            )),
      ),
      const SizedBox(
        width: 20,
      ),
      Obx(
            ()=> GestureDetector(
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
      ),
    ],
  ):
   Container(
    decoration: BoxDecoration(
      border: Border.all(color: kPurpleDark),
      borderRadius: BorderRadius.circular(50),
      color: kPurpleLight,
    ),
    width:110,
    height:35,
    child: Center(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
              AppRoutes.proDet,
              arguments: {'product': product, 'user': user,'roll':roll},
              parameters: {'all': brandHomeScreen});
        }, // Add your navigation action here.
        child: const Text(
          'جزئیات',
          style: TextStyle(
              fontFamily: 'lalezarPlus', fontSize:18),
        ),
      ),
    ),
  );
}
}
