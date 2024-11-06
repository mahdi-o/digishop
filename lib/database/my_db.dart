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
  List<Basket> basketList = <Basket>[];
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
        updatedAt TEXT
        )""",
        );
        db.execute(
          """CREATE TABLE IF NOT EXISTS invoice_products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idInvoice INTEGER,
        idProduct INTEGER,
        count INTEGER
        )""",
        );
      },
    );
  }
  Future<void> addTest()async{
    print('vorod 1 test');
    final db =await MyDb().db();
    print('vorod 2 test');
    await db.insert('invoice_products', {
      "idInvoice": 1,
      "idProduct":2,
      "count":11,
    });
    print('succ test');
  }

  //''''''''''''basket''''''''''''''''''''

  Future<void> addBasket(
      nameBasket, usernameId, productId, count, isPaying) async {
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
    print(productId);
    print('productId');
    print(nameBasket);
    print('nameBasket');
    print(count);
    print('count');



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


  // ye feal (checkNameProductForDb) alaki baraye check karadn id ye mahsol
  // mitonim pak konim , moshki pish nmiyads
  Future<List<Map<String, dynamic>>> checkNameProductForDb(String name) async {
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps = await db.query("products", where: "nameProduct = ?", whereArgs: [name]);
    if (maps.isEmpty) {
      return maps;
    } else {
      return maps;
    }
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
          where: "nameProduct=?",
          whereArgs: [pro.nameProduct]);
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
      print('empty');
      return productList.value;
    } else {
      print('no empty');

      return List.generate(
        maps.length,
        (i) {
          print('no empty 2');
          productList.value.add(Product.fromJson(maps[i]));
          print(productList.value[i].nameProduct);
           print(productList.value[i].count);
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

  Future<List<Map<String, dynamic>>> readCustomers() async {
    final db = await MyDb().db();
    List<Map<String, dynamic>> maps = await db.query('customers');
    if (maps.isEmpty) {
      print(maps.length);
      return maps;
    } else {
      print(maps.length);
      return maps;
    }
  }

  Future<int> deleteCustomer(int id) async {
    final db = await MyDb().db();
    var result = await db.rawDelete('DELETE FROM customers WHERE id == $id');
    // var result = await db.delete('customers', where: "id=?", whereArgs: [id]);
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

/////////////////////////////////////////////////

  Future<void> addInvoices1(idProduct, idCustomer,nameCustomer, count, typePay, discount,
      isPaying, createdAt, updatedAt) async {
    final db = await MyDb().db();
    // var res = await db.query("invoices",
    //     where: "idInvoice=? AND isPaying=?", whereArgs: [idInvoice, 0]);
    // var jam = res.isNotEmpty ? Invoice.fromJson(res.first) : Null;
    await db.insert("invoices", {
      "idProduct": idProduct,
      "idCustomer": idCustomer,
      "nameCustomer": nameCustomer,
      "count": int.parse(count),
      "typePay": typePay,
      "discount": discount,
      "isPaying": isPaying,
      "createdAt": DateTime.now().toString().split(".")[0],
      "updatedAt": DateTime.now().toString().split(".")[0]
    });
  }

  Future<void> updateInvoice1(idCustomer, Invoice newInvoice) async {
    final db = await MyDb().db();
    Invoice invoice = Invoice();
    var res = await db.query("invoices",
        where: "idCustomer = ? AND isPaying=?", whereArgs: [idCustomer, 0]);
    var jam = res.isNotEmpty ? invoice = Invoice.fromJson(res.first) : Null;
    if (jam == Null) {
      Get.snackbar(
        'عملیات ناموفق',
        'فاکتور پرداخت نشده ای با این مشخصات در سیستم موجود نمی باشد',
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
          'invoices',
          Invoice(
            id: newInvoice.id,
            idCustomer: newInvoice.idCustomer,
            nameCustomer: newInvoice.nameCustomer,
            typePay: newInvoice.typePay,
            discount: newInvoice.discount,
            isPaying: newInvoice.isPaying,
            createdAt: newInvoice.createdAt,
            updatedAt: DateTime.now().toString().split(".")[0],
          ).toJson(),
          where: "idCustomer = ? AND isPaying=?",
          whereArgs: [newInvoice.idCustomer, 0]);
    }
  }

  Future<List<Map<String, dynamic>>> readInvoices1() async {
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

  Future<String> readInvoice1(idCustomer) async {
    final db = await MyDb().db();
    Invoice invoice = Invoice();
    var res = await db.query('invoice',
        where: "idCustomer=? AND isPaying=?", whereArgs: [idCustomer, 0]);
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
//
// Future<int> deleteInvoice(int idCustomer)async{
//   final db = await MyDb().db();
//   var result =  await db.rawDelete('DELETE FROM invoices WHERE idCustomer == $idCustomer');
//   return result;
// }





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
      var jam = res.isNotEmpty ? invoicePro = InvoiceProducts.fromJson(res.first) : Null;
      if (jam != Null) {
        print({'${invoicePro.idInvoice}${invoicePro.idProduct}'}.toString());
        return {'${invoicePro.idInvoice}${invoicePro.idProduct}'}.toString();
      } else {
        print({'${invoicePro.idInvoice}${invoicePro.idProduct}'}.toString());
        return {'${invoicePro.idInvoice}${invoicePro.idProduct}'}.toString();
      }
    }
  }

  Future<List<Map<String, dynamic>>> readInvoices()async{
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

  Future<List<Map<String, dynamic>>> readInvoiceProducts()async{
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

  Future<void> addInvoice(
      idCustomer,nameCustomer, idInvoices, idProduct, nameProduct, countProduct, priceFi,
      priceSum, typePay, discount,isPaying) async {
    print('gham gham gham gham gham 0');
    final db = await MyDb().db();
    print('gham gham gham gham gham 1');
    Invoice inv = Invoice();
    var res = await db.query("invoices",
        where: "idCustomer = ? AND isPaying=?", whereArgs: [idCustomer, 0]);
    print('gham gham gham gham gham 2');
    var jam = res.isNotEmpty ? inv = Invoice.fromJson(res.first) : Null;
    print('gham gham gham gham gham 3');
    if (jam != Null) {
      // in halat zamani etefagh mioftad ke faktori baraye in customer az ghabl vojod dard va pardakh nashode
      // bare hamin factor jadidi create nmishavad
      print('create invoiceProducts');
      //create invoice
      await db.insert(
          'invoice_products',
          InvoiceProducts(
            idInvoice: idInvoices,
              idProduct: idProduct,
              count: countProduct,)
              .toJson());
      print('gham gham gham gham gham 4');

    } else {
      print('create invoice');
      print(idCustomer);
      print('a');
      print(nameCustomer);
      print('A');
      print(typePay);
      print('B');
      print(discount);
      print('C');
      print(isPaying);
      print('D');
      await db.insert('Invoices', {
        "idCustomer": idCustomer,
        "nameCustomer": nameCustomer,
        "typePay": typePay,
        "discount": discount,
        "isPaying": isPaying,
        "createdAt": DateTime.now().toString().split(".")[0],
        "updatedAt": DateTime.now().toString().split(".")[0]
      });
      print('gham gham gham gham gham 5');

      await db.insert('invoice_products', InvoiceProducts(
        idInvoice: idInvoices,
            idProduct: idProduct,
            count: countProduct,).toJson());
      print('gham gham gham gham gham 6');

      // invoice exists by customer in no pay
    }
    print('gham gham gham gham gham 7');

  }

  Future<List<Invoice>> getInvoice() async {
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps = await db.query('invoices');
    print(maps.length);
    print('orpqwhjdwefmklsesgkpefnjawfmklsegoksefjbawdanwjfkpselakwdnkjawew98328572398492384032747324wefefnsflsef');
    if (maps.isEmpty) {
      print('empty');
      return invoiceList.value;
    } else {
      print('no empty');

      return List.generate(
        maps.length,
            (i) {
          print('no empty 2');
          invoiceList.value.add(Invoice.fromJson(maps[i]));
          return (invoiceList.value[i]);
        },
      );
    }
  }

}
