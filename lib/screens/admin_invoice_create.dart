import 'dart:ffi';

import 'package:digishop/constans.dart';
import 'package:digishop/controller/invoice_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Invoice.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminInvoiceCreate extends StatefulWidget {
  const AdminInvoiceCreate({super.key});

  @override
  State<AdminInvoiceCreate> createState() => _AdminInvoiceCreateState();
}

class _AdminInvoiceCreateState extends State<AdminInvoiceCreate> {
  @override
  MyDb xController = Get.find<MyDb>();
  InvoiceController controller = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    Color myColor;
    return Obx(
      () => BaseWidget(
        appBar: null,
        bottomNavigation: null,
        color: Colors.grey.shade300,
        child: AdminBaseWidget(
          height: 380,
          childWidget: SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, left: 100),
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
                          Center(
                              child: GestureDetector(
                            onTap: () async {
                              // await MyDb().addTest();
                              await MyDb().deleteInvoiceProducts();
                              await MyDb().deleteInvoices();

                            },
                            child: const Text('ثبت فاکتور جدید',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                )),
                          )),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 30),
                      //   child:
                      //   textFieldCustom(
                      //       controller.idCustomer.value,
                      //       Colors.white,
                      //       Colors.white70,
                      //       Colors.white,
                      //       Colors.white24,
                      //       'نام مشتری',
                      //       20,
                      //       10,
                      //       TextAlign.center,
                      //       18),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 15),
                        child: Row(
                          children: [
                            Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  alignment: Alignment.center,
                                  hint: const Text(
                                    'نام مشتری',
                                    style: TextStyle(
                                      fontFamily: 'lalezarPlus',
                                      fontSize: 20,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  items: controller.addDividersAfterItemsCus(
                                      controller.listIdCustomers),
                                  value: controller.selectedValueCus,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      controller.selectedValueCus = value;
                                      controller.idCustomer.value.text = value!;
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.white24))),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    height: 60,
                                    width: 200,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            colors: [
                                              kBlueLight,
                                              kPurpleDark,
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    maxHeight: 250,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding: EdgeInsets.only(
                                      right: 50
                                       ),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Colors.white38,
                                    ),
                                    openMenuIcon: Icon(
                                      Icons.arrow_drop_up_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Text(
                              'نام محصول',
                              style: TextStyle(
                                fontFamily: 'lalezarPlus',
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                            items: controller.addDividersAfterItems(
                                controller.listIdProducts),
                            value: controller.selectedValue,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            onChanged: (value) {
                              setState(() {
                                controller.selectedValue = value;
                                controller.idProduct.value.text = value!;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: Colors.white24))),
                              padding:
                              EdgeInsets.symmetric(horizontal: 50),
                              height: 60,
                              width: 360,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              padding:
                              const EdgeInsets.symmetric(vertical: 0),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        kBlueLight,
                                        kPurpleDark,
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight),
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              maxHeight: 250,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.only(
                                  right: 20, left: 8, bottom: 0, top: 0),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.white38,
                              ),
                              openMenuIcon: Icon(
                                Icons.arrow_drop_up_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(children: [
                          Expanded(
                            flex: 5,
                            child: textFieldCustom(
                                controller.typePay.value,
                                Colors.white,
                                Colors.white70,
                                Colors.white,
                                Colors.white24,
                                'شیوه پرداخت',
                                10,
                                7,
                                TextAlign.center,
                                20),
                          ),
                          Expanded(
                            flex: 5,
                            child: textFieldCustom(
                                controller.count.value,
                                Colors.white,
                                Colors.white70,
                                Colors.white,
                                Colors.white24,
                                'تعداد',
                                25,
                                0,
                                TextAlign.center,
                                20),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: IconButton(
                                onPressed: () async {
                                  await controller.addOrder();
                                },
                                icon: const Icon(
                                  Icons.add_task_rounded,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  GestureDetector(
                    onTap: ()async{
                      var res = await MyDb().readInvoiceProducts();
                      // print(res);
                      // print(res.length);
                    },
                    child: const Text(
                      'سفارشات موجود در فاکتور',
                      style: TextStyle(fontSize: 20, color: kPurpleDark),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      height: Get.width / 2,
                      child: controller.listOrder.isEmpty
                          ?
                      const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(top: 50.0),
                                  child: Text(
                                    'در حال حاضر سفارشی برای ثبت موجود نیست!',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.pink),
                                  ),
                                ))
                              ],
                            )
                          : Obx(
                            ()=> ListView.builder(
                                itemCount: controller.listOrder.length,
                                itemBuilder: (context, index) {
                                  var order = controller.listOrder[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        gradient: const LinearGradient(
                                            colors: [
                                              kBlueLight,
                                              kPinkLight,
                                            ],
                                            end: Alignment.bottomLeft,
                                            begin: Alignment.topRight),
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
                                                  const Text(
                                                    'نام محصول',
                                                  ),
                                                  Text(
                                                    order.nameProduct??'',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                children: [
                                                  const Text('تعداد'),
                                                  Text(
                                                    order.countOrder.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                children: [
                                                  const Text('قیمت فی'),
                                                  Text(
                                                    '${separateDigits(int.parse(order.unitPrice.toString()))} ت',
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                children: [
                                                  const Text('قیمت کل'),
                                                  Text(
                                                    '${separateDigits(int.parse(order.totalPrice.toString()))} ت',
                                                    style: const TextStyle(color: Colors.white),
                                                  ),

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
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding:const EdgeInsets.only(right: 15.0),
                          child: TextButton.icon(
                            onPressed: ()async{
                              if(controller.isPay.value == 0){
                                controller.isPay.value = 1 ;
                              }
                              else{
                                controller.isPay.value=0;
                              }
                               var r =  await MyDb().readInvoiceProducts();
                              print(r);
                              print(r.length);
                            },
                            icon:controller.isPay.value==0? const Icon(Icons.radio_button_unchecked_rounded,color: kPinkDark):const Icon(Icons.check_circle_outline_rounded,color: kPinkDark),
                            label: const Text('پرداخت شده',style: TextStyle(color: kPurpleDark,fontSize: 18)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child:
                          TextField(
                            readOnly: true,
                            controller: controller.priceSum.value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 22),
                            decoration: const InputDecoration(
                                label: Center(child: Text('جمع کل')),
                                labelStyle: TextStyle(
                                  color: kPurpleDark,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: kPurpleDark)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kPurpleDark))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: CustomButton(
                      colorBtn: Colors.white,
                      textBtn: 'چاپ فاکتور',
                      textColor: kPurpleDark,
                      fontBtn: 'lalezarPlus',
                      fontSizeBtn: 26,
                      shadowColor: kPurpleDark,
                      onTapped: () async {
                          await controller.addInvoice();
                        var a = await MyDb().readInvoiceProducts();
                        print(a.length);
                        print('object');
                        for(var item in a){
                          print(item);
                        }
                        print('read Invoices');
                        var i = await MyDb().readInvoices();
                        print(i.length);
                        print(i);
                        await controller.readListOrder();
                        print(controller.listOrder.length);
                        print('listOrder.length');
                      },
                      splashColor: kPurpleDark,
                      borderColor: kPurpleDark,
                      widthBtn: 330,
                      heightBtn: 65,
                    ),
                  ),
                ],
              ),
            ),
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
