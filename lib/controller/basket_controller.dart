import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/models/Basket.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/screens/basket_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digishop/database/my_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';


class BasketController extends GetxController {
  // use file 'my_db' to function 'get baskets'
  RxList<Basket> basketList = <Basket>[].obs;

  RxList<Product> productListFromBasket =<Product> [].obs;
  ProductController productController = ProductController();
  RxInt countSum = 0.obs;
  RxInt priceSum = 0.obs;


  // ************Basket*****************
  // ************Basket*****************

  // use database 'my_db'
  // use function 'addOrUpdateBasket'
  Future<void> addBasket(
      nameBasket, usernameId, productId, count, isPaying, deleteStatus) async {
    // this function use for create table baskets to database
    final db = await MyDb().db();
    await db.insert('baskets', {
      "nameBasket": nameBasket,
      "usernameId": usernameId,
      "productId": productId,
      "count": count,
      "isPaying": isPaying,
      "createdAt": DateTime.now().toString().split(".")[0],
      "updatedAt": DateTime.now().toString().split(".")[0],
      "deleteStatus": deleteStatus,
    });
  }


  // use to controllers 'basketController'
  Future<void> addOrUpdateBasket( nameBasket,  usernameId,
       productId,  count,  isPaying, deleteStatus) async {
    // this function use for create or update table baskets to database
    // check if not exist basket => create else update increase count basket
    final db = await MyDb().db();
    Basket bas = Basket();
    var res = await db.query("baskets",
        where: "nameBasket = ? AND isPaying=? AND deleteStatus=?",
        whereArgs: [nameBasket, 0, 0]);
    var jam = res.isNotEmpty ? bas = Basket.fromJson(res.first) : Null;
    if (jam == Null) {
      await addBasket(
          nameBasket, usernameId, productId, count, isPaying, deleteStatus);
    } else {
      await db.update(
          "baskets",
          Basket(
              id: bas.id,
              nameBasket: bas.nameBasket,
              usernameId: bas.usernameId,
              productId: bas.productId,
              isPaying: bas.isPaying,
              count: bas.count! + 1,
              createdAt: bas.createdAt,
              updatedAt: DateTime.now().toString().split(".")[0],
              deleteStatus: bas.deleteStatus)
              .toJson(),
          where: "id=?",
          whereArgs: [bas.id]);
    }
  }

