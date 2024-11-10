import 'package:digishop/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoxRowProduct extends StatelessWidget {
  BoxRowProduct(
      {super.key,
      required this.name,
      required this.price,
      required this.image});

  final String name, price, image;
  RxBool heartStatus = false.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: Container(
        height: 360,
        width: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
              ),
              child: CircleAvatar(
                radius: 90,
                backgroundColor: kPurple.withOpacity(0.6),
                child: Image.asset(
                  image,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: 180,
                    child: Text(
                      name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 55.0, top: 10),
                    child: Row(
                      children: [
                        Text(
                          separateDigits(int.parse(price)),
                          style: TextStyle(
                              fontFamily: 'Titr',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kPinkDark.withOpacity(0.7)),
                        ),
                        Text(
                          ' تومان',
                          style: TextStyle(
                              fontFamily: 'Titr',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kPinkDark.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: kPurpleDark),
                            borderRadius: BorderRadius.circular(50),
                            color: kPurpleLight),
                        width: 110,
                        height: 35,
                        child: const Center(
                            child: Text(
                          'جزئیات',
                          style: TextStyle(fontFamily: 'Titr', fontSize: 15),
                        )),
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            if (heartStatus.value == false) {
                              heartStatus.value = true;
                            } else {
                              heartStatus.value = false;
                            }
                          },
                          child: heartStatus.value == false
                              ? const Icon(
                                  CupertinoIcons.heart,
                                  color: kPurpleDark,
                                  size: 27,
                                )
                              : const Icon(
                                  CupertinoIcons.heart_fill,
                                  color: kPinkDark,
                                  size: 27,
                                ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
