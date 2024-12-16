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
        onPressed: () {
          controller.clear();
          Get.toNamed(AppRoutes.adminHome,arguments: user);
        },
        color: Colors.grey.shade300,
        child: AdminBaseWidget(
          height: 380,
          paddingRight: 135,
          textNavbar2: 'ثبت فاکتور جدید',
          onTapButton:  () async {
            if (controller.idCustomer.value.text != "" &&
                controller.listOrder.isNotEmpty) {
              await controller.addInvoice();
            } else {
              mySnackBar(false, true, 'اطلاعات وارد شده صحیح نمی‌باشد!');
            }
          },
          textBtn: 'ثبت فاکتور',
          child1:Padding(
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
          child2:Padding(
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
          child3:Padding(
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
          child4: const Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'سفارشات موجود در فاکتور',
              style: TextStyle(fontSize: 20, color: kPurpleDark),
            ),
          ),
          child5:SingleChildScrollView(
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
          child6:Container(),
          child7:Container(),
        ),
      ),
    );
  }
}