  // use to controllers 'basketController'
  Future<int> deleteBaskets() async {
    // this function use for delete baskets where don't delete
    // update deleteStatus from 0 to 1
    final db = await MyDb().db();
    var result = await db.update(
      "baskets",
      {'deleteStatus': 1},
      where: 'deleteStatus = ?',
      whereArgs: [0],
    );
  print(result);
  print('+WD(#*&#^&^%@)(*(');
    // چاپ نتیجه‌ها برای بررسی
    if (result != 0) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'عملیات موفق',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'تمامی سبدها با موفقیت حذف شدند',
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
          'حذف سبدها با خطا مواجه شد',
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

  // use to controllers 'basketController'
  Future<int> deleteItemBaskets(int id) async {
    // this function use for delete basket by id where don't delete
    // update deleteStatus from 0 to 1
    // get Basket by Id from db and get data this basket and check count basket for delete
    // if count == 1 => delete basket else => update decrease count basket
    final db = await MyDb().db();
    List idBasket = await db.rawQuery('SELECT * FROM baskets WHERE id == $id AND deleteStatus == 0');
    var nameBasketForDb = idBasket.first['nameBasket'];
    var usernameIdBasketForDb = idBasket.first['usernameId'];
    var productIdBasketForDb = idBasket.first['productId'];
    var countBasketForDb = idBasket.first['count'];
    var isPayingBasketForDb = idBasket.first['isPaying'];
    var isCreatedBasketForDb = idBasket.first['createdAt'];
    var result=0;
    if (countBasketForDb == 1) {
       result = await db.update('baskets', {'deleteStatus': 1},
          where: "id=?", whereArgs: [id]);
    } else {
      result = await db.update(
          'baskets',
          Basket(
              id: id,
              nameBasket: nameBasketForDb,
              productId: productIdBasketForDb,
              usernameId: usernameIdBasketForDb,
              isPaying: isPayingBasketForDb,
              count: countBasketForDb! - 1,
              createdAt: isCreatedBasketForDb,
              updatedAt: DateTime.now().toString().split(".")[0],
              deleteStatus: 0)
              .toJson(),
          where: "id=?",
          whereArgs: [id]);
    }
    // چاپ نتیجه‌ها برای بررسی
    if (result != 0) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'عملیات موفق',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'سبد خرید با موفقیت حذف شد',
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
          'حذف سبد خرید با خطا مواجه شد',
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


  // use to controllers 'basketController'
  getDataFullBasket() async {
    // this function use for read baskets where don't paying and don't delete
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps = await db.query('baskets',
        where: "isPaying=? AND deleteStatus=?", whereArgs: [0, 0]);
    if (maps.isEmpty) {
      return 'empty';
    } else {
      return maps;
    }
  }

  // use to controllers 'basketController'
  Future<String> checkOut(List<int> listId) async {
    // this function use for pay baskets where don't paying and don't delete
    // update List basket by Id isPaying is 0 to 1
    final db = await MyDb().db();
    List idBasket = [];
    for (int i = 0; i < listId.length; i++) {
      idBasket = await db.rawQuery(
          'SELECT * FROM baskets WHERE id == ${listId[i]} AND deleteStatus == 0');
      var nameBasketForDb = idBasket[i - i]['nameBasket'];
      var usernameIdBasketForDb = idBasket[i - i]['usernameId'];
      var productIdBasketForDb = idBasket[i - i]['productId'];
      var countBasketForDb = idBasket[i - i]['count'];
      var isCreatedBasketForDb = idBasket[i - i]['createdAt'];
      int myId = listId[i].toInt();
      await db.update(
          "baskets",
          Basket(
            id: myId,
            nameBasket: nameBasketForDb,
            productId: productIdBasketForDb,
            usernameId: usernameIdBasketForDb,
            isPaying: 1,
            count: countBasketForDb,
            createdAt: isCreatedBasketForDb,
            updatedAt: DateTime.now().toString().split(".")[0],
            deleteStatus: 0,
          ).toJson(),
          where: "id=?",
          whereArgs: [myId]);
    }
    return "successful checkOut";
  }

  Future<List<Basket>> getBaskets() async {
    print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    Database db = await MyDb().db();
    basketList.clear();
    productListFromBasket.clear();
      countSum = 0.obs;
      priceSum = 0.obs;
    // Query for baskets that are not yet paid
    final List<Map<String, dynamic>> basketMaps = await db.query('baskets', where: "isPaying=? AND deleteStatus=?", whereArgs: [0,0]);

    // Query for all products
    final List<Map<String, dynamic>> productMaps = await db.query('products',where: "deleteStatus=?",whereArgs: [0]);

    if (basketMaps.isEmpty) {
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
          print('productListFromBasket productListFromBasket productListFromBasket productListFromBasket productListFromBasket');
          print(productListFromBasket.length);
          productListFromBasket.add(product);
          print(productListFromBasket.length);
        }

        print('basketList basketList basketList basketList basketList');
        print(basketList.length);
         basketList.add(basket);
        print(basketList.length);
        countSum.value += basket.count!;
        priceSum.value += (int.parse(product.price!) * basket.count!);
      }

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
      await checkOut(listId);
      wallerUser = wallerUser-priceSum.value;
      pref.setInt('wallet', wallerUser);
      dialogCheckOut('پرداخت', 'پرداخت با موفقیت انجام شد', 'تایید', () {
        Get.back();}, 1);
      basketList.clear();
      await getBaskets();
    }
  }

  // don't use
  checkDbForBaskets(String name) async {
    // use function for isExist basket in db by name
    final db = await MyDb().db();
    var res = await db.query("baskets",
        where: "nameBasket = ? AND deleteStatus=?", whereArgs: [name, 0]);
    var jam = res.isNotEmpty ? Basket.fromJson(res.first) : Null;
    return jam;
  }

  // don't use
  Future<List<Basket>> getBasketsSS() async {
    // use function for get baskets in db where don't delete and don't paying

    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps = await db.query('baskets',
        where: "isPaying=? AND deleteStatus=?", whereArgs: [0, 0]);
    if (maps.isEmpty) {
      return basketList;
    } else {
      return List.generate(
        maps.length,
            (i) {
          basketList.add(Basket.fromJson(maps[i]));
          return (basketList[i]);
        },
      );
    }
  }
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getBaskets();
  }

}

