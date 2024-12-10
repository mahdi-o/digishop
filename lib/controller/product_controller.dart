import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  Rx<TextEditingController> nameProduct = TextEditingController().obs;
  Rx<TextEditingController> priceProduct = TextEditingController().obs;
  Rx<TextEditingController> brandProduct = TextEditingController().obs;
  Rx<TextEditingController> ramProduct =TextEditingController().obs;
  Rx<TextEditingController> hardProduct = TextEditingController().obs;
  Rx<TextEditingController> cpuProduct = TextEditingController().obs;
  Rx<TextEditingController> screenProduct = TextEditingController().obs;
  Rx<TextEditingController> countProduct = TextEditingController().obs;

  RxList<Product> listProductsDb = <Product>[].obs;
  List<Product> listLaptop = <Product>[];

  Future<List<Product>>getListProduct()async{
    listProductsDb.clear();
    listProductsDb.value = await MyDb().getProducts();
    return listProductsDb;
  }

  clear(){
    nameProduct.value.clear();
     priceProduct.value.clear();
     brandProduct.value.clear();
     ramProduct.value.clear();
     hardProduct.value.clear();
     cpuProduct.value.clear();
     screenProduct.value.clear();
     countProduct.value.clear();
  }

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListProduct();
  }
}
