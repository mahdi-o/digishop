import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../constans.dart';

class ProductController extends GetxController {

  Rx<TextEditingController> nameProduct = TextEditingController().obs;
  Rx<TextEditingController> priceProduct = TextEditingController().obs;
  Rx<TextEditingController> brandProduct = TextEditingController().obs;
  Rx<TextEditingController> ramProduct =TextEditingController().obs;
  Rx<TextEditingController> hardProduct = TextEditingController().obs;
  Rx<TextEditingController> cpuProduct = TextEditingController().obs;
  Rx<TextEditingController> screenProduct = TextEditingController().obs;
  Rx<TextEditingController> countProduct = TextEditingController().obs;

  // use controller 'invoiceController'
  // use screen 'invoice details'
  // use file 'my_db' to function 'get product'
  RxList<Product> productList = <Product>[].obs;

  // use file 'my_db' to function 'getProductForInvoice'
  RxList<Product> productListForShowOrder = <Product>[].obs;

  // use file 'my_db' to function 'getProductFromBas'
  // user page basket Screen
  RxList<Product> listProForPageBasket = <Product>[].obs;

  // ************Product*****************
  // ************Product*****************

  // use to screen 'admin product create'
  Future<int> addProduct(nameProduct, price, brand, imageAddress, count, ram,
      hard, cpu, screen, star, deleteStatus) async {
    // this function use for create table product to database
    final db = await MyDb().db();
    var res = await db.query("products",
        where: "nameProduct = ? AND deleteStatus=?",
        whereArgs: [nameProduct, 0]);
    var jam = res.isNotEmpty ? Product.fromJson(res.first) : Null;
    if (jam == Null) {
      await db.insert('products', {
        "nameProduct": nameProduct,
        "price": price,
        "brand": brand,
        "imageAddress": imageAddress,
        "count": int.parse(count),
        "ram": ram,
        "hard": hard,
        "cpu": cpu,
        "screen": screen,
        "star": star,
        "deleteStatus": deleteStatus,
        "createdAt": DateTime.now().toString().split(".")[0],
        "updatedAt": DateTime.now().toString().split(".")[0]
      });
      await readAllProducts();
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'ثبت محصول',
          style: TextStyle(fontSize: 20, color: kPurpleDark),
        ),
        messageText: const Text(
          'محصول با موفقیت ثبت شد',
          style: TextStyle(fontSize: 18, color: kPurpleDark),
        ),
        backgroundColor: Colors.white,
        colorText: kPinkDark,
        duration: const Duration(milliseconds: 1500),
      );
      return 1;
    } else {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'عملیات ناموفق',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'محصولی با این نام قبلا در سیستم ثبت شده است',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        icon: const Icon(
          Icons.highlight_remove_outlined,
          color: Colors.white,
          size: 35,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shouldIconPulse: false,
        backgroundColor: kRedLight,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1500),
      );
      return 0;
    }
  }

  // use to screen 'admin product update'
  Future<int> updateProduct(int id, Product pro) async {
    // this function use for update table product to database
    final db = await MyDb().db();
    Product product = Product();
    var res = await db.query("products",
        where: "id = ? AND deleteStatus=?", whereArgs: [id, 0]);
    var jam = res.isNotEmpty ? product = Product.fromJson(res.first) : Null;
    if (jam == Null) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'عملیات ناموفق',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'این محصول در سیستم موجود نمی باشد',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        icon: const Icon(
          Icons.highlight_remove_outlined,
          color: Colors.white,
          size: 35,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shouldIconPulse: false,
        backgroundColor: kRedLight,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1500),
      );
      return 0;
    } else {
      await db.update(
          'products',
          Product(
            nameProduct: pro.nameProduct,
            screen: pro.screen,
            updatedAt: DateTime.now().toString().split(".")[0],
            createdAt: pro.createdAt,
            count: int.parse(pro.count.toString()),
            id: pro.id,
            brand: pro.brand,
            hard: pro.hard,
            cpu: pro.cpu,
            ram: pro.ram,
            price: pro.price,
            imageAddress: pro.imageAddress,
            star: pro.star,
            deleteStatus: pro.deleteStatus,
          ).toJson(),
          where: "id=?",
          whereArgs: [pro.id]);
      await readAllProducts();

      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'ویرایش اطلاعات',
          style: TextStyle(fontSize: 20, color: kPurpleDark),
        ),
        messageText: const Text(
          'اطلاعات محصول با موفقیت ویرایش شد',
          style: TextStyle(fontSize: 18, color: kPurpleDark),
        ),
        backgroundColor: Colors.white,
        colorText: kPinkDark,
        duration: const Duration(milliseconds: 1500),
      );
      return 1;
    }
  }

  // use database 'my_db'
  // use function 'addProduct'
  Future<List<Map<String, dynamic>>> readAllProducts() async {
    // use function read products from db
    final  db = await MyDb().db();
    final List<Map<String, dynamic>> maps =
    await db.query('products', where: "deleteStatus=?", whereArgs: [0]);
    if (maps.isEmpty) {
      return List.empty();
    } else {
      return maps;
    }
  }

  // use to screen 'show all product'
  Future<int> deleteProducts() async {
    // use function delete products from db where don't delete
    // update deleteStatus from 0 to 1
    final db = await MyDb().db();
    var result = await db.update(
      'products',
      {'deleteStatus': 1},
      where: 'deleteStatus = ?',
      whereArgs: [0],
    );

    // تغییر وضعیت محصولات در سبد خرید (در صورتی که لازم باشد)

    await db.update(
        'baskets', {'productId': -1, 'deleteStatus': 1},
        where: "deleteStatus=?", whereArgs: [0]);

    // چاپ نتیجه‌ها برای بررسی
    if (result != 0) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'حذف محصولات',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'تمامی محصولات با موفقیت حذف شدند',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: kPurpleDark,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1500),
      );
      return 1;
    } else {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'عملیات ناموفق',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'حذف محصولات با خطا مواجه شد',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        icon: const Icon(
          Icons.highlight_remove_outlined,
          color: Colors.white,
          size: 35,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shouldIconPulse: false,
        backgroundColor: kRedLight,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1500),
      );
      return 0;
    }
  }

  // use to screen 'show all product'
  Future<int> deleteProduct(int id) async {
    // use function delete product from db by id where don't delete
    // update deleteStatus from 0 to 1
    final db = await MyDb().db();
    var result = await db.update(
      'products',
      {'deleteStatus': 1},
      where: 'id = ?',
      whereArgs: [id],
    );

    // تغییر وضعیت محصولات در سبد خرید (در صورتی که لازم باشد)
   await db.update(
        'baskets', {'productId': -1, 'deleteStatus': 1},
        where: "productId=? AND deleteStatus=?", whereArgs: [id, 0]);
    // تغییر وضعیت سبد خرید با شناسه محصول مشخص

    // چاپ نتیجه‌ها برای بررسی
    if (result != 0) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'حذف محصول',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'محصول با موفقیت حذف شد',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: kPurpleDark,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1500),
      );
      return 1;
    } else {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'عملیات ناموفق',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'حذف محصول با خطا مواجه شد',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        icon: const Icon(Icons.highlight_remove_outlined,
            color: Colors.white, size: 35),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shouldIconPulse: false,
        backgroundColor: kRedLight,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1500),
      );
      return 0;
    }
  }

  // use to controller 'invoice,home,mySearch,product'
  // use to screen 'BasketScreen'
  Future<List<Product>> getProducts() async {
    // use function read products from db where don't delete
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps =
    await db.query('products', where: "deleteStatus=?", whereArgs: [0]);

    if (maps.isEmpty) {
      return productList;
    } else {
      return List.generate(
        maps.length,
            (i) {
          productList.add(Product.fromJson(maps[i]));
          return (productList[i]);
        },
      );
    }
  }

  // use to controller 'invoiceController'
  Future<List<Product>> getProductForInvoice() async {
    // use function for read products for Invoice don't where
    // and push to list 'productListForShowOrder'
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps = await db.query('products');
    if (maps.isEmpty) {
      return productListForShowOrder;
    } else {
      return List.generate(
        maps.length,
            (i) {
          productListForShowOrder.add(Product.fromJson(maps[i]));
          return (productListForShowOrder[i]);
        },
      );
    }
  }

  // use to basketScreen
  Future<RxList<Product>> getProductsForBasket() async {
    // use function read products from db where don't delete
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps =
    await db.query('products', where: "deleteStatus=?", whereArgs: [0]);

    if (maps.isEmpty) {
      return listProForPageBasket;
    } else {
      return RxList.generate(
        maps.length,
            (i) {
              listProForPageBasket.add(Product.fromJson(maps[i]));
          return (listProForPageBasket[i]);
        },
      );
    }
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
  void onInit()async{
    // TODO: implement onInit
    super.onInit();
    getProducts();
    var get =await getProducts();
    print(get.length);
    print(':::::::::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
  }
}
