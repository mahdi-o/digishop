import 'package:digishop/constans.dart';
import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Customer.dart';
import 'package:digishop/models/Invoice.dart';
import 'package:digishop/models/Order.dart';
import 'package:digishop/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../models/invoiceProducts.dart';
import 'product_controller.dart';

class InvoiceController extends GetxController {

  Rx<TextEditingController> idProduct = TextEditingController().obs;
  Rx<TextEditingController> idCustomer = TextEditingController().obs;
  Rx<TextEditingController> priceFe = TextEditingController().obs;
  Rx<TextEditingController> count = TextEditingController().obs;
  Rx<TextEditingController> priceSum = TextEditingController().obs;
  Rx<TextEditingController> typePay = TextEditingController().obs;
  Rx<TextEditingController> discount = TextEditingController().obs;
  Rx<TextEditingController> isPaying = TextEditingController().obs;
  Rx<TextEditingController> createAt = TextEditingController().obs;
  Rx<TextEditingController> updateAt = TextEditingController().obs;

  ProductController proController = Get.find<ProductController>();

  RxInt sumProPriceAll = 0.obs;
  RxInt isPay = 0.obs;
  RxInt sumPriceAll = 0.obs;
  RxBool isProductExists = false.obs;

  RxList<Product> productListOrder = <Product>[].obs;
  RxList<Product> listProductsForInvoice = <Product>[].obs;
  RxList<Customer> listCustomersForInvoice = <Customer>[].obs;
  // use file 'my_db' to function 'get invoice'
  RxList<Invoice> invoiceList = <Invoice>[].obs;
  RxList listOrders = [].obs;
  RxList<Order> listOrder = <Order>[].obs;
  // use file 'my_db' to function '  readInvoiceProductForInvoiceDetails  &  readInvoiceProduct'
  RxList<InvoiceProducts> invoiceProductsList = <InvoiceProducts>[].obs;

