import 'package:carousel_slider/carousel_slider.dart';
import 'package:digishop/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSlider extends GetView<HomeController> {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
            ()=> Stack(children: [
          CarouselSlider(
            items: controller.listSliderImage,
            carouselController: controller.controllerCarouser.value,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 1.8,
                autoPlayCurve: Curves.linear,
                height: 200,
                pageSnapping: true
                // onPageChanged: controller.onChangeSlide
            ),
          ),
        ],)
    );
  }
}
