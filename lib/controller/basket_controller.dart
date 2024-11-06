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
  MyDb dbMy = MyDb();

  addBasketToDb(nameBasket, usernameId, productId, count, isPaying) async {
    await MyDb().addOrUpdateBasket(nameBasket, usernameId, productId, count, isPaying);
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
  Future<List<Basket>> getBaskets() async {
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps = await db.query('baskets WHERE isPaying == 0');
    print(await productController.listProductsDb.length);
    print('lenght productlist db');
    productListFromBasket.value = await dbMy.getProductFromBas();
    Product product = Product();
    countSum = 0.obs;
    priceSum = 0.obs;
    if (maps.isEmpty) {
      return basketList;
    } else {
      return List.generate(
        maps.length,
        (i) {basketList.add(Basket.fromJson(maps[i]));
          db.rawQuery('SELECT count FROM baskets WHERE id == ${basketList[i].count}');
          countSum.value = countSum.value + basketList[i].count!;
          product = productListFromBasket[basketList[i].productId! - 1];
          priceSum.value += (int.parse(product.price!) * basketList[i].count!);
          return (basketList[i]);
        },
      );
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
