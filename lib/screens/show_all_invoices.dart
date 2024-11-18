import 'package:digishop/controller/invoice_controller.dart';
import 'package:digishop/models/Invoice.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constans.dart';
import '../database/my_db.dart';
import '../widgets/base_widget.dart';

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
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: Get.height,
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
          ),

          // SingleChildScrollView(
          //   scrollDirection: Axis.vertical,
          //   child: SizedBox(
          //     height: Get.height,
          //     child:
          //     ListView.builder(
          //       physics: const BouncingScrollPhysics(),
          //       padding: const EdgeInsets.only(bottom: 80),
          //       itemCount: invoices.length,
          //       itemBuilder: (context, index) {
          //         final invoice = invoices[index];
          //         return Container(
          //           width: double.infinity,
          //           height: 160,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //           child: Column(
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   _buildInvoiceInfo(invoice),
          //                 ],
          //               ),
          //               const Divider(
          //                 color: Colors.black26,
          //                 thickness: 0.7,
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //
          //

          //  /*   ListView.builder(
          //       physics: const BouncingScrollPhysics(),
          //       padding: const EdgeInsets.only(bottom: 80),
          //       scrollDirection: Axis.vertical,
          //       itemCount: controller.listInvoicesDb.length,
          //       itemBuilder: (context, index) {
          //         Invoice invoice = controller.listInvoicesDb[index];
          //         return Padding(
          //           padding:
          //           const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //           child: Container(
          //             width: MediaQuery.of(context).size.width,
          //             height: 270,
          //             decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.circular(20)),
          //             child:
          //             Container(
          //               decoration: BoxDecoration(
          //                   border: Border.all(width: 2, color: kPurpleDark),
          //                   borderRadius: const BorderRadius.only(
          //                       topLeft: Radius.circular(30),
          //                       bottomRight: Radius.circular(30))),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(20.0),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Column(
          //                       children: [
          //                         Column(
          //                           children: [
          //                             Text(
          //                               ' نام مشتری : ${invoice.nameCustomer.toString()} ',
          //                               style: const TextStyle(
          //                                   fontFamily: 'lalezar',
          //                                   fontSize: 20,
          //                                   color: Colors.black),
          //                             ),
          //                             const SizedBox(
          //                               height: 10,
          //                             ),
          //                             Text(
          //                               ' آِیدی فاکتور : ${invoice.id.toString()} ',
          //                               style: const TextStyle(
          //                                   fontFamily: 'lalezar',
          //                                   fontSize: 20,
          //                                   color: Colors.black),
          //                             ),
          //                             const SizedBox(
          //                               height: 10,
          //                             ),
          //                             Text(
          //                               ' نوع پرداخت : ${invoice.typePay.toString()} ',
          //                               style: const TextStyle(
          //                                   fontFamily: 'lalezar',
          //                                   fontSize: 20,
          //                                   color: Colors.black),
          //                             ),
          //                             const SizedBox(
          //                               height: 10,
          //                             ),
          //                             Row(
          //                               children: [
          //                                 Text(
          //                                   ' مقدار تخفیف : ${invoice.discount.toString()} ',
          //                                   style: const TextStyle(
          //                                       fontFamily: 'lalezar',
          //                                       fontSize: 20,
          //                                       color: Colors.black),
          //                                 ),
          //                                 const SizedBox(
          //                                   width: 20,
          //                                 ),
          //                                 Text(
          //                                   ' پرداخت شده : ${invoice.isPaying == 0 ? 'خیر' : 'بله'} ',
          //                                   style: const TextStyle(
          //                                       fontFamily: 'lalezar',
          //                                       fontSize: 20,
          //                                       color: Colors.black),
          //                                 ),
          //                               ],
          //                             )
          //                           ],
          //                         ),
          //                         const SizedBox(
          //                           height: 20,
          //                         ),
          //                         Row(
          //                           children: [
          //                             CustomButton(
          //                               colorBtn: Colors.white,
          //                               textBtn: 'پرداخت شد',
          //                               textColor: kPurpleDark,
          //                               fontBtn: 'lalezar',
          //                               fontSizeBtn: 22,
          //                               shadowColor: kPurpleDark,
          //                               onTapped: () async {},
          //                               splashColor: kPurpleDark,
          //                               borderColor: kPurpleDark,
          //                               widthBtn: 160,
          //                               heightBtn: 45,
          //                             ),
          //                             const SizedBox(
          //                               width: 10,
          //                             ),
          //                             CustomButton(
          //                               colorBtn: Colors.white,
          //                               textBtn: 'ویرایش',
          //                               textColor: kPinkLight,
          //                               fontBtn: 'lalezar',
          //                               fontSizeBtn: 22,
          //                               shadowColor: kPurpleDark,
          //                               onTapped: () async {
          //                                 // print(await MyDb().readInvoiceProducts());
          //                                 print('readInvoices');
          //                                 print(await MyDb().readInvoices());
          //                               },
          //                               splashColor: kPinkLight,
          //                               borderColor: kPinkLight,
          //                               widthBtn: 110,
          //                               heightBtn: 45,
          //                             ),
          //                             const SizedBox(
          //                               width: 20,
          //                             ),
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //         */
          //
          //
          //
          //
          //   ),
          // ),


          // ListView.builder(
          //   physics: const BouncingScrollPhysics(),
          //   padding: const EdgeInsets.only(bottom: 80),
          //   itemCount: invoices.length,
          //   itemBuilder: (context, index) {
          //     final customer = invoices[index];
          //     return Container(
          //       width: double.infinity,
          //       height: 160,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       child: Column(
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               _buildAvatar(),
          //               const SizedBox(width: 10),
          //               _buildCustomerInfo(invoices),
          //             ],
          //           ),
          //           const Divider(
          //             color: Colors.black26,
          //             thickness: 0.7,
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),

        );
      },
    );


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

        child:  myDb.invoiceList.isEmpty?Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 120.0),
            child: Text(
              'فاکتوری یافت نشد!',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 30),
            ),
          ),
        ):
        SingleChildScrollView(
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
                                    const SizedBox(
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


  Widget _buildInvoiceInfo(Invoice invoice){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
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
                  const SizedBox(height: 2,),
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
                      const SizedBox(
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
        child: child);
  }

}
