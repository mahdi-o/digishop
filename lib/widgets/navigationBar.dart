import 'package:digishop/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
   return BottomNavigationBar(
        fixedColor: kPinkDark,
        backgroundColor: kPurple,
        currentIndex: 2,
        iconSize: 35,
        unselectedItemColor: kPurpleDark,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              label: 'cart'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_rounded,
              ),label: 'person'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.suit_heart,
              ),label: 'heart'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
              ),label: 'home'
          ),
        ]);











    // return Center(
    //   child: Padding(
    //     padding: const EdgeInsets.only(top: 790),
    //     child: Container(
    //       width: 370,
    //       height: 60,
    //       decoration: BoxDecoration(
    //           color: kPurple, borderRadius: BorderRadius.circular(50)),
    //       child: const Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Icon(
    //             Icons.shopping_cart_outlined,
    //             size: 30,
    //             color: Colors.black,
    //           ),
    //           Icon(
    //             Icons.person_outline_rounded,
    //             size: 30,
    //             color: Colors.black,
    //           ),
    //           Icon(
    //             CupertinoIcons.suit_heart,
    //             size: 30,
    //             color: Colors.black,
    //           ),
    //           Icon(
    //             Icons.home_rounded,
    //             size: 30,
    //             color: Colors.black,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
