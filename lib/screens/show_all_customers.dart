import 'package:digishop/constans.dart';
import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/models/Customer.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../services/routes.dart';
import 'admin_home_screen.dart';

class ShowAllCustomers extends GetView<CustomerController> {
  ShowAllCustomers({super.key});
  final User user = Get.arguments;
  final RxList<Customer> customers = <Customer>[].obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Customer>>(
      future: controller.getCustomers(), // متد بارگذاری مشتریان از دیتابیس
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return mainWidget(
              context, const CircularProgressIndicator()); // نمایش لودینگ
        } else if (snapshot.hasError) {
          return mainWidget(
            context,
            Center(
              child: Padding(
                padding:  EdgeInsets.only(bottom: Get.height/18),
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
                padding:  EdgeInsets.only(bottom: Get.height/18),
                child: Text(
                  'مشتری یافت نشد!',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 30),
                ),
              ),
            ),
          );
        }
        for (var item in snapshot.data!) {
            // چک کردن وجود مشتری در لیست قبل از اضافه کردن آن
            if (!customers.any((existingItem) =>
            existingItem.nameCustomer == item.nameCustomer)) {
              customers.add(item);
            }

        }
         // customers.value = snapshot.data!;

        return mainWidget(
          context,
                    ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    return Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildAvatar(),
                              const SizedBox(width: 10),
                              _buildCustomerInfo(customer, context),
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
        );
      },
    );
  }

  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        color: kPurple,
        borderRadius: BorderRadius.circular(150),
      ),
      child: const CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/images/user3.png'),
        radius: 50,
      ),
    );
  }

  Widget _buildCustomerInfo(Customer customer, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
          width: 200,
          child: Center(
            child: Text(
              customer.nameCustomer ?? '',
              style: const TextStyle(fontSize: 22),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Text(
          customer.username ?? '',
          style: TextStyle(
            fontFamily: 'Titr',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kPinkDark.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Get.toNamed(
                  AppRoutes.adminCusUpd,
                  arguments: {
                    'customer':customer,
                    'user':user
                  }
                );
              },
              icon: const Icon(Icons.edit_rounded, color: kPurpleDark),
            ),
            const SizedBox(width: 5),
            _buildDetailsButton(customer),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                dialogCustom('آیا از حذف این مشتری اطمینان دارید؟', 20, ()async{
                  Get.back();
                  var result = await controller.deleteCustomer(customer.id ?? -1);
                  if (result == 1) {
                    FocusScope.of(context).unfocus();
                    controller.clear();

                    Future.delayed(const Duration(milliseconds: 2500), () {
                      Get.off(
                        () => AdminHomeScreen(), arguments: user,
                        // صفحه مقصد
                        transition: Transition.zoom,
                        // نوع انیمیشن
                        duration: const Duration(
                            milliseconds: 500), // مدت زمان انیمیشن
                      );
                    });
                  }
                });
              },
              child: const Icon(
                Icons.delete_outline_rounded,
                size: 35,
                color: kPurpleDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget mainWidget(BuildContext context, Widget child) {
    return BaseWidget(
        bottomNavigation: null,
        onPressed: (){Get.toNamed(AppRoutes.adminHome,arguments: user);},
        appBar: null,
        child: contentBaseWidget('  مشتریان ', Icons.delete_outline_rounded,  ()  {
          dialogCustom('آیا از حذف تمام مشتریان اطمینان دارید؟', 20,
                  () async{
                Get.back();
                var result =await controller.deleteCustomers();
                if(result != 0){
                  FocusScope.of(context).unfocus();
                  Future.delayed(const Duration(milliseconds: 2500), () {
                    Get.off(
                          () => AdminHomeScreen(), arguments: user,
                      // صفحه مقصد
                      transition: Transition.rightToLeft,
                      // نوع انیمیشن
                      duration: const Duration(
                          milliseconds: 500), // مدت زمان انیمیشن
                    );
                  });
                }
              });
        }, child)
    );
  }

  Widget _buildDetailsButton(Customer customer) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kPurpleDark),
        borderRadius: BorderRadius.circular(50),
        color: kPurpleLight,
      ),
      width: 110,
      height: 35,
      child: Center(
        child: GestureDetector(
          onTap: (){
            Get.toNamed(
                AppRoutes.cusDet,
                arguments: {'customer':customer, 'user':user});
          }, // Add your navigation action here.
          child: const Text(
            'جزئیات',
            style: TextStyle(fontFamily: 'lalezarPlus', fontSize: 18),
          ),
        ),
      ),
    );
  }
}
