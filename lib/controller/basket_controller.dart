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
    await MyDb().deleteBaskets();
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
          productListFromBasket.add(product);
        }

        basketList.add(basket);
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

