import 'package:digishop/controller/invoice_controller.dart';
import 'package:digishop/models/Invoice.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constans.dart';
import '../database/my_db.dart';
import '../services/routes.dart';
import '../widgets/base_widget.dart';
import '../widgets/navbar_custom.dart';

class ShowAllInvoices extends StatelessWidget {
  ShowAllInvoices({super.key});

  final String mapData = Get.parameters['username']!;
  final MyDb myDb = Get.find<MyDb>();
  final InvoiceController controller = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Invoice>>(
      future: controller.getListInvoice(), // متد بارگذاری فاکتورها از دیتابیس
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
                  'فاکتوری یافت نشد!',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 30),
                ),
              ),
            ),
          );
        }

        final invoices = snapshot.data!;

        return mainWidget(
          context,
          Padding(
            padding:
                const EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 60),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: Get.height,
                child: Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: NavbarCustom(
                        text1: '  فاکتورها ',
                        text2: '',
                        size1: 28,
                        size2: 26,
                        fontFace1: 'lalezarPlus',
                        fontFace2: 'lalezarPlus',
                        icon1: Icons.delete_outline_rounded,
                        onTapIcon2: () async {
                          dialogCustom(
                              'آیا از حذف همه فاکتورها و سفارشات اطمینان دارید؟',20,
                              () {
                            var result = MyDb().deleteInvoices;
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
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: invoices.length,
                        itemBuilder: (context, index) {
                          final invoice = invoices[index];
                          return _buildInvoiceInfo(invoice);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInvoiceInfo(Invoice invoice) {
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
                  ),
                  const SizedBox(
                    height: 2,
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
                        widthBtn: 150,
                        heightBtn: 45,
                      ),
                      const SizedBox(
                        width: 7,
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
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          var resultDelete = MyDb().deleteInvoice(invoice.id!);
                          print(resultDelete);
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
        color: Colors.white,
        bottomNavigation: null,
        floating: FloatingActionButton(
          onPressed: () {
            Get.back();
          },
          elevation: 20,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          child: const Icon(Icons.arrow_back_sharp,size: 33,),
        ),
        appBar: null,
        child: child);
  }
}
