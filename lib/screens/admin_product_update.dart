import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/screens/admin_home_screen.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';


class AdminProductUpdate extends GetView<ProductController> {
  AdminProductUpdate({super.key});
  final Product product = Get.arguments['product'];
  final User user = Get.arguments['user'];
  final String brandHomeScreen = Get.parameters['all']!;
  final MyDb xController = Get.find<MyDb>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      color: Colors.grey.shade300,
      appBar: null,
      onPressed: () {
        controller.clear();
        Future.delayed(const Duration(milliseconds: 2500), () {
          Get.offAll(
                () => AdminHomeScreen(), arguments: user,
            // صفحه مقصد
            transition: Transition.zoom,
            // نوع انیمیشن
            duration: const Duration(
                milliseconds: 500), // مدت زمان انیمیشن
          );
        });
        // Get.offAllNamed(AppRoutes.showAllPro,arguments: {'user':user,'roll':'admin'},parameters: {'all':brandHomeScreen});
      },
      bottomNavigation: null,
      child: AdminBaseWidget(
        textBtn:  'ویرایش اطلاعات',
        onTapButton: () async {
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
            controller.clear();
            Future.delayed(const Duration(milliseconds: 2500), () {
              Get.offAll(
                    () => AdminHomeScreen(), arguments: user,
                // صفحه مقصد
                transition: Transition.zoom,
                // نوع انیمیشن
                duration: const Duration(
                    milliseconds: 500), // مدت زمان انیمیشن
              );
            });
            // Future.delayed(const Duration(milliseconds: 2500),() {
            //   Get.offAllNamed(AppRoutes.showAllPro,arguments: {'user':user,'roll':'admin'},parameters: {'all':brandHomeScreen});
            // },);
          }
        },
        textNavbar2:'ویرایش اطلاعات محصول' ,
        paddingRight: 100,
        height: 300,
         child1:textFieldCustom(
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
        child8: 10,
        child2:textFieldCustom(
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
        child9: 50,

        child3:Row(
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
        child4:Row(
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
        child5:Row(
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
        child6:const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 5),
          child: Text(
            'تغییر عکس',
            style: TextStyle(color: kPurpleDark, fontSize: 20),
          ),
        ),
        child7:Image.asset(
          'assets/images/image.png',
          width: 110,
        ),
      ),
    );
  }
}
