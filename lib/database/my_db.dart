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
  RxList<Basket> basketList = <Basket>[].obs;
  RxList<Product> productList = <Product>[].obs;
  RxList<Customer> customerList = <Customer>[].obs;
  RxList<Invoice> invoiceList = <Invoice>[].obs;
  RxList<Product> listProForPageBasket = <Product>[].obs;

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
        updatedAt TEXT
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
        updatedAt TEXT
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
           updatedAt TEXT
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
        FOREIGN KEY (idCustomer) REFERENCES customers(id)
        )""",
        );
        db.execute(
          """CREATE TABLE IF NOT EXISTS invoice_products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idInvoice INTEGER,
        idProduct INTEGER,
        count INTEGER,
        FOREIGN KEY (idInvoice) REFERENCES invoices(id),
        FOREIGN KEY (idProduct) REFERENCES products(id)
        )""",
        );
      },
    );
  }

  Future<void> addTest() async {
    print('vorod 1 test');
    final db = await MyDb().db();
    print('vorod 2 test');
    await db.insert('invoice_products', {
      "idInvoice": 1,
      "idProduct": 2,
      "count": 11,
    });
    print('succ test');
  }

  //''''''''''''basket''''''''''''''''''''

  Future<void> addBasket(nameBasket, usernameId, productId, count,
      isPaying) async {
    final db = await MyDb().db();
    await db.insert('baskets', {
      "nameBasket": nameBasket,
      "usernameId": usernameId,
      "productId": productId,
      "count": count,
      "isPaying": isPaying,
      "createdAt": DateTime.now().toString().split(".")[0],
      "updatedAt": DateTime.now().toString().split(".")[0]
    });
  }

  Future<void> addOrUpdateBasket(String nameBasket, String usernameId,
      int productId, int count, int isPaying) async {
    final db = await MyDb().db();
    Basket bas = Basket();
    var res = await db.query("baskets",
        where: "nameBasket = ? AND isPaying=?", whereArgs: [nameBasket, 0]);
    var jam = res.isNotEmpty ? bas = Basket.fromJson(res.first) : Null;
    if (jam == Null) {
      print("nameBasket is null");
      await addBasket(nameBasket, usernameId, productId, count, isPaying);
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
              updatedAt: DateTime.now().toString().split(".")[0])
              .toJson(),
          where: "id=?",
          whereArgs: [bas.id]);
    }
  }

  checkDbForBaskets(String name) async {
    final db = await MyDb().db();
    var res =
    await db.query("baskets", where: "nameBasket = ?", whereArgs: [name]);
    var jam = res.isNotEmpty ? Basket.fromJson(res.first) : Null;
    return jam;
  }

  Future<List<Basket>> getBaskets() async {
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps =
    await db.query('baskets WHERE isPaying == 0');
    if (maps.isEmpty) {
      print('basketList is khali');
      return basketList;
    } else {
      print('basket list is por');
      return List.generate(
        maps.length,
            (i) {
          basketList.add(Basket.fromJson(maps[i]));
          return (basketList[i]);
        },
      );
    }
  }

  getDataFullBasket() async {
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps =
    await db.query('baskets WHERE isPaying == 0');
    if (maps.isEmpty) {
      print('return emptyyyyyyyyyyyyyyyyyy');
      return 'empty';
    } else {
      print('return mappppppppppppppppppppppppp');
      print(maps.length);
      return maps;
    }
  }

  Future<String> checkOut(List<int> listId) async {
    final db = await MyDb().db();
    List idBasket = [];
    for (int i = 0; i < listId.length; i++) {
      idBasket =
      await db.rawQuery('SELECT * FROM baskets WHERE id == ${listId[i]}');
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
              updatedAt: DateTime.now().toString().split(".")[0])
              .toJson(),
          where: "id=?",
          whereArgs: [myId]);
    }
    return "successful checkOut";
  }

  Future<String> deleteBasket() async {
    final db = await MyDb().db();
    await db.delete("baskets");
    return "successful delete baskets";
  }

  Future<String> deleteItemBaskets(int id) async {
    final db = await MyDb().db();
    List idBasket = await db.rawQuery('SELECT * FROM baskets WHERE id == $id');
    var nameBasketForDb = idBasket.first['nameBasket'];
    var usernameIdBasketForDb = idBasket.first['usernameId'];
    var productIdBasketForDb = idBasket.first['productId'];
    var countBasketForDb = idBasket.first['count'];
    var isPayingBasketForDb = idBasket.first['isPaying'];
    var isCreatedBasketForDb = idBasket.first['createdAt'];

    if (countBasketForDb == 1) {
      await db.rawDelete('DELETE FROM baskets WHERE id == $id');
    } else {
      await db.update(
          "baskets",
          Basket(
              id: id,
              nameBasket: nameBasketForDb,
              productId: productIdBasketForDb,
              usernameId: usernameIdBasketForDb,
              isPaying: isPayingBasketForDb,
              count: countBasketForDb! - 1,
              createdAt: isCreatedBasketForDb,
              updatedAt: DateTime.now().toString().split(".")[0])
              .toJson(),
          where: "id=?",
          whereArgs: [id]);
    }
    return "successful delete item in baskets";
  }

//''''''''''''product''''''''''''''''''''

  Future<void> addProduct(nameProduct, price, brand, imageAddress, count, ram,
      hard, cpu, screen, star) async {
    final db = await MyDb().db();
    var res = await db
        .query("products", where: "nameProduct = ?", whereArgs: [nameProduct]);
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
        "createdAt": DateTime.now().toString().split(".")[0],
        "updatedAt": DateTime.now().toString().split(".")[0]
      });
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'ثبت محصول', style: TextStyle(fontSize: 18, color: kPurpleDark),
        ),
        messageText: const Text(
          'محصول با موفقیت ثبت شد',
          style: TextStyle(fontSize: 18, color: kPurpleDark),),
        backgroundColor: Colors.white,
        colorText: kPinkDark,
        duration: const Duration(seconds: 1),
      );
      print('readAllProducts  // readAllProducts bad az create product');
      await readAllProducts();
    } else {
      Get.snackbar(
        'عملیات ناموفق',
        'محصولی با این نام قبلا در سیستم ثبت شده است',
        backgroundColor: kRedLight,
        colorText: Colors.white,
        icon: const Icon(
          Icons.remove_shopping_cart_outlined,
          size: 30,
          color: Colors.white,
        ),
        shouldIconPulse: false,
      );
    }
  }

  Future<void> updateProduct(int id, Product pro) async {
    final db = await MyDb().db();
    Product product = Product();
    var res = await db.query("products", where: "id = ?", whereArgs: [id]);
    var jam = res.isNotEmpty ? product = Product.fromJson(res.first) : Null;
    if (jam == Null) {
      Get.snackbar(
        'عملیات ناموفق',
        'این محصول در سیستم موجود نمی باشد',
        backgroundColor: kRedLight,
        colorText: Colors.white,
        icon: const Icon(
          Icons.remove_shopping_cart_outlined,
          size: 30,
          color: Colors.white,
        ),
        shouldIconPulse: false,
      );
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
          ).toJson(),
          where: "id=?",
          whereArgs: [pro.id]);
    }
  }

  Future<List<Map<String, dynamic>>> readAllProducts() async {
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps = await db.query('products');
    if (maps.isEmpty) {
      return maps;
    } else {
      return maps;
    }
  }

  Future<String> readProduct(int id) async {
    final Database db = await MyDb().db();
    Product pro = Product();
    var res = await db.query("products", where: "id = ?", whereArgs: [id]);
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

  Future<String> deleteProducts() async {
    final db = await MyDb().db();
    await db.delete('products');
    return "successful delete baskets";
  }

  Future<int> deleteProduct(int id) async {
    final db = await MyDb().db();
    var result = await db.rawDelete('DELETE FROM products WHERE id == $id');
    // var result = await db.delete('products', where: "id=?", whereArgs: [id]);
    return result;
  }

  Future<List<Product>> getProduct() async {
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps = await db.query('products');
    if (maps.isEmpty) {
      return productList.value;
    } else {
      return List.generate(
        maps.length,
            (i) {
          productList.value.add(Product.fromJson(maps[i]));
          return (productList.value[i]);
        },
      );
    }
  }

  Future<List<Product>> getProductFromBas() async {
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps = await db.query('products');
    if (maps.isEmpty) {
      print('empty');
      return listProForPageBasket.value;
    } else {
      print('no empty');

      return List.generate(
        maps.length,
            (i) {
          print('no empty 2');
          listProForPageBasket.value.add(Product.fromJson(maps[i]));
          print(listProForPageBasket.value[i].nameProduct);
          print(listProForPageBasket.value[i].count);
          return listProForPageBasket.value[i];
        },
      );
    }
  }

//''''''''''''customer''''''''''''''''''''
  Future<void> addCustomer(nameCustomer, username, password, email, phoneNumber,
      wallet, address, description) async {
    final db = await MyDb().db();
    var res = await db
        .query("customers", where: "username = ?", whereArgs: [username]);
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
      });
    } else {
      Get.snackbar(
        'عملیات ناموفق',
        'مشتری با این نام کاربری قبلا در سیستم ثبت شده است',
        backgroundColor: kRedLight,
        colorText: Colors.white,
        icon: const Icon(
          Icons.remove_shopping_cart_outlined,
          size: 30,
          color: Colors.white,
        ),
        shouldIconPulse: false,
      );
    }
  }

  Future<void> updateCustomer(int id, Customer newCustomer) async {
    var db = await MyDb().db();
    Customer customer = Customer();
    var res = await db.query("customers", where: "id = ?", whereArgs: [id]);
    var jam = res.isNotEmpty ? customer = Customer.fromJson(res.first) : Null;
    if (jam == Null) {
      Get.snackbar(
        'عملیات ناموفق',
        'این مشتری در سیستم موجود نمی باشد',
        backgroundColor: kRedLight,
        colorText: Colors.white,
        icon: const Icon(
          Icons.remove_shopping_cart_outlined,
          size: 30,
          color: Colors.white,
        ),
        shouldIconPulse: false,
      );
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
          ).toJson(),
          where: "id=?",
          whereArgs: [newCustomer.id]);
      print('update shod');
    }
  }

  Future<String> readCustomer(int id) async {
    final db = await MyDb().db();
    Customer cus = Customer();
    var res = await db.query("customers", where: "id = ?", whereArgs: [id]);
    if (res.isEmpty) {
      return 'null res';
    } else {
      var jam = res.isNotEmpty ? cus = Customer.fromJson(res.first) : Null;
      if (jam != Null) {
        return cus.nameCustomer ?? '';
      } else {
        return cus.nameCustomer ?? '';
      }
    }
  }

  Future<int> getIdCustomer(int id) async {
    final db = await MyDb().db();
    Customer cus = Customer();
    var res = await db.query("customers", where: "id = ?", whereArgs: [id]);
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

  Future<List<Map<String, dynamic>>> readCustomers() async {
    final db = await MyDb().db();
    List<Map<String, dynamic>> maps = await db.query('customers');
    if (maps.isEmpty) {
      return maps;
    } else {
      return maps;
    }
  }

  Future<int> deleteCustomer(int id) async {
    final db = await MyDb().db();
    // حذف مشتری از دیتابیس
    var result = await db.delete(
      'customers',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result > 0) {
      // در صورت موفقیت، حذف مشتری از لیست مشتری‌ها
      customerList.removeWhere((customer) => customer.id == id);

      // نمایش پیغام تایید
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'حذف مشتری',
          style: TextStyle(fontSize: 18, color: kPurpleDark),
        ),
        duration: const Duration(milliseconds: 100),
        messageText: const Text(
          'مشتری با موفقیت حذف شد',
          style: TextStyle(fontSize: 18, color: kPurpleDark),
        ),
        backgroundColor: Colors.white,
        colorText: kPinkDark,
      );
    } else {
      // نمایش پیغام خطا در صورت عدم موفقیت
      Get.snackbar(
        'خطا',
        'حذف مشتری با خطا مواجه شد',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }

    return result;
  }

  Future<List<Customer>> getCustomer() async {
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps = await db.query('customers');
    if (maps.isEmpty) {
      print('empty');
      return customerList.value;
    } else {
      print('no empty');

      return List.generate(
        maps.length,
            (i) {
          print('no empty 2');
          customerList.value.add(Customer.fromJson(maps[i]));
          return (customerList.value[i]);
        },
      );
    }
  }

  //''''''''''''Invoice''''''''''''''''''''
  Future<String> readInvoice(idCustomer) async {
    final db = await MyDb().db();
    Invoice invoice = Invoice();
    var res = await db.query('invoices',
        where: "idCustomer=? AND isPaying=?", whereArgs: [idCustomer, 0]);
    if (res.isEmpty) {
      return 'null res';
    } else {
      var jam = res.isNotEmpty ? invoice = Invoice.fromJson(res.first) : Null;
      if (jam != Null) {
        print({'${invoice.idCustomer}${invoice.createdAt}'}.toString());
        return {'${invoice.idCustomer}${invoice.createdAt}'}.toString();
      } else {
        print({'${invoice.idCustomer}${invoice.createdAt}'}.toString());
        return {'${invoice.idCustomer}${invoice.createdAt}'}.toString();
      }
    }
  }

  Future<String> readInvoiceProduct(idInvoice) async {
    final db = await MyDb().db();
    InvoiceProducts invoicePro = InvoiceProducts();
    var res = await db.query('invoiceProducts',
        where: "idInvoice=?", whereArgs: [idInvoice]);
    if (res.isEmpty) {
      return 'null res';
    } else {
      var jam = res.isNotEmpty ?
      invoicePro = InvoiceProducts.fromJson(res.first) : Null;
      if (jam != Null) {
        print({'${invoicePro.idInvoice}${invoicePro.idProduct}'}.toString());
        return {'${invoicePro.idInvoice}${invoicePro.idProduct}'}.toString();
      } else {
        print({'${invoicePro.idInvoice}${invoicePro.idProduct}'}.toString());
        return {'${invoicePro.idInvoice}${invoicePro.idProduct}'}.toString();
      }
    }
  }

  Future<List<Map<String, dynamic>>> readInvoices() async {
    final db = await MyDb().db();
    List<Map<String, dynamic>> maps =
    await db.query('invoices', where: "isPaying=?", whereArgs: [0]);
    if (maps.isEmpty) {
      print(maps.length);
      return maps;
    } else {
      print(maps.length);
      return maps;
    }
  }

  Future<List<Map<String, dynamic>>> readInvoiceProducts() async {
    final db = await MyDb().db();
    List<Map<String, dynamic>> maps =
    await db.query('invoice_products');
    if (maps.isEmpty) {
      print(maps.length);
      return maps;
    } else {
      print(maps.length);
      return maps;
    }
  }

  Future<List<Invoice>> getInvoice() async {
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps = await db.query('invoices');
    if (maps.isEmpty) {
      return invoiceList.value;
    } else {
      return List.generate(
        maps.length,
            (i) {
          invoiceList.value.add(Invoice.fromJson(maps[i]));
          return (invoiceList.value[i]);
        },
      );
    }
  }

  Future<String> deleteInvoices() async {
    final db = await MyDb().db();
    await db.delete('invoices');
    return "successful delete incoices";
  }

  Future<String> deleteInvoiceProducts() async {
    final db = await MyDb().db();
    await db.delete('invoice_products');
    return "successful delete invoice_products";
  }

}
