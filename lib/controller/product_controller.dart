import 'package:digishop/constans.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/services/routes.dart';
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

  productBrand(context, String nameBrand,String nameUser) {
    if(nameBrand != 'all'){
      listLaptop.clear();
    }
    for (int i = 0; i < listProductsDb.length; i++) {
      if (listProductsDb[i].brand == nameBrand) {
        listLaptop.add(listProductsDb[i]);
      }
      else if (nameBrand == 'all') {
        listLaptop = listProductsDb;
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        height: Get.height,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 80),
          scrollDirection: Axis.vertical,
          itemCount: listLaptop.length,
          itemBuilder: (context, index) {
            Product product = listLaptop[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 170,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: kPurple,
                          borderRadius: BorderRadius.circular(150)),
                      child: Image.asset(product.imageAddress.toString(), width: 150,),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 230,
                          child: Text(
                            product.nameProduct.toString()
                            , style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: Text(
                            '${separateDigits(int.parse(product.price.toString()))} تومان',
                            style: TextStyle(
                                fontFamily: 'Titr',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPinkDark.withOpacity(0.7)),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: kPurpleDark),
                                  borderRadius: BorderRadius.circular(50),
                                  color: kPurpleLight),
                              width: 110,
                              height: 35,
                              child:Center(
                                  child: GestureDetector(
                                    onTap: (){
                                      Get.toNamed(AppRoutes.proDet,arguments: product,parameters: {'username':nameUser});
                                    },
                                    child: const Text(
                                      'جزئیات',
                                      style:
                                      TextStyle(fontFamily: 'Titr', fontSize: 15),
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 20,),
                            const Icon(
                              CupertinoIcons.heart,
                              color: kPurpleDark,
                              size: 27,
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
    );
  }

  // ehtemalan bayad hazf beshe in function
  Future<List<Product>>getListProduct()async{
    listProductsDb.value.clear();
    listProductsDb.value = await MyDb().getProduct();
    return listProductsDb.value;
    print('list product por shod dar product controller');
    print(listProductsDb.length);
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
