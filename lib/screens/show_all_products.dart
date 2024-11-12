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

import '../widgets/custom_button.dart';

class ShowAllProducts extends GetView<ProductController> {
  ShowAllProducts({super.key});

  final RxBool heartStatus = false.obs;
  final String argument = Get.arguments;
  final String mapData = Get.parameters['username']!;
  final MyDb myDb = Get.find<MyDb>();
  RxBool statusAll = false.obs;

  @override
  Widget build(BuildContext context) {
    if(argument == 'all')
    {
    statusAll.value = true;
    }
    return Obx(
          () => BaseWidget(
        color: Colors.white,
        bottomNavigation: null,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          centerTitle: true,
          title: const Text('محصولات',style: TextStyle(fontFamily: 'lalezar',color: Colors.black,fontSize: 26),),
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              )),
        ),
        child: argument == 'all'
            ? _buildProductList(controller.listProductsDb,context)
            : _buildProductList(
          controller.listProductsDb.where((p) => p.brand == argument).toList(),context
        ),
      ),
    );
  }

  Widget _buildProductList(List<Product> products,context) {
    return products.isEmpty ?
    Container(
      decoration: const BoxDecoration(color: kPurpleDark),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.remove_shopping_cart_outlined,
            size: 130,
            color: Colors.white,
          ),
          const SizedBox(

            height: 30,
          ),
          const Center(
            child: Text(
              'شما در حال حاضر محصولی از این برند ندارید!',
              style: TextStyle(fontSize: 24, color: Colors.white),
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
            fontSizeBtn: 24,
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
        : ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index], index); // ارسال index به تابع
      },
    );
  }

  Widget _buildProductCard(Product product, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10), // برای اولین محصول padding بیشتری اعمال می‌شود
      child: Container(
        width: Get.width,
        height: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            _buildProductImage(product.imageAddress),
            const SizedBox(width: 10),
            _buildProductInfo(product),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String? imageAddress) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0,left: 5),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: kPurple,
            borderRadius: BorderRadius.circular(150),
          ),
          child: imageAddress != null && imageAddress.isNotEmpty
              ? Image.asset(imageAddress, width: 150)
              : const CircleAvatar(
            backgroundImage: AssetImage('assets/images/slider5.jpg'),
            radius: 70,
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo(Product product) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                product.nameProduct.toString(),
                style: const TextStyle(fontSize: 16,fontFamily: 'lalezar'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 15),
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
          const SizedBox(height: 10,),
          Row(
            children: [
              IconButton(
                onPressed: () => Get.toNamed(AppRoutes.adminProUpd, arguments: product),
                icon: const Icon(Icons.edit_rounded),
              ),
              const SizedBox(width: 5),
              _buildDetailsButton(product,context),
              const SizedBox(width: 20),
              _buildHeartIcon(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsButton(Product product,context) {
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
            String username =
            mapData.toString();
            Get.toNamed(
              AppRoutes.proDet,
              arguments: product,
              parameters: {
                'username': username
              },
            );
          },
          child: const Text(
            'جزئیات',
            style: TextStyle(fontFamily: 'Titr', fontSize: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildHeartIcon() {
    return Obx(
          () => GestureDetector(
        onTap: () => heartStatus.value = !heartStatus.value,
        child: Icon(
          heartStatus.value ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
          color: heartStatus.value ? kPinkDark : kPurpleDark,
          size: 27,
        ),
      ),
    );
  }
}

