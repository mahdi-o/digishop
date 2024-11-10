import 'dart:math';

import 'package:digishop/constans.dart';
import 'package:digishop/controller/mysearch_controller.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/Product.dart';

class SearchScreen extends GetView<MySearchController> {
   SearchScreen({super.key});
RxBool heartStatus = false.obs;
Random random = Random();
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> BaseWidget(color: Colors.white,
          bottomNavigation: null,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Center(
                child: Padding(
              padding: EdgeInsets.only(left: 50.0, top: 10),
              child: Text('جستجو محصولات', style: TextStyle(color: Colors.black,fontSize: 25)),
            )),
            leading: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SingleChildScrollView(
              child: SizedBox(
                height: 760,
                child:
                      Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30, top: 10),
                        child: Container(
                          width: 400,
                          height: 55,
                          decoration: BoxDecoration(
                              color: kPurpleLight,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey)),
                          child: TextField(
                            autofocus: true,
                            controller: controller.text,
                            style: TextStyle(
                              color: Colors.black,
                              decorationColor: Colors.grey.shade100,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'جستجو',
                              hintStyle: TextStyle(color: Colors.grey.shade600,fontSize: 20),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              prefixIcon: IconButton(
                                  onPressed: () {
                                    controller
                                        .searching(controller.text.text.trim());
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  icon: Icon(
                                    Icons.search_rounded,
                                    color: Colors.grey.shade600,
                                    size: 27,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      controller.listSearch.isEmpty
                          ? controller.listSearch.isEmpty &&
                                  controller.text.text.isNotEmpty
                              ? Expanded(
                                  child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 120.0),
                                        child: Text(
                                  'محصولی یافت نشد!',
                                  style: TextStyle(color: Colors.grey.shade600,fontSize: 30),
                                ),
                                      )))
                              : Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 120.0),
                                      child: Text(
                                        'برای پیدا کردن محصول موردنظرتان جست و جو کنید',
                                        style:
                                            TextStyle(color: Colors.grey.shade600,fontSize: 20),
                                      ),
                                    ),
                                  ),
                                )
                          : Expanded(
                              child: SizedBox(
                                height: Get.height,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.listSearch.length,
                                  itemBuilder: (context, index) {
                                    Product product =
                                        controller.listSearch[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 170,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: kPurple,
                                                  borderRadius:
                                                      BorderRadius.circular(150)),
                                              child:  product.imageAddress != ''
                                                  ? Image.asset(
                                                product.imageAddress.toString(),
                                                width: 150,
                                              )
                                                  :  CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/images/slider${random.nextInt(7)+1}.jpg'),
                                                radius: 70,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 60,
                                                  width: 230,
                                                  child: Text(
                                                    product.nameProduct.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 10.0),
                                                  child: Text(
                                                    '${separateDigits(int.parse(product.price.toString()))} تومان',
                                                    style: TextStyle(
                                                        fontFamily: 'Titr',
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: kPinkDark
                                                            .withOpacity(0.7)),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: kPurpleDark),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: kPurpleLight),
                                                      width: 110,
                                                      height: 35,
                                                      child: Center(
                                                          child: GestureDetector(
                                                        onTap: () {
                                                          Get.toNamed(
                                                              AppRoutes.proDet,
                                                              arguments: product);
                                                        },
                                                        child: const Text(
                                                          'جزئیات',
                                                          style: TextStyle(
                                                              fontFamily: 'lalezarPlus',
                                                              fontSize: 16),
                                                        ),
                                                      )),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),

                                                              GestureDetector(
                                                        onTap: (){
                                                          if(heartStatus.value==false){
                                                            heartStatus.value=true;
                                                          }else{
                                                            heartStatus.value=false;
                                                          }
                                                        },
                                                        child: heartStatus.value == false ? const Icon(
                                                          CupertinoIcons.heart,color: kPurpleDark,size: 27,
                                                        ):const Icon(
                                                          CupertinoIcons.heart_fill,color: kPinkDark,size: 27,
                                                        ),
                                                      ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),

              ),
            ),
          )),
    );
  }
}
