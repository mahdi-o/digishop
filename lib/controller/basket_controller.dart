import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/models/Basket.dart';
import 'package:digishop/models/Product.dart';
import 'package:get/get.dart';
import 'package:digishop/database/my_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/models/Basket.dart';
import 'package:digishop/models/Product.dart';
import 'package:get/get.dart';
import 'package:digishop/database/my_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class BasketController extends GetxController {
  RxList<Basket> basketList = <Basket>[].obs;
  RxList<Product> productListFromBasket =<Product> [].obs;
  ProductController productController = ProductController();
  RxInt countSum = 0.obs;
  RxInt priceSum = 0.obs;
  addBasketToDb(nameBasket, usernameId, productId, count, isPaying,deleteStatus) async {
    await MyDb().addOrUpdateBasket(nameBasket, usernameId, productId, count, isPaying,deleteStatus);
  }

  deleteBaskets() async {
    await MyDb().deleteBasket();
    basketList.clear();
  }

  deleteItemInBaskets(int id) async {
    await MyDb().deleteItemBaskets(id);
    basketList.clear();
    await getBaskets();
  }

  getDataBaskets() async {
    await MyDb().getDataFullBasket();
  }


  // Future<List<Basket>> getBaskets() async {
  //   basketList.clear();
  //   final Database db = await MyDb().db();
  //   final List<Map<String, dynamic>> maps = await db.query('baskets WHERE isPaying == 0');
  //   final dbMy = await MyDb();
  //   productListFromBasket.clear();
  //   productListFromBasket.value = await dbMy.getProductFromBas();
  //   print(productListFromBasket.length);
  //   print('productListFromBasket.length');
  //   Product product;
  //   countSum = 0.obs;
  //   priceSum = 0.obs;
  //
  //   if (maps.isEmpty) {
  //     return basketList;
  //   } else {
  //     return List.generate(
  //       maps.length,
  //           (i) {
  //         basketList.add(Basket.fromJson(maps[i]));
  //
  //         // استفاده از 'firstWhere' برای یافتن محصول با شناسه در صورتیکه شناسه محصول یکتا است
  //         product = productListFromBasket.firstWhere(
  //                 (p) => p.id == basketList[i].productId,
  //             orElse: () => Product()  // در صورت عدم یافتن محصول پیش‌فرض برمی‌گرداند
  //         );
  //
  //         // محاسبه مجموع تعداد و قیمت
  //         countSum.value += basketList[i].count!;
  //         priceSum.value += (int.parse(product.price!) * basketList[i].count!);
  //
  //         return basketList[i];
  //       },
  //     );
  //   }
  // }

  // Future<List<Basket>> getBaskets() async {
  //   final Database db = await MyDb().db();
  //   final List<Map<String, dynamic>> maps = await db.query('baskets WHERE isPaying == 0');
  //   final dbMy = await MyDb();
  //   productListFromBasket.clear();
  //   basketList.clear();
  //   productListFromBasket.value = await dbMy.getProductFromBas();
  //   print(productListFromBasket.length);
  //   print('productListFromBasket.length');
  //   Product product = Product();
  //   countSum = 0.obs;
  //   priceSum = 0.obs;
  //   if (maps.isEmpty) {
  //     return basketList;
  //   } else {
  //     return List.generate(
  //       maps.length,
  //           (i) {basketList.add(Basket.fromJson(maps[i]));
  //       db.rawQuery('SELECT count FROM baskets WHERE id == ${basketList[i].count}');
  //       countSum.value = countSum.value + basketList[i].count!;
  //       product = productListFromBasket[basketList[i].productId!-1];
  //       priceSum.value += (int.parse(product.price!) * basketList[i].count!);
  //       return (basketList[i]);
  //       },
  //     );
  //   }
  // }

  Future<List<Basket>> getBaskets() async {
    Database db = await MyDb().db();
    basketList.clear();
    productListFromBasket.clear();
      countSum = 0.obs;
      priceSum = 0.obs;
    // Query for baskets that are not yet paid
    final List<Map<String, dynamic>> basketMaps = await db.query('baskets', where: "isPaying=? AND deleteStatus=?", whereArgs: [0,0]);

    // Query for all products
    final List<Map<String, dynamic>> productMaps = await db.query('products',where: "deleteStatus=?",whereArgs: [0]);

    print(basketMaps.length);
    print('Fetching baskets...');

    if (basketMaps.isEmpty) {
      print('No baskets found');
      return basketList;
    } else {
      for (var basketItem in basketMaps) {
        Basket basket = Basket.fromJson(basketItem);

        // Find the related product using productId
        Product product = productMaps
            .map((productItem) => Product.fromJson(productItem))
            .firstWhere(
              (product) => product.id == basket.productId,
          orElse: () => Product(), // Default empty Product if not found
        );

        // Only add to the list if the product exists (i.e., valid product found)
        if (product.id != null && product.id != 0) {
          productListFromBasket.add(product);
        }

        print('Basket name: ${basket.nameBasket}');
        basketList.add(basket);
        countSum.value += basket.count!;
        priceSum.value += (int.parse(product.price!) * basket.count!);
      }

      print('Total baskets: ${basketList.length}');

              // محاسبه مجموع تعداد و قیمت


      return basketList;
    }
  }


  checkOutBasket(List<int> listId)async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.getString('username') ?? '';
    int wallerUser = pref.getInt('wallet') ?? 0;
    if(priceSum>wallerUser){
      dialogCheckOut('اخطار', 'موجودی کیف پول شما کافی نمی باشد', 'بازگشت', () {
        Get.back();}, 1);
    }
    else{
      await MyDb().checkOut(listId);
      wallerUser = wallerUser-priceSum.value;
      pref.setInt('wallet', wallerUser);
      dialogCheckOut('پرداخت', 'پرداخت با موفقیت انجام شد', 'تایید', () {
        Get.back();}, 1);
      basketList.clear();
      await getBaskets();
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getBaskets();
  }
}

