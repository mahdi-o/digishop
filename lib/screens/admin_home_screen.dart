import 'package:digishop/constans.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/container_custom_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});

  final String user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    String username = user;
    return BaseWidget(
      color: Colors.grey.shade300.withOpacity(0.1),
      appBar: null,
      bottomNavigation: null,
      child: AdminBaseWidget(
        height: 280,
        color: Colors.grey.shade300,
        childWidget: Padding(
          padding:
          const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 65),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'مدیریت فروشگاه',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: const Center(
                                child: Text(
                                  'دیجی‌شاپ',
                                  style: TextStyle(color: Colors.white, fontSize: 28),
                                )),
                          ),
                          SizedBox(width: 15,),
                          Icon(Icons.webhook_rounded,color: Colors.white,size: 35,)
                        ],
                          // CupertinoIcons.wrench_fill
                          // Icons.webhook_rounded
                          // CupertinoIcons.bolt_horizontal_circle
                      ),
                    ],
                  ),
                  // Image.asset(
                  //   'assets/images/administrator-b.png',
                  //   width: 80,
                  // ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: Get.width,
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 4.0, left: 4, top: 15, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 160,
                            height: 95,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(23)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text('تعداد فروش روز',
                                      style: TextStyle(
                                          fontSize: 20, color: kPurpleDark)),
                                ),
                                Text(
                                  '55',
                                  style: TextStyle(
                                      fontSize: 30, color: kPinkLight),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 160,
                            height: 95,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(23)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text('تعداد فاکتور',
                                      style: TextStyle(
                                          fontSize: 20, color: kPinkLight)),
                                ),
                                Text(
                                  '25',
                                  style: TextStyle(
                                      fontSize: 30, color: kPurpleDark),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 4.0, left: 4, top: 4, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 160,
                            height: 95,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(23)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text('تعداد کالا',
                                      style: TextStyle(
                                          fontSize: 20, color: kPinkLight)),
                                ),
                                Text(
                                  '100',
                                  style: TextStyle(
                                      fontSize: 30, color: kPurpleDark),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 160,
                            height: 95,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(23)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text('تعداد مشتریان',
                                      style: TextStyle(
                                          fontSize: 20, color: kPurpleDark)),
                                ),
                                Text(
                                  '70',
                                  style: TextStyle(
                                      fontSize: 30, color: kPinkLight),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContainerCustomAdmin(
                          text: 'افزودن مشتری',
                          icon: Icons.person_add_alt_1_outlined,
                          textColor: Colors.black,
                          iconColor: kPurpleDark,
                          voidCallback: () {
                            Get.toNamed(AppRoutes.adminCusCre);
                          }),
                      ContainerCustomAdmin(
                          text: 'مشتریان',
                          icon: CupertinoIcons.person_2,
                          textColor: kPurpleDark,
                          iconColor: Colors.black,
                          voidCallback: () {
                            Get.toNamed(AppRoutes.showAllCus,
                                arguments: 'all',
                                parameters: {'username': username});
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContainerCustomAdmin(
                          text: 'ثبت فاکتور',
                          icon: Icons.add_chart_outlined,
                          textColor: kPurpleDark,
                          iconColor: Colors.black,
                          voidCallback: () {
                            Get.toNamed(AppRoutes.adminInvCre);
                          }),
                      ContainerCustomAdmin(
                          text: 'فاکتورها',
                          icon: Icons.inventory_2_outlined,
                          textColor: Colors.black,
                          iconColor: kPurpleDark,
                          voidCallback: () {
                            Get.toNamed(AppRoutes.showAllInv,
                                arguments: 'all',
                                parameters: {'username': username});
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ContainerCustomAdmin(text: 'افزودن محصول',
                          icon: Icons.add_shopping_cart_outlined,
                          textColor
                              :Colors.black,
                          iconColor
                              :kPurpleDark,
                          voidCallback: () { Get.toNamed(AppRoutes.adminProCre);}),
                      ContainerCustomAdmin(text: 'محصولات',
                          icon: Icons.dataset_outlined,
                          textColor
                              :kPurpleDark,
                          iconColor
                              :Colors.black,
                          voidCallback: () { Get.toNamed(AppRoutes.showAllPro,
                              arguments: 'all',
                              parameters: {'username': username});}),
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
}
