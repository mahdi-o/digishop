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

class AdminInvoiceCreate extends GetView<InvoiceController> {
   AdminInvoiceCreate({super.key});
  final User user = Get.arguments;
   final xController = Get.find<MyDb>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseWidget(
        appBar: null,
        bottomNavigation: null,
        floatingLocation: FloatingActionButtonLocation.startFloat,
        floating: FloatingActionButton(
          onPressed: () {
            controller.clear();
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
          height: 380,
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
                        EdgeInsets.only(right: 135, left: 10),
                        child: Column(
                          children: [
                            // ویجت NavbarCustom ثابت
                            SizedBox(
                              height: 50, // ارتفاع ثابت برای هدر
                              child: NavbarCustom(
                                text1: '',
                                text2: 'ثبت فاکتور جدید',
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
                              horizontal: 100.0, vertical: 15),
                          child: DropdownButtonHideUnderline(
                            child: Obx(()=> DropdownButton2<String>(
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
                                items: controller.listIdCustomers.toSet()
                                    .map((customer) => DropdownMenuItem<String>(
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
                                ).toList(),
                                value: controller.listIdCustomers.contains(
                                    controller.selectedValueCus?.value)
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
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: DropdownButtonHideUnderline(
                        child: Obx(()=> DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Text(
                              'نام محصول',
                              style: TextStyle(
                                fontFamily: 'lalezarPlus',
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                            items: controller.listIdProducts.toSet()
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
                            ),).toList(),
                            value:controller.listIdProducts.contains(
                                controller.selectedValuePro?.value)
                                ? controller.selectedValuePro?.value
                                :null,
                            onChanged: (value) {
                              if (controller.listIdProducts.contains(value)) {
                                controller.selectedValuePro?.value = value ?? '';
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
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 43),
                  const Text(
                    'سفارشات موجود در فاکتور',
                    style: TextStyle(fontSize: 20, color: kPurpleDark),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      height: Get.width / 2,
                      child: controller.listOrder.isEmpty
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 50.0),
                                    child: Text(
                                      'در حال حاضر سفارشی برای ثبت موجود نیست!',
                                      style: TextStyle(
                                          fontSize: 20, color: kRedLight),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          :
                      Obx(
                              () => ListView.builder(
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
                                                    order.nameProduct ?? '',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 20),
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
                                              const SizedBox(width: 20),
                                              Column(
                                                children: [
                                                  const Text('قیمت فی'),
                                                  Text(
                                                    '${separateDigits(int.parse(order.unitPrice.toString()))} ت',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 20),
                                              Column(
                                                children: [
                                                  const Text('قیمت کل'),
                                                  Text(
                                                    '${separateDigits(int.parse(order.totalPrice.toString()))} ت',
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Icon(
                                                    Icons
                                                        .delete_forever_outlined,
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
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: CustomButton(
                      colorBtn: Colors.white,
                      textBtn: 'ثبت فاکتور',
                      textColor: kPurpleDark,
                      fontBtn: 'lalezar',
                      fontSizeBtn: 26,
                      shadowColor: kPurpleDark,
                      onTapped: () async {
                        if (controller.idCustomer.value.text != "" &&
                            controller.listOrder.isNotEmpty) {
                          await controller.addInvoice();
                        } else {
                          Get.snackbar(
                            'خطا',
                            'اطلاعات وارد شده صحیح نمی‌باشد!',
                            backgroundColor: kRedLight,
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


