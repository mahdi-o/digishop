import 'package:digishop/constans.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Customer.dart';
import 'package:digishop/models/Invoice.dart';
import 'package:digishop/models/Order.dart';
import 'package:digishop/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/invoiceProducts.dart';

class InvoiceController extends GetxController {

  Rx<TextEditingController> idProduct = TextEditingController().obs;
  Rx<TextEditingController> idCustomer = TextEditingController().obs;
  Rx<TextEditingController> priceFe = TextEditingController().obs;
  Rx<TextEditingController> count = TextEditingController().obs;
  Rx<TextEditingController> priceSum = TextEditingController().obs;
  Rx<TextEditingController> typePay = TextEditingController().obs;
  Rx<TextEditingController> discount = TextEditingController().obs;

  RxInt sumProPriceAll = 0.obs;
  RxInt isPay = 0.obs;
  RxInt sumPriceAll = 0.obs;
  RxBool isProductExists = false.obs;
  String? selectedValueCus;

  RxList<Product> productListOrder = <Product>[].obs;
  RxList<Product> listProductsForInvoice = <Product>[].obs;
  RxList<Customer> listCustomersForInvoice = <Customer>[].obs;
  RxList<String> listIdProducts = <String>[].obs;
  RxList<String> listIdCustomers = <String>[].obs;
  RxList<Invoice> listInvoicesDb = <Invoice>[].obs;
  RxList listOrders = [].obs;
  RxList<Order> listOrder = <Order>[].obs;


