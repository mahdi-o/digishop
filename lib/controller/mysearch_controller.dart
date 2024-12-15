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
      mySnackBar(false, true, 'متنی برای جست و جو وارد نشده است!');
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