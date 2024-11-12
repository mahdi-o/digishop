import 'package:digishop/controller/invoice_controller.dart';
import 'package:digishop/models/Invoice.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constans.dart';
import '../database/my_db.dart';
import '../widgets/base_widget.dart';

class ShowAllInvoices extends GetView<InvoiceController> {
  ShowAllInvoices({super.key});

  String mapData = Get.parameters['username']!;
  MyDb myDb = Get.find<MyDb>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseWidget(
        color: Colors.white,
        bottomNavigation: null,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          centerTitle: true,
          title: const Text(
            'فاکتورها',
            style: TextStyle(
                fontFamily: 'lalezar', color: Colors.black, fontSize: 26),
          ),
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
        // controller.productBrand(context, argument,mapData),

        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: Get.height,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 80),
              scrollDirection: Axis.vertical,
              itemCount: controller.listInvoicesDb.length,
              itemBuilder: (context, index) {
                Invoice invoice = controller.listInvoicesDb[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 270,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: kPurpleDark),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      ' نام مشتری : ${invoice.nameCustomer.toString()} ',
                                      style: const TextStyle(
                                          fontFamily: 'lalezar',
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ' آِیدی فاکتور : ${invoice.id.toString()} ',
                                      style: const TextStyle(
                                          fontFamily: 'lalezar',
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ' نوع پرداخت : ${invoice.typePay.toString()} ',
                                      style: const TextStyle(
                                          fontFamily: 'lalezar',
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          ' مقدار تخفیف : ${invoice.discount.toString()} ',
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
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    CustomButton(
                                      colorBtn: Colors.white,
                                      textBtn: 'پرداخت شد',
                                      textColor: kPurpleDark,
                                      fontBtn: 'lalezar',
                                      fontSizeBtn: 22,
                                      shadowColor: kPurpleDark,
                                      onTapped: () async {},
                                      splashColor: kPurpleDark,
                                      borderColor: kPurpleDark,
                                      widthBtn: 160,
                                      heightBtn: 45,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CustomButton(
                                      colorBtn: Colors.white,
                                      textBtn: 'ویرایش',
                                      textColor: kPinkLight,
                                      fontBtn: 'lalezar',
                                      fontSizeBtn: 22,
                                      shadowColor: kPurpleDark,
                                      onTapped: () async {
                                        // print(await MyDb().readInvoiceProducts());
                                        print('readInvoices');
                                        print(await MyDb().readInvoices());
                                      },
                                      splashColor: kPinkLight,
                                      borderColor: kPinkLight,
                                      widthBtn: 110,
                                      heightBtn: 45,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