  ///// customer dropDown //////
  RxList<String> listIdCustomers = <String>[].obs;
  RxString? selectedValueCus = ''.obs;
  List<DropdownMenuItem<String>> addDividersAfterItemsCus(
      RxList<String> listIdCustomers) {
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
  List<double> getCustomItemsHeightsCus(){
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

  ///// product dropDown //////
  RxList<String> listIdProducts = <String>[].obs;
  RxString? selectedValuePro = ''.obs;
  List<DropdownMenuItem<String>> addDividersAfterItemsPro(
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
  List<double> getCustomItemsHeightsPro() {
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

  // use to controller 'invoiceController'
  Future<List<Invoice>> getInvoices() async {
    // use function for read invoices from db
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps =
    await db.query('invoices', where: "deleteStatus=?", whereArgs: [0]);
    if (maps.isEmpty) {
      return invoiceList;
    } else {
      invoiceList.clear();
      return List.generate(
        maps.length,
            (i) {
          invoiceList.add(Invoice.fromJson(maps[i]));
          return (invoiceList[i]);
        },
      );
    }
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
        //محصول یا مشتری پیدا نشد
        return;
      }

      final productOrder = Product.fromJson(proOrder.first);
      final customerOrder = Customer.fromJson(idGetCus.first);

      // بررسی تبدیل تعداد و قیمت و محاسبه قیمت کل
      final countProOrder = int.tryParse(countProOrderStr);
      final unitPrice = int.tryParse(productOrder.price ?? '0') ?? 0; // مقدار پیش‌فرض 0 برای قیمت
      if (countProOrder == null || unitPrice == 0) {
        //خطا در تبدیل تعداد یا قیمت محصول
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
          countOrder: countProOrder, // جلوگیری از مقدار null
          unitPrice: unitPrice,
          totalPrice: sumProOrder,
          typePay: typePayOrder,
          status: 'false',
          createdAt: DateTime.now().toString().split(".")[0],
          updatedAt: DateTime.now().toString().split(".")[0],
          deleteStatus: 0,
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
      where: 'nameCustomer = ? AND deleteStatus=?',
      whereArgs: [listOrder.first.nameCustomer,0],
    );

    if (customerResult.isEmpty) {
      //Customer not found
      return;
    }

    customer = Customer.fromJson(customerResult.first);
    var idCustomer = customer.id;

    // چک کردن وجود فاکتور باز برای مشتری
    var invoiceResult = await db.query(
      'invoices',
      where: 'idCustomer = ? AND isPaying = ? AND deleteStatus=?',
      whereArgs: [idCustomer, 0,0],
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
        "updatedAt": DateTime.now().toString().split(".")[0],
        "deleteStatus":0,
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
        where: 'nameProduct = ? AND deleteStatus=?',
        whereArgs: [order.nameProduct,0],
      );

      if (productResult.isEmpty) {
        //Product not found
        continue;
      }

      var product = Product.fromJson(productResult.first);

      // چک کردن آیا محصول قبلا به فاکتور اضافه شده است یا خیر
      var existingProductResult = await db.query(
        'invoice_products',
        where: 'idInvoice = ? AND idProduct = ? AND deleteStatus=?',
        whereArgs: [invoice.id, product.id,0],
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
        mySnackBar(true, true, 'بروزرسانی سفارش با موفقیت ثبت شد');
      } else {
        // اگر محصول جدید است، آن را به فاکتور اضافه می‌کنیم
        await db.insert('invoice_products', {
          "idInvoice": invoice.id,
          "idProduct": product.id,
          "count": order.countOrder ?? 0,  // استفاده از ?? 0 برای جلوگیری از null
          "deleteStatus":0,
        });
        mySnackBar(false, true, 'محصول با موفقیت در فاکتور ثبت شد');
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
    //Invoice with multiple orders added/updated successfully
    idProduct.value.clear();
    count.value.clear();
    typePay.value.clear();
    priceFe.value.clear();
    priceSum.value.clear();
    discount.value.clear();
    listOrders.clear();
    listOrder.clear();
    invoiceList.clear();
  }

  Future<int> deleteOrder()async{
    final db = await MyDb().db();
      var result = await  db.update(
      'invoice_products',
      {'deleteStatus': 1}, // تغییر وضعیت به حذف شده
      where: 'deleteStatus = ?',
      whereArgs: [0], // فقط رکوردهایی که هنوز حذف نشده‌اند
    );
    if(result!=0){
      mySnackBar(true, false, 'سفارش با موفقیت حذف شد');
      return 1;
    }
    else{
      mySnackBar(false, false, 'حذف سفارش با خطا مواجه شد');
      return 0;
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
      mySnackBar(true, false, 'تمام فاکتورها با موفقیت حذف شدند');
      return 1;
    } else {
      mySnackBar(false, false,'حذف فاکتورها با خطا مواجه شد');
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
      mySnackBar(true, false, 'فاکتور با موفقیت حذف شد');
      return 1;
    } else {
      mySnackBar(false, false, 'حذف فاکتور با خطا مواجه شد');
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
        mySnackBar(true, false, 'وضعیت فاکتور به پرداخت شده تغییر کرد');
        return 1;
      } else if (invoice.isPaying == 1) {
        mySnackBar(false, false, 'وضعیت فاکتور پرداخت شده می باشد');
        return 0;
      }
      return 3;
    } else {
      mySnackBar(false, false, 'فاکتور یافت نشد!');
      return 0;
    }
  }
  Future<List<Product>> getIdNameProductForInvoice() async {

    listProductsForInvoice.clear();

    var p = await proController.getProducts();

    listProductsForInvoice.value = proController.productList;

    for (int i = 0; i < listProductsForInvoice.length; i++) {
      listIdProducts.add(listProductsForInvoice[i].nameProduct!);
    }
    return p;
  }
  Future<List<Customer>> getIdNameCustomerForInvoice() async {
    listCustomersForInvoice.clear();
    MyDb xController = Get.find<MyDb>();
    CustomerController cusController = Get.find<CustomerController>();

    var c = await cusController.getCustomers();
    listCustomersForInvoice.value = cusController.customerList;
    for (int i = 0; i < listCustomersForInvoice.length; i++) {
      listIdCustomers.add(listCustomersForInvoice[i].nameCustomer!);
    }
    return c;
  }

  Future<void> getProductForInvoice() async {
    final db = await MyDb();
    await proController.getProductForInvoice();
  }


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
  clear()async{
    idProduct.value.clear();
    idCustomer.value.clear();
    priceFe.value.clear();
    count.value.clear();
    priceSum.value.clear();
    typePay.value.clear();
    discount.value.clear();
    isPaying.value.clear();
    createAt.value.clear();
    updateAt.value.clear();
    sumPriceAll = 0.obs;
    isPay = 0.obs;
    sumProPriceAll = 0.obs;
    isProductExists = false.obs;
    listOrders.clear();
    listOrder.clear();
    invoiceList.clear();
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getIdNameCustomerForInvoice();
    getIdNameProductForInvoice();
    getInvoices();
    getProductForInvoice();

  }
}
