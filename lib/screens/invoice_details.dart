import 'package:digishop/constans.dart';
import 'package:digishop/models/Invoice.dart';
import 'package:digishop/models/invoiceProducts.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/row_details_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/basket_controller.dart';
import '../controller/invoice_controller.dart';
import '../database/my_db.dart';
import '../models/Product.dart';
import '../models/User.dart';
import '../services/routes.dart';
import '../widgets/navbar_custom.dart';

class InvoiceDetails extends GetView<InvoiceController> {
  InvoiceDetails({super.key});

  final Invoice invoice = Get.arguments['invoice'];
  final User user = Get.arguments['user'];
  MyDb xController = Get.find<MyDb>();
  RxList listInvoiceProduct = [].obs;
  BasketController basket = BasketController();

  @override
  Widget build(BuildContext context) {
    print(invoice.id);
    print('LPLPLPLPLPLPLPLPLP');
    onInit();

    return BaseWidget(
      color: Colors.white,
      bottomNavigation: null,
      appBar: null,
      floatingLocation: FloatingActionButtonLocation.startFloat,
      floating: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.showAllInv,arguments:user);
        },
        elevation: 20,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_sharp,
          size: 33,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.only(
                  right: 130, left: 0, top: 50),
              child: Column(
                children: [
                  // ویجت NavbarCustom ثابت
                  SizedBox(
                    height: 60, // ارتفاع ثابت برای هدر
                    child: GestureDetector(
                      onTap: () async {
                        print(invoice.id);
                        var res = await xController.readInvoiceProduct(invoice.id);
                        print(res.first.idInvoice);
                      },
                      child: const NavbarCustom(
                        text1: 'مشخصات فاکتور',
                        text2: '',
                        size1: 28,
                        size2: 26,
                        fontFace1: 'lalezarPlus',
                        fontFace2: 'lalezarPlus',
                        icon1: null,
                        icon2: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const Divider(
                        endIndent: 0.9,
                        indent: 0.2,
                        thickness: 0.4,
                        color: Colors.grey,
                        height: 1.5),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: Center(
                            child: Text(
                              'شماره فاکتور:  ${invoice.id.toString()}',
                              style: const TextStyle(
                                  fontSize: 32, color: kPinkDark),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        RowDetailsModels(
                            typeRow: 'product',
                            title: 'نام مشتری',
                            body: invoice.nameCustomer.toString()),
                        RowDetailsModels(
                            typeRow: 'product',
                            title: 'نوع پرداخت',
                            body: invoice.typePay.toString()),
                        RowDetailsModels(
                            typeRow: 'product',
                            title: 'مقدار تخفیف',
                            body: invoice.discount!.isEmpty
                                ? '0'
                                : invoice.discount.toString()),
                        RowDetailsModels(
                            typeRow: 'product',
                            title: 'وضعیت پرداخت',
                            body: invoice.isPaying == 0
                                ? 'پرداخت نشده'
                                : 'پرداخت شده'),
                        RowDetailsModels(
                            typeRow: 'product',
                            title: 'تاریخ ثبت',
                            body:
                            invoice.createdAt.toString().substring(0, 11)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  child: const Text(
                    'سفارشات موجود در فاکتور',
                    style: TextStyle(
                      fontSize: 26,color: kPurpleDark,
                    ),
                  ),
                ),
              )),
          Expanded(
            flex: 4,
            child: Obx(
                  () => ListView.builder(
                itemCount: listInvoiceProduct.length,
                itemBuilder: (context, index) {
                  InvoiceProducts invoicePro = listInvoiceProduct[index];
                  Product product = xController.productList
                      .where((p0) => p0.id == invoicePro.idProduct)
                      .first;
                    print(invoice.id);
                    print('00000000000000000000000000000000');
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          colors: [kBlueLight, kPinkLight],
                          end: Alignment.bottomLeft,
                          begin: Alignment.topRight,
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  const Text('نام محصول'),
                                  Text(
                                    product.nameProduct ?? '',
                                    style:
                                    const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  const Text('تعداد'),
                                  Text(
                                    product.count.toString(),
                                    style:
                                    const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  const Text(' سفارش تعداد'),
                                  Text(
                                    invoicePro.count.toString(),
                                    style:
                                    const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  const Text('قیمت فی'),
                                  Text(
                                    '${separateDigits(int.parse(product.price.toString()))} ت',
                                    style:
                                    const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Column(
                                children: [
                                  const Text('قیمت کل'),
                                  Text(
                                    '${separateDigits(int.parse(product.price.toString()))} ت',
                                    style:
                                    const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  // await controller.deleteOrder(
                                  //         order.id!);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
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
        ],
      ),
    );
  }

  onInit() async {
    listInvoiceProduct.clear();
    var res = await xController.readInvoiceProduct(invoice.id);
    print(invoice.id);
    print('=111111111111111111============');
    for (var item in res) {
      print('JJJJJJJJJJJJJJJJJJJJJJJ');
      listInvoiceProduct.add(item);
      print(item.idProduct);
    }
    print('[[[[[[[[[[[[[object]]]]]]]]]]]]]');
  }
}