  List<DropdownMenuItem<String>> addDividersAfterItemsCus(
      List<String> listIdCustomers) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in listIdCustomers) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != listIdCustomers.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> getCustomItemsHeightsCus() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (listIdCustomers.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }

  String? selectedValue;

  List<DropdownMenuItem<String>> addDividersAfterItems(
      List<String> listIdProducts) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in listIdProducts) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != listIdProducts.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> getCustomItemsHeights() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (listIdProducts.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }

  Future<List<Invoice>>getListInvoice() async {
    listInvoicesDb.value.clear();
    listInvoicesDb.value = await MyDb().getInvoice();
    print(listInvoicesDb.value.toList().length);
    print('babo babo babooooooooooooooo');
    return listInvoicesDb.value;
  }

  Future<void> readListOrder() async {
    print('print(listOrder.length);');
    print(listOrder.length);
    print('print(listOrder.first.toJson());');
    for(var item in listOrder){
      print(item.toJson());
    }
    print('print(listOrder.toList());');
    print(listOrder.toList());
  }

  Future<void> addOrder() async {
    final db = await MyDb().db();

    // اطلاعات ورودی از فرم‌ها
    final nameCusOrder = idCustomer.value.text;
    final typePayOrder = typePay.value.text;
    final nameProOrder = idProduct.value.text;
    final countProOrderStr = count.value.text;

    // بررسی مقداردهی مشتری و محصول
    try {
      final proOrder = await db.query('products', where: 'nameProduct = ?', whereArgs: [nameProOrder]);
      final idGetCus = await db.query('customers', where: 'nameCustomer = ?', whereArgs: [nameCusOrder]);

      if (proOrder.isEmpty || idGetCus.isEmpty) {
        print("محصول یا مشتری پیدا نشد");
        return;
      }

      final productOrder = Product.fromJson(proOrder.first);
      final customerOrder = Customer.fromJson(idGetCus.first);

      // بررسی تبدیل تعداد و قیمت و محاسبه قیمت کل
      final countProOrder = int.tryParse(countProOrderStr);
      final unitPrice = int.tryParse(productOrder.price ?? '0') ?? 0; // مقدار پیش‌فرض 0 برای قیمت
      if (countProOrder == null || unitPrice == 0) {
        print("خطا در تبدیل تعداد یا قیمت محصول");
        return;
      }

      final sumProOrder = unitPrice * countProOrder;
      sumProPriceAll += sumProOrder;
       priceSum.value.text = sumProPriceAll.toString();
      // بررسی وجود محصول در سفارش‌ها
      bool productExists = false;
      int productIndex = -1;

      for (int i = 0; i < listOrder.length; i++) {
        if (listOrder[i].nameProduct == nameProOrder) {
          productExists = true;
          productIndex = i;
          break;
        }
      }

      if (productExists) {
        // اگر محصول موجود است، تعداد و قیمت کل بروزرسانی می‌شود
        listOrder[productIndex].countOrder = (listOrder[productIndex].countOrder ?? 0) + countProOrder;
        listOrder[productIndex].totalPrice = (listOrder[productIndex].unitPrice ?? 0) * (listOrder[productIndex].countOrder ?? 0);
      } else {
        // اگر محصول موجود نیست، محصول جدید به سفارش اضافه می‌شود
        listOrder.add(Order(
          idProduct: productOrder.id,
          nameProduct: productOrder.nameProduct,
          idCustomer: customerOrder.id,
          nameCustomer: customerOrder.nameCustomer,
          countOrder: countProOrder ?? 0, // جلوگیری از مقدار null
          unitPrice: unitPrice,
          totalPrice: sumProOrder,
          typePay: typePayOrder,
          status: 'false',
          createdAt: DateTime.now().toString().split(".")[0],
          updatedAt: DateTime.now().toString().split(".")[0],
        ));
      }

      // پاک کردن فرم‌ها
      idProduct.value.clear();
      count.value.clear();
    } catch (e) {
      print("خطا: $e");
    }
  }

  Future<void> addInvoice() async {
    final db = await MyDb().db();
    Invoice invoice = Invoice();
    Customer customer = Customer();

    // اگر لیست سفارش‌ها خالی است، تابع خاتمه می‌یابد.
    if (listOrder.isEmpty) return;

    // بازیابی اطلاعات مشتری از دیتابیس
    var customerResult = await db.query(
      'customers',
      where: 'nameCustomer = ?',
      whereArgs: [listOrder.first.nameCustomer],
    );

    if (customerResult.isEmpty) {
      print('Customer not found');
      return;
    }

    customer = Customer.fromJson(customerResult.first);
    var idCustomer = customer.id;

    // چک کردن وجود فاکتور باز برای مشتری
    var invoiceResult = await db.query(
      'invoices',
      where: 'idCustomer = ? AND isPaying = ?',
      whereArgs: [idCustomer, 0],
    );

    // اگر فاکتور باز وجود ندارد، فاکتور جدید ایجاد می‌شود
    if (invoiceResult.isEmpty) {
      var invoiceId = await db.insert('invoices', {
        "idCustomer": idCustomer,
        "nameCustomer": customer.nameCustomer,
        "typePay": listOrder.first.typePay,
        "discount": discount.value.text,
        "isPaying": isPay.value,
        "createdAt": DateTime.now().toString().split(".")[0],
        "updatedAt": DateTime.now().toString().split(".")[0]
      });
      invoice.id = invoiceId;
    } else {
      invoice = Invoice.fromJson(invoiceResult.first);
    }

    // ثبت هر محصول در `invoice_products` برای فاکتور واحد
    for (var order in listOrder) {
      // بازیابی محصول از دیتابیس
      var productResult = await db.query(
        'products',
        where: 'nameProduct = ?',
        whereArgs: [order.nameProduct],
      );

      if (productResult.isEmpty) {
        print('Product not found');
        continue;
      }

      var product = Product.fromJson(productResult.first);

      // چک کردن آیا محصول قبلا به فاکتور اضافه شده است یا خیر
      var existingProductResult = await db.query(
        'invoice_products',
        where: 'idInvoice = ? AND idProduct = ?',
        whereArgs: [invoice.id, product.id],
      );

      if (existingProductResult.isNotEmpty) {
        // اگر محصول قبلا در فاکتور موجود است، تعداد آن را بروزرسانی می‌کنیم
        var existingProduct = InvoiceProducts.fromJson(existingProductResult.first);
        var currentCount = existingProduct.count ?? 0;  // اگر مقدار count null بود، 0 در نظر گرفته می‌شود
        var updatedCount = currentCount + (order.countOrder ?? 0); // استفاده از ?? 0 برای جلوگیری از null

        // بروزرسانی تعداد محصول در `invoice_products`
        await db.update(
          'invoice_products',
          {'count': updatedCount},
          where: 'id = ?',
          whereArgs: [existingProduct.id],
        );
      } else {
        // اگر محصول جدید است، آن را به فاکتور اضافه می‌کنیم
        await db.insert('invoice_products', {
          "idInvoice": invoice.id,
          "idProduct": product.id,
          "count": order.countOrder ?? 0,  // استفاده از ?? 0 برای جلوگیری از null
        });
      }

      // بروزرسانی موجودی محصول در دیتابیس
      if (product.count! < (order.countOrder ?? 0)) {
        print('Insufficient stock for product: ${order.nameProduct}');
        continue;
      }

      // بروزرسانی موجودی محصول
      await db.update(
        'products',
        {'count': product.count! - (order.countOrder ?? 0)},
        where: 'id = ?',
        whereArgs: [product.id],
      );
    }

    print('Invoice with multiple orders added/updated successfully.');
  }
