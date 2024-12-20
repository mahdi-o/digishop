import 'package:digishop/controller/invoice_controller.dart';
import 'package:digishop/models/Invoice.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constans.dart';
import '../database/my_db.dart';
import '../models/User.dart';
import '../services/routes.dart';
import '../widgets/base_widget.dart';
import 'admin_home_screen.dart';

class ShowAllInvoices extends GetView<InvoiceController> {
  ShowAllInvoices({super.key});

  final User user = Get.arguments;
  final MyDb myDb = Get.find<MyDb>();
  final RxList<Invoice> invoices = <Invoice>[].obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Invoice>>(
      future: controller.getInvoices(), // متد بارگذاری فاکتورها از دیتابیس
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return mainWidget(
              context, const CircularProgressIndicator()); // نمایش لودینگ
        } else if (snapshot.hasError) {
          return mainWidget(
            context,
            Center(
              child: Padding(
                padding:  EdgeInsets.only(bottom: Get.height/18),
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
                padding:  EdgeInsets.only(bottom: Get.height/18),
                child: Text(
                  'فاکتوری یافت نشد!',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 30),
                ),
              ),
            ),
          );
        }
        for (var item in snapshot.data!) {
          // چک کردن وجود فاکتور در لیست قبل از اضافه کردن آن
          if (!invoices.any((existingItem) =>
          existingItem.nameCustomer == item.nameCustomer)) {
            invoices.add(item);
          }

        }

        return mainWidget(
          context,
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: invoices.length,
            itemBuilder: (context, index) {
              final invoice = invoices[index];
              return _buildInvoiceInfo(invoice, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildInvoiceInfo(Invoice invoice, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 240,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: kPurpleDark),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' نام مشتری : ${invoice.nameCustomer.toString()} ',
                    style: const TextStyle(
                        fontFamily: 'lalezar',
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  Text(
                    ' آِیدی فاکتور : ${invoice.id.toString()} ',
                    style: const TextStyle(
                        fontFamily: 'lalezar',
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  Text(
                    ' نوع پرداخت : ${invoice.typePay.toString()} ',
                    style: const TextStyle(
                        fontFamily: 'lalezar',
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  Row(
                    children: [
                      Text(
                        ' مقدار تخفیف : ${invoice.discount!.isEmpty ? 0 : invoice.discount.toString()} ',
                        style: const TextStyle(
                            fontFamily: 'lalezar',
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        ' پرداخت شده : ${invoice.isPaying == 0 ? 'خیر' : 'بله'} ',
                        style: const TextStyle(
                            fontFamily: 'lalezar',
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      CustomButton(
                        elevationBtn: 3,
                        colorBtn: Colors.white,
                        textBtn: 'پرداخت',
                        textColor: kPurpleDark,
                        fontBtn: 'lalezar',
                        fontSizeBtn: 22,
                        shadowColor: kPurpleDark,
                        onTapped: () async {
                          var result =
                              await controller.changePayInvoice(invoice.id!);
                          if (result != 0) {
                            FocusScope.of(context).unfocus();
                            Future.delayed(const Duration(milliseconds: 2500),
                                () {
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
                        },
                        splashColor: kPurpleDark,
                        borderColor: kPurpleDark,
                        widthBtn: 150,
                        heightBtn: 45,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      CustomButton(
                        elevationBtn: 3,
                        colorBtn: Colors.white,
                        textBtn: 'جزئیات',
                        textColor: kPinkLight,
                        fontBtn: 'lalezar',
                        fontSizeBtn: 22,
                        shadowColor: kPurpleDark,
                        onTapped: () async {
                          Get.toNamed(AppRoutes.invDet,
                              arguments: {'invoice': invoice, 'user': user});
                        },
                        splashColor: kPinkLight,
                        borderColor: kPinkLight,
                        widthBtn: 110,
                        heightBtn: 45,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          dialogCustom(
                              'آیا از حذف این فاکتور اطمینان دارید؟', 20,
                              () async {
                            Get.back();
                            var result =
                                await controller.deleteInvoice(invoice.id!);
                            if (result == 1) {
                              FocusScope.of(context).unfocus();
                              Future.delayed(
                                  const Duration(milliseconds: 2500), () {
                                Get.off(
                                  () => AdminHomeScreen(),
                                  arguments: user,
                                  // صفحه مقصد
                                  transition: Transition.zoom,
                                  // نوع انیمیشن
                                  duration: const Duration(
                                      milliseconds: 500), // مدت زمان انیمیشن
                                );
                              });
                            }
                          });
                        },
                        child: const Icon(
                          Icons.delete_outline_outlined,
                          size: 36,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainWidget(BuildContext context, Widget child) {
    return BaseWidget(
        bottomNavigation: null,
        onPressed: () {
          Get.toNamed(AppRoutes.adminHome, arguments: user);
        },
        appBar: null,
        child:
        contentBaseWidget('  فاکتورها ', Icons.delete_outline_rounded, () {
          dialogCustom(
              'آیا از حذف همه فاکتورها و سفارشات اطمینان دارید؟',
              20, () async {
            Get.back();
            var result = await controller.deleteInvoices();
            if (result != 0) {
              FocusScope.of(context).unfocus();
              Future.delayed(const Duration(milliseconds: 2500),
                      () {
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
        }, child)
    );
  }
}
