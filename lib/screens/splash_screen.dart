import 'package:digishop/constans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
  final controller = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: kPurpleDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(Icons.shop_2_rounded,color: Colors.white,size: 120,),
          ),
          Center(child: Text('DigiShop',style: TextStyle(
            fontSize: 60
                ,color: Colors.white
          ),))
        ],
      ),
    );
  }
}
