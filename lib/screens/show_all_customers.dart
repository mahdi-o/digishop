import 'package:digishop/constans.dart';
import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Customer.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../services/routes.dart';
import '../widgets/navbar_custom.dart';

class ShowAllCustomers extends StatelessWidget {
  ShowAllCustomers({super.key});

  final User user = Get.arguments;
  final MyDb myDb = Get.find<MyDb>();
  final CustomerController controller = Get.find<CustomerController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Customer>>(
      future: controller.getListCustomer(), // متد بارگذاری مشتریان از دیتابیس
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
                  'مشتری یافت نشد!',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 30),
                ),
              ),
            ),
          );
        }

        final customers = snapshot.data!;

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
                        _buildCustomerInfo(customer,context),
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

  Widget _buildCustomerInfo(Customer customer,context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
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
                  arguments: customer,
                  parameters: {'username': user.username.toString()},
                );
              },
              icon: const Icon(Icons.edit_rounded, color: kPurpleDark),
            ),
            const SizedBox(width: 5),
            _buildDetailsButton(),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () async {
                dialogCustom(
                    'آیا از حذف تمام مشتریان اطمینان دارید؟',20,
                        () {
                      var result =  myDb.deleteCustomer(customer.id ?? -1);
                      print(result);
                      FocusScope.of(context).unfocus();
                      Get.back();
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
        color: Colors.white,
        bottomNavigation: null,
        floating:
        FloatingActionButton(
          onPressed: () {
            Get.back();
          },
          elevation: 20,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          child: const Icon(Icons.arrow_back_sharp, size: 33,),
        ),
        floatingLocation: FloatingActionButtonLocation.startFloat,
        appBar: null,
        child: Padding(
          padding: const EdgeInsets.only(
              right: 10, left: 10, bottom: 20, top: 50),
          child: Column(children: [
            SizedBox(height: 60,
              child: NavbarCustom(
                text1: '  مشتریان ',
                text2: '',
                size1: 28,
                size2: 26,
                fontFace1: 'lalezarPlus',
                fontFace2: 'lalezarPlus',
                icon1: Icons.delete_outline_rounded,
                onTapIcon2: () async {
                  dialogCustom(
                      'آیا از حذف تمام مشتریان اطمینان دارید؟',20,
                          () {
                            var result = MyDb().deleteCustomers();
                            print(result);
                            FocusScope.of(context).unfocus();
                            Get.back();
                      });
                },
                icon2: null,
              ),
            ),
            Expanded(child: child)
          ],),
        )
    );

  }

  Widget _buildDetailsButton() {
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
          onTap: null, // Add your navigation action here.
          child: const Text(
            'جزئیات',
            style: TextStyle(fontFamily: 'lalezarPlus', fontSize: 18),
          ),
        ),
      ),
    );
  }
}
