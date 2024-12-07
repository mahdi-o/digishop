import 'package:digishop/constans.dart';
import 'package:digishop/controller/invoice_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../services/routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/navbar_custom.dart';

class AdminInvoiceUpdate extends StatelessWidget {
   AdminInvoiceUpdate({super.key});
  final User user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    MyDb xController = Get.find<MyDb>();
    InvoiceController controller = Get.find<InvoiceController>();

    return Obx(
          () => BaseWidget(
        appBar: null,
        bottomNavigation: null,
        floatingLocation: FloatingActionButtonLocation.startFloat,
        floating: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.adminHome,arguments: user);
          },
          elevation: 20,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.arrow_back_sharp,
            size: 33,
          ),
        ),
        color: Colors.grey.shade300,
        child: AdminBaseWidget(
          height: 750,
          childWidget: SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Column(
                    children: [
                      const Padding(
                        padding:
                        EdgeInsets.only(right: 105, left: 10),
                        child: Column(
                          children: [
                            // ویجت NavbarCustom ثابت
                            SizedBox(
                              height: 50, // ارتفاع ثابت برای هدر
                              child: NavbarCustom(
                                text1: '',
                                text2: 'ویرایش اطلاعات فاکتور',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100.0,vertical: 10),
                        child:
                        DropdownButtonHideUnderline(
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
                            items: controller.listIdCustomers
                                .toSet()
                                .map(
                                  (customer) => DropdownMenuItem<String>(
                                value: customer,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Center(
                                    child: Text(
                                      customer,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'yekanBakh',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                                .toList(),
                            value: controller.listIdCustomers.contains(controller.selectedValueCus?.value)
                                ? controller.selectedValueCus?.value
                                : null,
                            onChanged: (value) {
                              if (controller.listIdCustomers.contains(value)){
                                controller.selectedValueCus?.value = value ?? '';
                                controller.idCustomer.value.text = value ?? '';
                              }
                            },
                            buttonStyleData: const ButtonStyleData(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 1, color: Colors.white24),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 60,
                              width: 200,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [kBlueLight, kPurpleDark],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              maxHeight: 250,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(vertical: 8.0), // فاصله بین آیتم‌ها
                              height: 50, // ارتفاع یکنواخت هر آیتم
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
                        // DropdownButtonHideUnderline(
                        //   child: DropdownButton2<String>(
                        //     isExpanded: true,
                        //     alignment: Alignment.center,
                        //     hint: const Text(
                        //       'نام مشتری',
                        //       style: TextStyle(
                        //         fontFamily: 'lalezarPlus',
                        //         fontSize: 20,
                        //         color: Colors.white70,
                        //       ),
                        //     ),
                        //     items: controller
                        //         .addDividersAfterItemsCus(
                        //             controller.listIdCustomers)
                        //         .toSet()
                        //         .toList(),
                        //     // حذف مقادیر تکراری
                        //     value: !controller.listIdCustomers.contains(controller.selectedValueCus?.value)
                        //         ? null
                        //         : controller.selectedValueCus?.value,style: const TextStyle(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        //     // اعتبارسنجی مقدار
                        //     onChanged: (value) {
                        //
                        //       if (controller.listIdCustomers
                        //           .contains(value)) {
                        //         controller.selectedValueCus?.value = value??'';
                        //         controller.idCustomer.value.text = value!;
                        //       }
                        //     },
                        //     buttonStyleData: const ButtonStyleData(
                        //       decoration: BoxDecoration(
                        //           border: Border(
                        //               bottom: BorderSide(
                        //                   width: 1,
                        //                   color: Colors.white24))),
                        //       padding:
                        //           EdgeInsets.symmetric(horizontal: 10),
                        //       height: 60,
                        //       width: 200,
                        //     ),
                        //     dropdownStyleData: DropdownStyleData(
                        //       decoration: BoxDecoration(
                        //         gradient: const LinearGradient(
                        //             colors: [kBlueLight, kPurpleDark],
                        //             begin: Alignment.bottomLeft,
                        //             end: Alignment.topRight),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       maxHeight: 250,
                        //     ),
                        //     iconStyleData: const IconStyleData(
                        //       icon: Icon(
                        //         Icons.arrow_drop_down_rounded,
                        //         color: Colors.white38,
                        //       ),
                        //       openMenuIcon: Icon(
                        //         Icons.arrow_drop_up_rounded,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        //   // DropdownButton2<String>(
                        //   //   isExpanded: true,
                        //   //   alignment: Alignment.center,
                        //   //   hint: const Text(
                        //   //     'نام مشتری',
                        //   //     style: TextStyle(
                        //   //       fontFamily: 'lalezarPlus',
                        //   //       fontSize: 20,
                        //   //       color: Colors.white70,
                        //   //     ),
                        //   //   ),
                        //   //   items: controller.addDividersAfterItemsCus(
                        //   //       controller.listIdCustomers),
                        //   //   value:
                        //   //       controller.selectedValueCus!.value.isEmpty
                        //   //           ? null
                        //   //           : controller.selectedValueCus!.value,
                        //   //   style: const TextStyle(
                        //   //     color: Colors.white,
                        //   //     fontWeight: FontWeight.bold,
                        //   //   ),
                        //   //   onChanged: (value) {
                        //   //     controller.selectedValueCus?.value =
                        //   //         value ?? '';
                        //   //     controller.idCustomer.value.text =
                        //   //         value ?? '';
                        //   //   },
                        //   //   buttonStyleData: const ButtonStyleData(
                        //   //     decoration: BoxDecoration(
                        //   //         border: Border(
                        //   //             bottom: BorderSide(
                        //   //                 width: 1,
                        //   //                 color: Colors.white24))),
                        //   //     padding:
                        //   //         EdgeInsets.symmetric(horizontal: 10),
                        //   //     height: 60,
                        //   //     width: 200,
                        //   //   ),
                        //   //   dropdownStyleData: DropdownStyleData(
                        //   //     padding:
                        //   //         const EdgeInsets.symmetric(vertical: 0),
                        //   //     decoration: BoxDecoration(
                        //   //       gradient: const LinearGradient(
                        //   //           colors: [kBlueLight, kPurpleDark],
                        //   //           begin: Alignment.bottomLeft,
                        //   //           end: Alignment.topRight),
                        //   //       borderRadius: BorderRadius.circular(10),
                        //   //     ),
                        //   //     maxHeight: 250,
                        //   //   ),
                        //   //   iconStyleData: const IconStyleData(
                        //   //     icon: Icon(
                        //   //       Icons.arrow_drop_down_rounded,
                        //   //       color: Colors.white38,
                        //   //     ),
                        //   //     openMenuIcon: Icon(
                        //   //       Icons.arrow_drop_up_rounded,
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //   ),
                        //   // ),
                        // ),
                      ),  // dropDown name Customer

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
                        child: Row(
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Center(
                                  child: const Text(
                                    'نام محصول',
                                    style: TextStyle(
                                      fontFamily: 'lalezarPlus',
                                      fontSize: 20,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                                items: controller.listIdProducts
                                    .toSet()
                                    .map((product) => DropdownMenuItem<String>(
                                  value: product,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Center(
                                      child: Text(
                                        product,
                                        style: const TextStyle(
                                          fontFamily: 'yekanBakh',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),)
                                    .toList(),
                                value: controller.listIdProducts.contains(controller.selectedValue?.value)
                                    ? controller.selectedValue?.value
                                    :null ,

                                onChanged: (value) {
                                  if (controller.listIdProducts.contains(value)) {
                                    controller.selectedValue?.value = value ?? '';
                                    controller.idProduct.value.text = value ?? '';
                                  }
                                },
                                buttonStyleData: const ButtonStyleData(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  height: 60,
                                  width: 360,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [kBlueLight, kPurpleDark],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  maxHeight: 250,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  height: 50,
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
                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton2<String>(
                            //     isExpanded: true,
                            //     hint: const Text(
                            //       'نام محصول',
                            //       style: TextStyle(
                            //         fontFamily: 'lalezarPlus',
                            //         fontSize: 20,
                            //         color: Colors.white70,
                            //       ),
                            //     ),
                            //     items: controller.addDividersAfterItems(
                            //         controller.listIdProducts),
                            //     value: controller.selectedValue!.value.isEmpty
                            //         ? null
                            //         : controller.selectedValue!.value,
                            //     style: const TextStyle(
                            //       fontFamily: 'yekanBakh',
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.white,
                            //       fontSize: 18
                            //     ),
                            //     onChanged: (value) {
                            //       controller.selectedValue?.value =
                            //           value ?? '';
                            //       controller.idProduct.value.text =
                            //           value ?? '';
                            //     },
                            //     buttonStyleData: const ButtonStyleData(
                            //       decoration: BoxDecoration(
                            //           border: Border(
                            //               bottom: BorderSide(
                            //                   width: 1,
                            //                   color: Colors.white24))),
                            //       padding:
                            //           EdgeInsets.symmetric(horizontal: 50),
                            //       height: 60,
                            //       width: 360,
                            //     ),
                            //     dropdownStyleData: DropdownStyleData(
                            //       decoration: BoxDecoration(
                            //         gradient: const LinearGradient(
                            //             colors: [kBlueLight, kPurpleDark],
                            //             begin: Alignment.bottomLeft,
                            //             end: Alignment.topRight),
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //       maxHeight: 250,
                            //     ),
                            //     iconStyleData: const IconStyleData(
                            //       icon: Icon(
                            //         Icons.arrow_drop_down_rounded,
                            //         color: Colors.white38,
                            //       ),
                            //       openMenuIcon: Icon(
                            //         Icons.arrow_drop_up_rounded,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ), // // dropDown name Product

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child:
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
                              21),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25,),
                        child:
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
                              21),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25,),
                        child:
                        Expanded(
                          flex: 5,
                          child: textFieldCustom(
                              controller.isPaying.value,
                              Colors.white,
                              Colors.white70,
                              Colors.white,
                              Colors.white24,
                              'وضعیت پرداخت',
                              10,
                              7,
                              TextAlign.center,
                              21),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25,),
                        child:
                        Expanded(
                          flex: 5,
                          child: textFieldCustom(
                              controller.isPaying.value,
                              Colors.white,
                              Colors.white70,
                              Colors.white,
                              Colors.white24,
                              'تاریخ ایجاد',
                              10,
                              7,
                              TextAlign.center,
                              21),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: CustomButton(
                      colorBtn: Colors.white,
                      textBtn: 'ویرایش فاکتور',
                      textColor: kPurpleDark,
                      fontBtn: 'lalezar',
                      fontSizeBtn: 26,
                      shadowColor: kPurpleDark,
                      onTapped: () async {
                        if (controller.idCustomer.value.text != "" &&
                            controller.listOrder.isNotEmpty) {
                          // var result = await controller.updateInvoice();
///////////////////////
                        //
                        //
                        //
                        //
                        //
                        //
                        //
                        } else {
                          Get.snackbar(
                            'خطا',
                            'اطلاعات وارد شده صحیح نمی‌باشد!',
                            backgroundColor: Colors.pink,
                            colorText: Colors.white,
                          );
                        }
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
