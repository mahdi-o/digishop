import 'package:digishop/constans.dart';
import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Customer.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowAllCustomers extends GetView<CustomerController> {
  ShowAllCustomers({super.key});

  String argument = Get.arguments;
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
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
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
              itemCount: controller.listCustomersDb.length,
              itemBuilder: (context, index) {
                print(controller.listCustomersDb.length);
                Customer customer = controller.listCustomersDb[index];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kPurple,
                                  borderRadius: BorderRadius.circular(150)),
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('assets/images/user3.png'),
                                radius: 50,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 200,
                                child: Center(
                                  child: Text(
                                    customer.nameCustomer.toString(),
                                    style: const TextStyle(
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              Text(
                                customer.username.toString(),
                                style: TextStyle(
                                    fontFamily: 'Titr',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kPinkDark.withOpacity(0.7)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        // Get.toNamed(AppRoutes.adminProUpd,arguments: product);
                                      },
                                      icon: const Icon(Icons.edit_rounded,color: kPurpleDark,)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: kPurpleDark),
                                        borderRadius:
                                            BorderRadius.circular(50),
                                        color: kPurpleLight),
                                    width: 110,
                                    height: 35,
                                    child: Center(
                                        child: GestureDetector(
                                      onTap: () {
                                        // Get.toNamed(AppRoutes.proDet,arguments: product,parameters: {'username':nameUser});
                                      },
                                      child: const Text(
                                        'جزئیات',
                                        style: TextStyle(
                                            fontFamily: 'Titr', fontSize: 15),
                                      ),
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Icon(
                                    Icons.delete_outline_rounded,
                                    size: 35,
                                    color: kPurpleDark,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                          color: Colors.black26,
                          thickness: 0.7,
                          ),
                    ],
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
