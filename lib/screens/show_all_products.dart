import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../models/User.dart';
import '../widgets/custom_button.dart';
import '../widgets/navbar_custom.dart';

class ShowAllProducts extends GetView<ProductController> {
  ShowAllProducts({super.key});
  final User user = Get.arguments;
  final String brandHomeScreen = Get.parameters['all']!;
  final MyDb myDb = Get.find<MyDb>();
  @override
  final ProductController controller = Get.find<ProductController>();
  RxList<Product> listProducts = <Product>[].obs;
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    print(brandHomeScreen);
    print('brandHomeScreen brandHomeScreen brandHomeScreen brandHomeScreen');

    return FutureBuilder<List<Product>>(
      future: controller.getListProduct(), // متد بارگذاری محصولات از دیتابیس
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return mainWidget(
              context, const CircularProgressIndicator()); // نمایش لودینگ
        } else if (snapshot.hasError) {
          return mainWidget(
            context,
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 120.0),
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
          products = snapshot.data!;
        } else {
          for (var item in snapshot.data!) {
            if (item.brand == brandHomeScreen) {
              products.add(item);
              print('addddddddd brand');
              print(item.nameProduct);
            } else {
              // not product brand
              false;
            }
          }
        }
        print(products.length);
        return mainWidget(
          context,
          products.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 120.0),
                    child: Text(
                      'محصولی یافت نشد!',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 30),
                    ),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
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
                                _buildProductInfo(product),
                              ],
                            ),
                          ),
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _buildProductImage(Product product) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10.0,
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

  ///

  Widget _buildProductInfo(Product product) {
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
                  style: const TextStyle(fontSize: 16, fontFamily: 'lalezar'),
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
                    arguments: product,
                    parameters: {'username': user.username.toString()},
                  );
                },
                icon: const Icon(Icons.edit_rounded, color: kPurpleDark),
              ),
              const SizedBox(width: 5),
              _buildDetailsButton(product),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () async {
                  await myDb.deleteProduct(product.id ?? -1);
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
    );
  }

  ///

  Widget mainWidget(BuildContext context, Widget child) {
    return BaseWidget(
        color: Colors.white,
        bottomNavigation: null,
        floating:
        FloatingActionButton(
          onPressed: () {
            Get.back();
          },
          elevation: 20,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          child: const Icon(Icons.arrow_back_sharp, size: 33,),
        ),
        floatingLocation: FloatingActionButtonLocation.startFloat,
        appBar: null,
        child: Padding(
          padding: const EdgeInsets.only(
              right: 10, left: 10, bottom: 20, top: 60),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: Get.height,
              child: Column(children: [
                Expanded(
                  flex: 0,
                  child: NavbarCustom(
                    text1: '  محصولات ',
                    text2: '',
                    size1: 28,
                    size2: 26,
                    fontFace1: 'lalezarPlus',
                    fontFace2: 'lalezarPlus',
                    icon1: Icons.delete_outline_rounded,
                    onTapIcon2: () async {
                      dialogCustom(
                          'آیا از حذف تمامی محصولات اطمینان دارید؟',20,
                              () {
                            var result = MyDb().deleteProducts();
                            print(result);
                            FocusScope.of(context).unfocus();
                            Get.back();
                          });
                    },
                    icon2: null,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(child: child)
              ],),
            ),
          ),
        )
    );
    // return BaseWidget(
    //     color: Colors.white,
    //     bottomNavigation: null,
    //     appBar: AppBar(
    //       elevation: 0,
    //       toolbarHeight: 70,
    //       centerTitle: true,
    //       title: const Text(
    //         'محصولات',
    //         style: TextStyle(
    //             fontFamily: 'lalezar', color: Colors.black, fontSize: 26),
    //       ),
    //       backgroundColor: Colors.white,
    //       leading: GestureDetector(
    //           onTap: () {
    //             FocusScope.of(context).unfocus();
    //             Get.back();
    //           },
    //           child: const Icon(
    //             Icons.arrow_back_ios_rounded,
    //             color: Colors.black,
    //           )),
    //     ),
    //     child: child);
  }

  Widget _buildDetailsButton(Product product) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kPurpleDark),
        borderRadius: BorderRadius.circular(50),
        color: kPurpleLight,
      ),
      width: 110,
      height: 35,
      child: Center(
        child: GestureDetector(
          onTap: () {
            String username = user.username.toString();
            Get.toNamed(
              AppRoutes.proDet,
              arguments: product,
              parameters: {'username': username},
            );
          }, // Add your navigation action here.
          child: const Text(
            'جزئیات',
            style: TextStyle(fontFamily: 'lalezarPlus', fontSize: 18),
          ),
        ),
      ),
    );
  }

  ///
}
