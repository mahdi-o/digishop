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
                height: 200,
                pageSnapping: true
                // onPageChanged: controller.onChangeSlide
            ),
          ),
              // Container(
              //   padding: const EdgeInsets.only(top: 180),
              //   alignment: AlignmentDirectional.center,
              //   child:
              //   AnimatedSmoothIndicator(
              //     activeIndex: controller.current.value,
              //     count: controller.resListSlider.length,
              //     textDirection: TextDirection.ltr,
              //     onDotClicked: controller.onDotClick,
              //     effect: const ExpandingDotsEffect(
              //         spacing:  8.0,
              //         radius:  4.0,
              //         dotWidth:  10.0,
              //         dotHeight:  10.0,
              //         paintStyle:  PaintingStyle.fill,
              //         strokeWidth:  2,
              //         dotColor:  Colors.grey,
              //         activeDotColor:  Colors.white
              //     ),
              //   ),
              // ),
        ],)
    );
  }
}
