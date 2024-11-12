import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProductUpdate extends GetView<ProductController> {
  AdminProductUpdate({super.key});

  final Product product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: null,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 70),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Center(
                          child: Text('ویرایش اطلاعات محصول',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white))),
                    ],
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
                      7,
                      TextAlign.right,
                      20),
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
                      20),
                ],
              ),
              const SizedBox(
                height: 20,
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
                        20),
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
                        20),
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
                        20),
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
                        20),
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
                        20),
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
                        20),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 5),
                child: GestureDetector(
                  onTap: () async {
                    var res = await MyDb().readAllProducts();
                  },
                  child: const Text(
                    'تغییر عکس',
                    style: TextStyle(color: kPurpleDark, fontSize: 20),
                  ),
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
                  fontSizeBtn: 26,
                  shadowColor: kPurpleDark,
                  onTapped: () async {
                    await MyDb().updateProduct(
                        product.id!,
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
                        ));
                    FocusScope.of(context).unfocus();
                    Get.snackbar(
                      '',
                      '',
                      titleText: const Text(
                        'ویرایش اطلاعات',
                        style: TextStyle(fontSize: 18, color: kPurpleDark),
                      ),
                      messageText: const Text(
                        'اطلاعات محصول با موفقیت ویرایش شد',
                        style: TextStyle(fontSize: 18, color: kPurpleDark),
                      ),
                      backgroundColor: Colors.white,
                      colorText: kPinkDark,
                    );
                    Get.back();
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
