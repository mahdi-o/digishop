import 'dart:async';
import 'package:digishop/constans.dart';
import 'package:digishop/models/Basket.dart';
import 'package:digishop/models/Customer.dart';
import 'package:digishop/models/Invoice.dart';
import 'package:digishop/models/invoiceProducts.dart';
import 'package:digishop/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {

  // use controller 'invoiceController'
  // use file 'my_db' to function 'get customer'
  RxList<Customer> customerList = <Customer>[].obs;

  // use file 'my_db' to function 'get baskets'
  RxList<Basket> basketList = <Basket>[].obs;

  // use controller 'invoiceController'
  // use screen 'invoice details'
  // use file 'my_db' to function 'get product'
  RxList<Product> productList = <Product>[].obs;

  // use file 'my_db' to function 'get invoice'
  RxList<Invoice> invoiceList = <Invoice>[].obs;

  // use file 'my_db' to function 'getProductForInvoice'
  RxList<Product> productListForShowOrder = <Product>[].obs;

  // use file 'my_db' to function 'getProductFromBas'
  RxList<Product> listProForPageBasket = <Product>[].obs;

  // use file 'my_db' to function '  readInvoiceProductForInvoiceDetails  &  readInvoiceProduct'
  RxList<InvoiceProducts> invoiceProductsList = <InvoiceProducts>[].obs;

  Future<Database> db() async {
    return await openDatabase(
      join(await getDatabasesPath(), "digi.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute(
          """CREATE TABLE IF NOT EXISTS baskets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nameBasket TEXT,
        usernameId TEXT,
        productId INTEGER,
        count INTEGER,
        isPaying INTEGER,
        createdAt TEXT,
        updatedAt TEXT,
        deleteStatus INTEGER
        )""",
        );
        db.execute(
          """CREATE TABLE IF NOT EXISTS products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nameProduct TEXT,
        price TEXT,
        brand TEXT,
        imageAddress TEXT,
        count INTEGER,
        ram TEXT,
        hard TEXT,
        cpu TEXT,
        screen TEXT,
        star INTEGER,
        createdAt TEXT,
        updatedAt TEXT,
        deleteStatus INTEGER
        )""",
        );
        db.execute(
          """CREATE TABLE IF NOT EXISTS customers(
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           nameCustomer TEXT,
           username TEXT,
           password TEXT,
           email TEXT,
           phoneNumber TEXT,
           wallet TEXT,
           address TEXT,
           description TEXT,
           isDelete INTEGER,
           createdAt TEXT,
           updatedAt TEXT,
           deleteStatus INTEGER
            )""",
        );

        db.execute(
          """CREATE TABLE IF NOT EXISTS invoices(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idCustomer INTEGER,
        nameCustomer TEXT,
        typePay TEXT,
        discount TEXT,
        isPaying INTEGER,
        createdAt TEXT,
        updatedAt TEXT,
        deleteStatus INTEGER,
        FOREIGN KEY (idCustomer) REFERENCES customers(id)
        )""",
        );
        db.execute(
          """CREATE TABLE IF NOT EXISTS invoice_products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idInvoice INTEGER,
        idProduct INTEGER,
        count INTEGER,
        deleteStatus INTEGER,
        FOREIGN KEY (idInvoice) REFERENCES invoices(id),
        FOREIGN KEY (idProduct) REFERENCES products(id)
        )""",
        );
      },
    );
  }

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
  Future<void> addOrUpdateBasket(String nameBasket, String usernameId,
      int productId, int count, int isPaying, deleteStatus) async {
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

  // use to controllers 'basketController'
  Future<int> deleteBaskets() async {
    // this function use for delete baskets where don't delete
    // update deleteStatus from 0 to 1

    final db = await MyDb().db();
    await db.update(
      "baskets",
      {'deleteStatus': 1},
      where: 'deleteStatus = ?',
      whereArgs: [0],
    );
    return 1;
  }

  // use to controllers 'basketController'
  Future<String> deleteItemBaskets(int id) async {
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

    if (countBasketForDb == 1) {
      await db.update('baskets', {'deleteStatus': 1},
          where: "id=?", whereArgs: [id]);
    } else {
      await db.update(
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
    return "successful delete item in baskets";
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
  Future<List<Basket>> getBaskets() async {
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
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps =
        await db.query('products', where: "deleteStatus=?", whereArgs: [0]);
    if (maps.isEmpty) {
      return maps;
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

    var deleteProFromBas = await db.update(
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
    var deleteProFromBas = await db.update(
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

  // don't use
  Future<String> readProduct(int id) async {
    // use function read product by id from db where don't delete

    final Database db = await MyDb().db();
    Product pro = Product();
    var res = await db.query("products",
        where: "id = ? AND deleteStatus=?", whereArgs: [id, 0]);
    if (res.isEmpty) {
      return 'null res';
    } else {
      var jam = res.isNotEmpty ? pro = Product.fromJson(res.first) : Null;
      if (jam != Null) {
        return pro.nameProduct ?? '';
      } else {
        return pro.nameProduct ?? '';
      }
    }
  }

  // don't use
  Future<List<Product>> getProductFromBas() async {
    // use function for read products for basket where don't delete
    // and push to list 'listProForPageBasket'
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps =
        await db.query('products', where: "deleteStatus=?", whereArgs: [0]);
    if (maps.isEmpty) {
      return listProForPageBasket;
    } else {
      return List.generate(
        maps.length,
        (i) {
          listProForPageBasket.add(Product.fromJson(maps[i]));
          return listProForPageBasket[i];
        },
      );
    }
  }

  // ************Customer*****************
  // ************Customer*****************

  // use to screen 'admin customer create'
  Future<int> addCustomer(nameCustomer, username, password, email, phoneNumber,
      wallet, address, description, deleteStatus) async {
    // this function use for create table customer to database
    final db = await MyDb().db();
    var res = await db.query("customers",
        where: "username = ? AND deleteStatus=?", whereArgs: [username, 0]);
    var jam = res.isNotEmpty ? Customer.fromJson(res.first) : Null;
    if (jam == Null) {
      await db.insert('customers', {
        "nameCustomer": nameCustomer,
        "username": username,
        "password": password,
        "email": email,
        "phoneNumber": phoneNumber,
        "wallet": wallet,
        "address": address,
        "description": description,
        "isDelete": 0,
        "createdAt": DateTime.now().toString().split(".")[0],
        "updatedAt": DateTime.now().toString().split(".")[0],
        "deleteStatus": deleteStatus,
      });
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'ثبت مشتری',
          style: TextStyle(fontSize: 20, color: kPurpleDark),
        ),
        messageText: const Text(
          'اطلاعات مشتری با موفقیت ثبت شد',
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
          'مشتری با این نام کاربری قبلا در سیستم ثبت شده است',
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

  // use to screen 'admin customer update'
  Future<int> updateCustomer(int id, Customer newCustomer) async {
    // this function use for update table customer to database

    var db = await MyDb().db();
    Customer customer = Customer();
    var res = await db.query("customers",
        where: "id = ? AND deleteStatus=?", whereArgs: [id, 0]);
    var jam = res.isNotEmpty ? customer = Customer.fromJson(res.first) : Null;
    if (jam == Null) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'عملیات ناموفق',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'این مشتری در سیستم موجود نمی باشد',
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
          'customers',
          Customer(
                  id: newCustomer.id,
                  nameCustomer: newCustomer.nameCustomer,
                  username: newCustomer.username,
                  password: newCustomer.password,
                  email: newCustomer.email,
                  phoneNumber: newCustomer.phoneNumber,
                  wallet: newCustomer.wallet,
                  address: newCustomer.address,
                  description: newCustomer.description,
                  isDelete: newCustomer.isDelete,
                  createdAt: newCustomer.createdAt,
                  updatedAt: DateTime.now().toString().split(".")[0],
                  deleteStatus: newCustomer.deleteStatus)
              .toJson(),
          where: "id=?",
          whereArgs: [newCustomer.id]);
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'ویرایش اطلاعات',
          style: TextStyle(fontSize: 20, color: kPurpleDark),
        ),
        messageText: const Text(
          'اطلاعات مشتری با موفقیت ویرایش شد',
          style: TextStyle(fontSize: 18, color: kPurpleDark),
        ),
        backgroundColor: Colors.white,
        colorText: kPinkDark,
        duration: const Duration(milliseconds: 1500),
      );
      return 1;
    }
  }

  // use to screen 'admin customer update'
  Future<int> getIdCustomer(int id) async {
    // use function for read customer by id where don't delete
    final db = await MyDb().db();
    Customer cus = Customer();
    var res = await db.query("customers",
        where: "id = ? AND deleteStatus=?", whereArgs: [id, 0]);
    if (res.isEmpty) {
      return -1;
    } else {
      var jam = res.isNotEmpty ? cus = Customer.fromJson(res.first) : Null;
      if (jam != Null) {
        return cus.id ?? -1;
      } else {
        return cus.id ?? -1;
      }
    }
  }

  // use to screen 'show all customer'
  Future<int> deleteCustomer(int id) async {
    // use function delete customer from db by id
    // update deleteStatus from 0 to 1

    final db = await MyDb().db();
    // حذف مشتری از دیتابیس
    await db.update(
      'customers',
      {'deleteStatus': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
    var isDelete = await db.query('customers',
        where: 'id = ? AND deleteStatus=?', whereArgs: [id, 0]);
    if (isDelete.isEmpty) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'حذف مشتری',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'مشتری با موفقیت حذف شد',
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
          'حذف مشتری با خطا مواجه شد',
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

  // use to screen 'show all customer'
  Future<int> deleteCustomers() async {
    // use function delete customers from db
    // update deleteStatus from 0 to 1

    final db = await MyDb().db();
    var result = await db.update(
      'customers',
      {'deleteStatus': 1},
      where: 'deleteStatus = ?',
      whereArgs: [0], // فقط رکوردهایی که هنوز حذف نشده‌اند
    );
    if (result != 0) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'حذف مشتریان',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'تمام مشتریان با موفقیت حذف شدند',
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
          'حذف مشتریان با خطا مواجه شد',
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

  // use to controllers 'invoiceController & customerController'
  Future<List<Customer>> getCustomers() async {
    // use function read customers from db

    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps =
        await db.query('customers', where: "deleteStatus=?", whereArgs: [0]);
    if (maps.isEmpty) {
      return customerList;
    } else {

      return List.generate(
        maps.length,
        (i) {
          customerList.add(Customer.fromJson(maps[i]));
          return (customerList[i]);
        },
      );
    }
  }

  // ************Invoice*****************
  // ************Invoice*****************

  // use to screen 'invoice details'
  Future<List<InvoiceProducts>> readInvoiceProductForInvoiceDetails(
      idInvoice) async {
    // use function read invoice_products ha where don't delete by idInvoice
    // push to list 'invoiceProductsList'
    invoiceProductsList.clear();
    final db = await MyDb().db();
    List<Map<String, dynamic>> maps = await db.query('invoice_products',
        where: "idInvoice=? AND deleteStatus=?", whereArgs: [idInvoice, 0]);
    if (maps.isEmpty) {
      return invoiceProductsList;
    } else {
      return List.generate(
        maps.length,
        (i) {
          invoiceProductsList.add(InvoiceProducts.fromJson(maps[i]));
          return (invoiceProductsList[i]);
        },
      );
    }
  }

  // use to controller 'invoiceController'
  Future<List<Invoice>> getInvoices() async {
    // use function for read invoices from db
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps =
        await db.query('invoices', where: "deleteStatus=?", whereArgs: [0]);
    if (maps.isEmpty) {
      return invoiceList;
    } else {
      return List.generate(
        maps.length,
        (i) {
          invoiceList.add(Invoice.fromJson(maps[i]));
          return (invoiceList[i]);
        },
      );
    }
  }

  // use to screen 'show all invoice'
  Future<int> deleteInvoices() async {
    // use function delete invoices from db where don't delete
    // update deleteStatus from 0 to 1
    final db = await MyDb().db();
    var result = await db.update(
      'invoices',
      {
        'deleteStatus': 1,
      },
      where: 'deleteStatus = ?',
      whereArgs: [0],
    );
    if (result != 0) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'حذف فاکتورها',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'تمام فاکتورها با موفقیت حذف شدند',
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
          'حذف فاکتورها با خطا مواجه شد',
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

  // use to screen 'show all invoice'
  Future<int> deleteInvoice(int id) async {
    // use function delete invoice from db where don't delete
    // update deleteStatus from 0 to 1
    final db = await MyDb().db();
    var result = await db.update('invoices', {'deleteStatus': 1},
        where: "id=?", whereArgs: [id]);
    if (result != 0) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'حذف فاکتور',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'فاکتور با موفقیت حذف شد',
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
          'حذف فاکتور با خطا مواجه شد',
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

  // use to screen 'show all invoice'
  Future<int> changePayInvoice(int id) async {
    // use function for update isPaying from 0 to 1 where don't delete
    final Database db = await MyDb().db();
    Invoice invoice = Invoice();
    var res = await db.query("invoices",
        where: "id=? AND deleteStatus=?", whereArgs: [id, 0]);
    var jam = res.isNotEmpty ? invoice = Invoice.fromJson(res.first) : Null;
    if (jam != Null) {
      // factor vojod dard baraye update
      if (invoice.isPaying == 0) {
        await db.update(
            'invoices',
            Invoice(
              id: invoice.id,
              idCustomer: invoice.idCustomer,
              nameCustomer: invoice.nameCustomer,
              discount: invoice.discount,
              typePay: invoice.typePay,
              createdAt: invoice.createdAt,
              isPaying: 1,
              updatedAt: DateTime.now().toString().split(".")[0],
              deleteStatus: invoice.deleteStatus,
            ).toJson(),
            where: "id=?",
            whereArgs: [id]);
        Get.snackbar(
          '',
          '',
          titleText: const Text(
            'پرداخت فاکتور',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          messageText: const Text(
            'وضعیت فاکتور با موفقیت به پرداخت شده تغییر کرد',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          backgroundColor: kPurpleDark,
          colorText: kPinkDark,
          duration: const Duration(milliseconds: 1500),
        );
        return 1;
      } else if (invoice.isPaying == 1) {
        Get.snackbar(
          '',
          '',
          titleText: const Text(
            'اخطار',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          messageText: const Text(
            'وضعیت فاکتور پرداخت شده می باشد',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          backgroundColor: kRedLight,
          colorText: kPinkDark,
          duration: const Duration(milliseconds: 1500),
        );
        return 0;
      }
      return 3;
    } else {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'پرداخت ناموفق',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'فاکتور برای تغییر به حالت پرداخت شده یافت نشد!',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: kRedLight,
        colorText: kPinkDark,
        duration: const Duration(milliseconds: 1500),
      );
      return 0;
    }
  }

  // don't use
  Future<String> readInvoice(idCustomer) async {
    // use function for read invoice by id from db

    final db = await MyDb().db();
    Invoice invoice = Invoice();
    var res = await db.query('invoices',
        where: "idCustomer=? AND deleteStatus=?",
        whereArgs: [idCustomer,0]);
    if (res.isEmpty) {
      return 'null res';
    } else {
      var jam = res.isNotEmpty ? invoice = Invoice.fromJson(res.first) : Null;
      if (jam != Null) {
        return {'${invoice.idCustomer}${invoice.createdAt}'}.toString();
      } else {
        return {'${invoice.idCustomer}${invoice.createdAt}'}.toString();
      }
    }
  }

  // don't use
  // function for show order to screen invoiceDetails
  // readInvoiceProductForInvoiceDetails == readInvoiceProduct
  Future<List<InvoiceProducts>> readInvoiceProduct(idInvoice) async {
    // use function for read invoice_products ha where don't delete by idInvoice
    // push to list 'invoiceProductsList'
    invoiceProductsList.clear();
    final db = await MyDb().db();
    List<Map<String, dynamic>> maps = await db.query('invoice_products',
        where: "idInvoice=? AND deleteStatus=?", whereArgs: [idInvoice, 0]);
    if (maps.isEmpty) {
      return invoiceProductsList;
    } else {
      return List.generate(
        maps.length,
            (i) {
          invoiceProductsList.add(InvoiceProducts.fromJson(maps[i]));
          return (invoiceProductsList[i]);
        },
      );
    }
  }

  // don't use
  Future<String> deleteInvoiceProducts() async {
    // use function for delete invoice_products ha from db where don't delete
    // update deleteStatus from 0 to 1
    final db = await MyDb().db();
    await db.update('invoice_products',{
    'deleteStatus': 1,
    },
      where: 'deleteStatus = ?',
      whereArgs: [0],);
    return "successful delete invoice_products";
  }

}