// class BasketController extends GetxController {
//   RxList<Basket> basketList = <Basket>[].obs;
//   RxList<Product> productListFromBasket =<Product> [].obs;
//   ProductController productController = ProductController();
//   RxInt countSum = 0.obs;
//   RxInt priceSum = 0.obs;
//
//   addBasketToDb(nameBasket, usernameId, productId, count, isPaying) async {
//     await MyDb().addOrUpdateBasket(nameBasket, usernameId, productId, count, isPaying);
//   }
//
//   deleteBaskets() async {
//     await MyDb().deleteBasket();
//     basketList.clear();
//   }
//
//   deleteItemInBaskets(int id) async {
//     await MyDb().deleteItemBaskets(id);
//     basketList.clear();
//     await getBaskets();
//   }
//
//   getDataBaskets() async {
//     await MyDb().getDataFullBasket();
//   }
//   Future<List<Basket>> getBaskets() async {
//     final Database db = await MyDb().db();
//     final List<Map<String, dynamic>> maps = await db.query('baskets WHERE isPaying == 0');
//     print(await productController.listProductsDb.length);
//     print('lenght productlist db');
//     final dbMy = await MyDb();
//     print('lalal lalal lalal lalal');
//     productListFromBasket.clear();
//     var result = productListFromBasket.value = await dbMy.getProductFromBas();
//     print(result.first.toJson());
//     print('papapap   papapap   pappaap');
//     Product product = Product();
//     countSum = 0.obs;
//     priceSum = 0.obs;
//     if (maps.isEmpty) {
//       print('maps.isEmpty');
//       return basketList;
//     } else {
//       print('maps.not isEmpty');
//       basketList.clear();
//       return List.generate(
//
//         maps.length,
//         (i) {basketList.add(Basket.fromJson(maps[i]));
//         print('1 1 1');
//           db.rawQuery('SELECT count FROM baskets WHERE id == ${basketList[i].count}');
//         print('2 2 2');
//           countSum.value = countSum.value + basketList[i].count!;
//         print('3 3 3');
//           product = productListFromBasket[basketList[i].productId!-1];
//         print('4 4 4');
//           priceSum.value += (int.parse(product.price!) * basketList[i].count!);
//         print('jakajalk kalajalk kajakak');
//         print(basketList[i].toJson());
//         return (basketList[i]);
//         },
//       );
//     }
//   }
//   checkOutBasket(List<int> listId)async{
//     SharedPreferences pref =await SharedPreferences.getInstance();
//     pref.getString('username') ?? '';
//     int wallerUser = pref.getInt('wallet') ?? 0;
//     if(priceSum>wallerUser){
//       dialogCheckOut('اخطار', 'موجودی کیف پول شما کافی نمی باشد', 'بازگشت', () {
//         Get.back();}, 1);
//     }
//     else{
//       await MyDb().checkOut(listId);
//       wallerUser = wallerUser-priceSum.value;
//       pref.setInt('wallet', wallerUser);
//       dialogCheckOut('پرداخت', 'پرداخت با موفقیت انجام شد', 'تایید', () {
//         Get.back();}, 1);
//       basketList.clear();
//       await getBaskets();
//     }
//   }
//   @override
//   void onInit() async {
//     // TODO: implement onInit
//     super.onInit();
//     await getBaskets();
//   }
// }
