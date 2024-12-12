import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySearchController extends GetxController{
  ProductController proController = Get.find<ProductController>();

  TextEditingController text = TextEditingController();
  RxList<Product> listSearch = <Product>[].obs;
  RxList<Product> listProductsDbForSearch = <Product>[].obs;

  searching(String textSearch)async{
    if(text.text.isEmpty){
      return Get.snackbar('', '',
          titleText: const Text(
            'خطا',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          messageText: const Text(
            'متنی برای جست و جو وارد نشده است!',
            style: TextStyle(color: Colors.white,fontSize: 18),
          ),
          duration: const Duration(milliseconds: 1500),
          backgroundColor: kRedLight,
          padding:
          const EdgeInsets.only(left: 30, right: 10, top: 15, bottom: 15),
          icon: const Icon(
            Icons.highlight_off,
            color: Colors.white,
            size: 35,
          ));
    }
    else {
      listProductsDbForSearch.clear();
      listProductsDbForSearch.value = await proController.getProducts();
      listSearch.clear();
      for(var item in listProductsDbForSearch){
        String textSearch = text.text.removeAllWhitespace.trim();
        if(item.nameProduct!.contains(textSearch)){
          listSearch.add(item);
        }
      }
    }
     text.clear();
  }

  Future<void> clear()async{
     listSearch.clear();
  }

}