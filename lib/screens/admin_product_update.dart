import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../services/routes.dart';
import '../widgets/navbar_custom.dart';

class AdminProductUpdate extends GetView<ProductController> {
  AdminProductUpdate({super.key});
  final Product product = Get.arguments['product'];
  final User user = Get.arguments['user'];
  final String brandHomeScreen = Get.parameters['all']!;
  final MyDb xController = Get.find<MyDb>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: null,
      floatingLocation: FloatingActionButtonLocation.startFloat,
      floating: FloatingActionButton(
        onPressed: () {
          controller.clear();
          Get.toNamed(AppRoutes.showAllPro,arguments: {'user':user,'roll':'admin'},parameters: {'all':brandHomeScreen});
        },
        elevation: 20,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_sharp,
          size: 33,
        ),
      ),
      bottomNavigation: null,
      color: Colors.grey.shade300,
      child: AdminBaseWidget(
        height: 300,
        color: Colors.grey.shade200,
        childWidget: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 100, left: 10),
                    child: Column(
                      children: [
                        // ویجت NavbarCustom ثابت
                        SizedBox(
                          height: 40, // ارتفاع ثابت برای هدر
                          child: NavbarCustom(
                            text1: '',
                            text2: 'ویرایش اطلاعات محصول',
                            colorText2: Colors.white,
                            size1: 28,
                            size2: 26,
                            fontFace1: 'lalezarPlus',
                            fontFace2: 'lalezarPlus',
                            icon1: null,
                            icon2: null,
                          ),
                        ),
                        // محتوای اسکرول‌شونده
                      ],
                    ),
                  ),
                  textFieldCustom(
                      controller.nameProduct.value =
                          TextEditingController(text: product.nameProduct),
                      Colors.white,
                      Colors.white70,
                      Colors.white,
                      Colors.white38,
                      'نام محصول',
                      30,
                      0,
                      TextAlign.right,
                      22),
                  textFieldCustom(
                      controller.priceProduct.value =
                          TextEditingController(text: product.price),
                      Colors.white,
                      Colors.white70,
                      Colors.white,
                      Colors.white38,
                      'قیمت',
                      30,
                      7,
                      TextAlign.right,
                      22),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: textFieldCustom(
                        controller.brandProduct.value =
                            TextEditingController(text: product.brand),
                        Colors.black,
                        kPurpleDark.withOpacity(0.7),
                        kPurpleDark,
                        kPurpleDark.withOpacity(0.7),
                        'برند',
                        30,
                        10,
                        TextAlign.right,
                        22),
                  ),
                  Expanded(
                    child: textFieldCustom(
                        controller.ramProduct.value =
                            TextEditingController(text: product.ram),
                        Colors.black,
                        kPurpleDark.withOpacity(0.7),
                        kPurpleDark,
                        kPurpleDark.withOpacity(0.7),
                        'رم',
                        30,
                        10,
                        TextAlign.right,
                        22),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: textFieldCustom(
                        controller.hardProduct.value =
                            TextEditingController(text: product.hard),
                        Colors.black,
                        kPurpleDark.withOpacity(0.7),
                        kPurpleDark,
                        kPurpleDark.withOpacity(0.7),
                        'حافظه',
                        30,
                        10,
                        TextAlign.right,
                        22),
                  ),
                  Expanded(
                    child: textFieldCustom(
                        controller.cpuProduct.value =
                            TextEditingController(text: product.cpu),
                        Colors.black,
                        kPurpleDark.withOpacity(0.7),
                        kPurpleDark,
                        kPurpleDark.withOpacity(0.7),
                        'پردازنده',
                        30,
                        10,
                        TextAlign.right,
                        22),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: textFieldCustom(
                        controller.screenProduct.value =
                            TextEditingController(text: product.screen),
                        Colors.black,
                        kPurpleDark.withOpacity(0.7),
                        kPurpleDark,
                        kPurpleDark.withOpacity(0.7),
                        'صفحه نمایش',
                        30,
                        10,
                        TextAlign.right,
                        22),
                  ),
                  Expanded(
                    child: textFieldCustom(
                        controller.countProduct.value = TextEditingController(
                            text: product.count.toString()),
                        Colors.black,
                        kPurpleDark.withOpacity(0.7),
                        kPurpleDark,
                        kPurpleDark.withOpacity(0.7),
                        'تعداد',
                        30,
                        10,
                        TextAlign.right,
                        22),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 5),
                child: Text(
                  'تغییر عکس',
                  style: TextStyle(color: kPurpleDark, fontSize: 20),
                ),
              ),
              Image.asset(
                'assets/images/image.png',
                width: 110,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: CustomButton(
                  colorBtn: Colors.white,
                  textBtn: 'ویرایش اطلاعات',
                  textColor: kPurpleDark,
                  fontBtn: 'lalezarPlus',
                  fontSizeBtn: 28,
                  shadowColor: kPurpleDark,
                  onTapped: () async {
                   var result = await controller.updateProduct(product.id!,
                        Product(
                          id: product.id,
                          nameProduct: controller.nameProduct.value.text,
                          brand: controller.brandProduct.value.text,
                          imageAddress: product.imageAddress,
                          price: controller.priceProduct.value.text,
                          ram: controller.ramProduct.value.text,
                          count: int.parse(controller.countProduct.value.text),
                          screen: controller.screenProduct.value.text,
                          cpu: controller.cpuProduct.value.text,
                          hard: controller.hardProduct.value.text,
                          star: product.star,
                          createdAt: product.createdAt,
                          updatedAt: DateTime.now().toString().split(".")[0],
                          deleteStatus: 0,
                        ));
                    if(result != 0){
                      FocusScope.of(context).unfocus();
                      Future.delayed(const Duration(milliseconds: 2500),() {
                        Get.toNamed(AppRoutes.showAllPro,arguments: {'user':user,'roll':'admin'},parameters: {'all':brandHomeScreen});
                      },);
                    }
                  },
                  splashColor: kPurpleDark,
                  borderColor: kPurpleDark,
                  widthBtn: 330,
                  heightBtn: 65,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