//////////////////////////
//   Future<void> addInvoice() async {
//     final db = await MyDb().db();
//     Invoice invoice = Invoice();
//     Customer customer = Customer();
//     Product product = Product();
//
//     if (listOrder.isEmpty) {
//       Get.snackbar(
//         'عملیات ناموفق',
//         'سفارشی برای ثبت در فاکتور وجود ندارد',
//         backgroundColor: kRedLight,
//         colorText: Colors.white,
//         icon: const Icon(
//           Icons.remove_shopping_cart_outlined,
//           size: 30,
//           color: Colors.white,
//         ),
//         shouldIconPulse: false,
//       );
//       return;
//     } // اگر لیست خالی است، خروج از تابع
//
//     // بازیابی مشتری از دیتابیس
//     var customerResult = await db.query(
//       'customers',
//       where: 'nameCustomer = ?',
//       whereArgs: [listOrder.first.nameCustomer],
//     );
//
//     if (customerResult.isEmpty) {
//       print('Customer not found');
//       return;
//     }
//
//     customer = Customer.fromJson(customerResult.first);
//     var idCustomer = customer.id;
//
//     // چک کردن وجود فاکتور باز برای مشتری
//     var invoiceResult = await db.query(
//       'invoices',
//       where: 'idCustomer = ? AND isPaying = ?',
//       whereArgs: [idCustomer, 0],
//     );
//
//     if (invoiceResult.isNotEmpty) {
//       //فاکتور از قبل وجود دارد و پرداخت نشده است
//       print('Invoice already exists and not paid');
//       return;
//     }
//
//     // اگر طول لیست یک بود، همان محصول را پردازش می‌کنیم
//     for (var order in listOrder) {
//       // بازیابی محصول از دیتابیس
//       var productResult = await db.query(
//         'products',
//         where: 'nameProduct = ?',
//         whereArgs: [order.nameProduct],
//       );
//
//       if (productResult.isEmpty) {
//         //محصولی یافت نشد
//         print('Product not found');
//         continue;
//       }
//
//       product = Product.fromJson(productResult.first);
//
//       // افزودن فاکتور
//       await MyDb().addInvoice(
//         idCustomer,
//         customer.nameCustomer,
//         0,
//         product.id,
//         product.nameProduct,
//         order.countOrder,
//         product.price,
//         order.totalPrice,
//         order.typePay,
//         discount.value.text,
//         isPay.value,
//       );
//     }
//   }
  ////////////////
  // Future<void> addInvoice() async {
  //   final db = await MyDb().db();
  //   Invoice invoice = Invoice();
  //   Customer customer = Customer();
  //   Product product = Product();
  //   print(idProduct.value.text);
  //   print('lalalallalallalala');
  //   print(listOrder.first.nameProduct);
  //   print('la laaaaaaaa  la');
  //   if (listOrder.length == 1) {
  //     print('listOrder.length == 1');
  //
  //     print(listOrder[0].nameProduct);
  //     var pro = await db.query('products',
  //         where: 'nameProduct=?', whereArgs: [listOrder.first.nameProduct]);
  //
  //     var resPro =
  //         pro.isNotEmpty ? product = Product.fromJson(pro.first) : Null;
  //     print('papapappapapapappa');
  //     print(listOrder.first.nameCustomer);
  //     var nameCustomerForAdd = listOrder.first.nameCustomer;
  //     print(nameCustomerForAdd);
  //     print('nameCustomerForAdd');
  //     print(listOrder.first.nameCustomer);
  //     var getIdCustomerForAdd = await db.query('customers',
  //         where: 'nameCustomer=?', whereArgs: [listOrder.first.nameCustomer]);
  //     var resCustomer = await getIdCustomerForAdd.isNotEmpty
  //         ? customer = Customer.fromJson(getIdCustomerForAdd.first)
  //         : Null;
  //     if (resCustomer != Null) {
  //       var idCustomerForAdd = customer.id;
  //       var checkInvoice = await db.query('invoices',
  //           where: 'idCustomer=? AND isPaying=?', whereArgs: [customer.id, 0]);
  //       var resInvoice = await checkInvoice.isNotEmpty
  //           ? invoice = Invoice.fromJson(checkInvoice.first)
  //           : Null;
  //
  //       print(resInvoice);
  //       print(
  //           'resInvoice resInvoice resInvoice resInvoice resInvoice resInvoice ');
  //       if (resInvoice != Null) {
  //         // invoice in customer vojod dard va pardakht nashode ast
  //         print('vojod dare , pay nashode');
  //         false;
  //       } else {
  //         print('vojod nadare');
  //         print(listOrder.length);
  //         print('length listOrder == 1');
  //         await MyDb().addInvoice(
  //             idCustomerForAdd,
  //             nameCustomerForAdd,
  //             0,
  //             product.id,
  //             product.nameProduct,
  //             listOrder[0].countOrder,
  //             product.price,
  //             listOrder[0].totalPrice,
  //             listOrder[0].typePay,
  //             discount.value.text,
  //             isPay.value);
  //         print('add az listOrder == 1 done');
  //         print('finish 2222222');
  //       }
  //       print('finish 33333333');
  //     }
  //   } else {
  //     print('listOrder.length !!!!!! = 1');
  //     for (int i = 0; i < listOrder.length; i++) {
  //       print(i);
  //       print(' i i i i i i i i ');
  //       for (var item in listOrder) {
  //         print(item.nameProduct);
  //         print('item.nameProduct');
  //         print(listOrder[i].nameProduct);
  //         var pro = await db.query('products',
  //             where: 'nameProduct=?', whereArgs: [listOrder[i].nameProduct]);
  //
  //         var resPro =
  //             pro.isNotEmpty ? product = Product.fromJson(pro.first) : Null;
  //         print('papapappapapapappa');
  //         print(listOrder[i].nameCustomer);
  //         var nameCustomerForAdd = listOrder[i].nameCustomer;
  //         print(nameCustomerForAdd);
  //         print('nameCustomerForAdd');
  //         print(listOrder[i].nameCustomer);
  //         var getIdCustomerForAdd = await db.query('customers',
  //             where: 'nameCustomer=?', whereArgs: [listOrder[i].nameCustomer]);
  //         var resCustomer = await getIdCustomerForAdd.isNotEmpty
  //             ? customer = Customer.fromJson(getIdCustomerForAdd.first)
  //             : Null;
  //         if (resCustomer != Null) {
  //           var idCustomerForAdd = customer.id;
  //           var checkInvoice = await db.query('invoices',
  //               where: 'idCustomer=? AND isPaying=?',
  //               whereArgs: [customer.id, 0]);
  //           var resInvoice = await checkInvoice.isNotEmpty
  //               ? invoice = Invoice.fromJson(checkInvoice.first)
  //               : Null;
  //           print(resInvoice);
  //           print(
  //               'resInvoice resInvoice resInvoice resInvoice resInvoice resInvoice ');
  //           if (resInvoice != Null) {
  //             // invoice in customer vojod dard va pardakht nashode ast
  //             print('vojod dare , pay nashode');
  //             false;
  //           } else {
  //             print('vojod nadare');
  //             print(listOrder.length);
  //             print('length listOrder == 1');
  //             await MyDb().addInvoice(
  //                 idCustomerForAdd,
  //                 nameCustomerForAdd,
  //                 0,
  //                 product.id,
  //                 product.nameProduct,
  //                 listOrder[i].countOrder,
  //                 product.price,
  //                 listOrder[i].totalPrice,
  //                 listOrder[i].typePay,
  //                 discount.value.text,
  //                 isPay.value);
  //             print('add az listOrder == 1 done');
  //             print('finish 2222222');
  //           }
  //           print('finish 33333333');
  //         }
  //       }
  //     }
  //   }
  // }

  // Future<void> addOrder() async {
  //   final db = await MyDb().db();
  //   Product productOrder = Product();
  //   Customer customerOrder = Customer();
  //   var nameCusOrder = idCustomer.value.text;
  //   var typePayOrder = typePay.value.text;
  //   var nameProOrder = idProduct.value.text;
  //   var countProOrder = count.value.text;
  //   var sumProOrder = 0;
  //
  //   var proOrder = await db.query('products',
  //       where: 'nameProduct=?', whereArgs: [idProduct.value.text]);
  //   print('idCustomer.value.text');
  //   print(idCustomer.value.text);
  //
  //   var idGetCus = await db.query('customers',
  //       where: 'nameCustomer=?', whereArgs: [idCustomer.value.text]);
  //   var resCustomer = idGetCus.isNotEmpty
  //       ? customerOrder = Customer.fromJson(idGetCus.first)
  //       : Null;
  //   print('0     ==========        0');
  //   print(customerOrder.id);
  //   print(customerOrder.nameCustomer);
  //   print('1 =============== 1');
  //   var prod = proOrder.isNotEmpty
  //       ? productOrder = Product.fromJson(proOrder.first)
  //       : Null;
  //
  //   if (prod != Null) {
  //     int countProOrderTwo = int.parse(countProOrder);
  //     int productOrderTwo = int.parse(productOrder.price!);
  //     int sumProOrder = productOrderTwo * countProOrderTwo;
  //     sumProPriceAll = sumProPriceAll + sumProOrder;
  //     if (listOrder.isEmpty) {
  //       print('list khali ast , hisc mahsoli mojod nist , azafe shavad');
  //       listOrder.add(Order(
  //           idProduct: productOrder.id,
  //           nameProduct: productOrder.nameProduct,
  //           idCustomer: customerOrder.id,
  //           nameCustomer: customerOrder.nameCustomer,
  //           countOrder: countProOrderTwo,
  //           unitPrice: productOrderTwo,
  //           totalPrice: sumProOrder,
  //           typePay: typePay.value.text,
  //           status: 'false',
  //           createdAt: DateTime.now().toString().split(".")[0],
  //           updatedAt: DateTime.now().toString().split(".")[0]));
  //       print(listOrder.toJson());
  //       print('print(listOrder.toJson());');
  //       print(listOrder.toList());
  //     } else {
  //       bool productExists = false;
  //       // چک کردن وجود محصول در لیست
  //       for (var item in listOrder) {
  //         if (item.nameProduct == idProduct.value.text) {
  //           productExists = true;
  //           isProductExists.value = productExists;
  //           break;
  //         }
  //       }
  //       // اگر محصول موجود نیست، اضافه شود
  //       if (!productExists) {
  //         print('mahsoj hamnam nist , azafe shavad');
  //         listOrder.add(Order(
  //             idProduct: productOrder.id,
  //             nameProduct: productOrder.nameProduct,
  //             idCustomer: customerOrder.id,
  //             nameCustomer: customerOrder.nameCustomer,
  //             countOrder: countProOrderTwo,
  //             unitPrice: productOrderTwo,
  //             totalPrice: sumProOrder,
  //             typePay: typePay.value.text,
  //             status: 'false',
  //             createdAt: DateTime.now().toString().split(".")[0],
  //             updatedAt: DateTime.now().toString().split(".")[0]));
  //         print(listOrder.toJson());
  //         print('print(listOrder.toJson());');
  //         print(listOrder.length);
  //         print('listOrder.length');
  //
  //         print(listOrder.toList());
  //       }
  //     }
  //     idProduct.value.clear();
  //     count.value.clear();
  //   }
  // }
  //////////////////////
  // Future<void> addToOrderList() async {
  //   print(sumPriceAll);
  //   RxList listOrder = [].obs;
  //   listOrder.add(idProduct.value.text);
  //   listOrder.add(count.value.text);
  //   print('gam 0000000000000000000000');
  //   print('rrooomm1');
  //   print(listOrder.length);
  //   for (var item in listOrder) {
  //     print(item);
  //   }
  //   print('rrooomm2');
  //   print(listOrder.length);
  //   // tavajoh ::: listProductsForInvoice az ghabl az toyee satabaser por mishe
  //   // chon ma toye feal getIdNameForInvoices in controller darim porsh mikonim
  //   // va toye init in controller sedash mizanim
  //   var p = listProductsForInvoice
  //       .where((p0) => p0.nameProduct == idProduct.value.text);
  //   var priceP = int.parse(p.first.price!);
  //   var countP = (int.parse(count.value.text));
  //   listOrder.add('${separateDigits(priceP)} ت');
  //   listOrder.add('${separateDigits(priceP * countP)} ت ');
  //   sumPriceAll = sumPriceAll + (priceP * countP);
  //   priceSum.value.text = '${separateDigits(sumPriceAll.value)} تومان';
  //   print('lakakajakdajdawdadadawdadawdawd');
  //   await addInvoiceController();
  //   print('pwpwpwpwpwpwpwpwpwpwppw');
  //   listOrders.add(listOrder);
  //   print('rrooomm1');
  //   print(listOrders.length);
  //   for (var item in listOrders) {
  //     print(item);
  //   }
  //   print('rrooomm2');
  //   print(listOrders.length);
  //   print('gam 99999999999999999999999999999');
  // }
  /////////////////
  // Future<void> addInvoiceController() async {
  //   final db = await MyDb().db();
  //   Customer customer = Customer();
  //   Product product = Product();
  //
  //   int proCount = (int.parse(count.value.text));
  //
  //   var pro = await db.query('products',
  //       where: 'nameProduct=?', whereArgs: [idProduct.value.text]);
  //
  //   var resPro = pro.isNotEmpty ? product = Product.fromJson(pro.first) : Null;
  //
  //   var cus = await db.query('customers',
  //       where: 'nameCustomer=?', whereArgs: [idCustomer.value.text]);
  //
  //   var resCus =
  //       cus.isNotEmpty ? customer = Customer.fromJson(cus.first) : Null;
  //
  //   if (resCus != Null) {
  //     Invoice invoice = Invoice();
  //
  //     var idInv = await db
  //         .query('invoices', where: 'idCustomer=?', whereArgs: [customer.id]);
  //
  //     var resInv =
  //         idInv.isNotEmpty ? invoice = Invoice.fromJson(idInv.first) : Null;
  //
  //     for (int i = 0; i <= listOrders.length; i++) {
  //       int sumPrice = (int.parse(product.price!)) * proCount;
  //       var disCountValue = '0';
  //
  //       if (discount.value.text.isEmpty) {
  //         disCountValue = '0';
  //       } else {
  //         disCountValue = discount.value.text;
  //       }
  //
  //       await MyDb().addInvoice(
  //           customer.id,
  //           customer.nameCustomer,
  //           invoice.id,
  //           product.id,
  //           product.nameProduct,
  //           proCount,
  //           product.price,
  //           sumPrice,
  //           typePay.value.text,
  //           disCountValue,
  //           isPay.value);
  //     }
  //   }
  // }
  /////////////////
  // Future<void> addInvoiceController() async {
  //   print('00000000000000000000 0');
  //   final db = await MyDb().db();
  //   print('00000000000000000000 1');
  //   Customer customer = Customer();
  //   Product product = Product();
  //   print('00000000000000000000 2');
  //   int proCount = (int.parse(count.value.text));
  //   print('00000000000000000000 3');
  //   var pro = await db.query('products',
  //       where: 'nameProduct=?', whereArgs: [idProduct.value.text]);
  //   print('00000000000000000000 4');
  //   var resPro = pro.isNotEmpty ? product = Product.fromJson(pro.first) : Null;
  //   print('00000000000000000000 5');
  //   var cus=await db.query('customers',
  //       where: 'nameCustomer=?', whereArgs: [idCustomer.value.text]);
  //   print('00000000000000000000 6');
  //   var resCus = cus.isNotEmpty?customer=Customer.fromJson(cus.first):Null;
  //   print('00000000000000000000 7');
  //   if (resCus != Null) {
  //     print('00000000000000000000 8');
  //     Invoice invoice = Invoice();
  //     print('00000000000000000000 9');
  //     var idInv = await db
  //         .query('invoices', where: 'idCustomer=?', whereArgs: [customer.id]);
  //     print('00000000000000000000 10');
  //     var resInv=idInv.isNotEmpty?invoice=Invoice.fromJson(idInv.first):Null;
  //     print('00000000000000000000 11');
  //     for (int i = 0; i <= listOrders.length; i++) {
  //       print('00000000000000000000 12');
  //       int sumPrice = (int.parse(product.price!)) * proCount;
  //       print('00000000000000000000 13');
  //       var disCountValue = '0';
  //       print('00000000000000000000 14');
  //       if (discount.value.text.isEmpty) {
  //         print('00000000000000000000 15');
  //         disCountValue = '0';
  //         print('00000000000000000000 16');
  //       } else {
  //         print('00000000000000000000 17');
  //         disCountValue = discount.value.text;
  //         print('00000000000000000000 18');
  //       }
  //       print('00000000000000000000 19');
  //       await MyDb().addInvoice(
  //           customer.id,
  //           customer.nameCustomer,
  //           invoice.id,
  //           product.id,
  //           product.nameProduct,
  //           proCount,
  //           product.price,
  //           sumPrice,
  //           typePay.value.text,
  //           disCountValue,
  //           isPay.value);
  //       print('00000000000000000000 20');
  //     }
  //     print('00000000000000000000 21');
  //   }
  //   print('00000000000000000000 22');
  //
  // }

  Future<List<Product>> getIdNameProductForInvoice() async {
    listProductsForInvoice.clear();
    MyDb xController = Get.find<MyDb>();
    var p = await xController.getProduct();
    listProductsForInvoice = xController.productList;
    for (int i = 0; i < listProductsForInvoice.length; i++) {
      listIdProducts.add(listProductsForInvoice[i].nameProduct!);
      print(listProductsForInvoice[i].id);
    }
    print(listIdProducts.length);
    print('bolbol');
    return p;
  }

  Future<List<Customer>> getIdNameCustomerForInvoice() async {
    listCustomersForInvoice.clear();
    MyDb xController = Get.find<MyDb>();
    var c = await xController.getCustomer();
    listCustomersForInvoice = xController.customerList;
    for (int i = 0; i < listCustomersForInvoice.length; i++) {
      listIdCustomers.add(listCustomersForInvoice[i].nameCustomer!);
      print(listCustomersForInvoice[i].id);
    }
    print(listIdCustomers.length);
    print('bolbol');
    return c;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getIdNameCustomerForInvoice();
    getIdNameProductForInvoice();
    getListInvoice();
  }
}
