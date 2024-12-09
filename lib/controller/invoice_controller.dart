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
  Rx<TextEditingController> isPaying = TextEditingController().obs;
  Rx<TextEditingController> createAt = TextEditingController().obs;
  Rx<TextEditingController> updateAt = TextEditingController().obs;

  RxInt sumProPriceAll = 0.obs;
  RxInt isPay = 0.obs;
  RxInt sumPriceAll = 0.obs;
  RxBool isProductExists = false.obs;

  RxList<Product> productListOrder = <Product>[].obs;
  RxList<Product> listProductsForInvoice = <Product>[].obs;
  RxList<Customer> listCustomersForInvoice = <Customer>[].obs;
  RxList<String> listIdProducts = <String>[].obs;
  RxList<String> listIdCustomers = <String>[].obs;
  RxList<Invoice> listInvoicesDb = <Invoice>[].obs;
  RxList listOrders = [].obs;
  RxList<Order> listOrder = <Order>[].obs;

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
  RxString? selectedValue = ''.obs;

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
      print('Customer not found');
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
        print('Product not found');
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
        Get.snackbar(
          '',
          '',
          titleText: const Text(
            'بروزرسانی تعداد محصول',
            style: TextStyle(fontSize: 18, color: kPurpleDark),
          ),
          messageText: const Text(
            'بروزرسانی تعداد محصول با موفقیت ثبت شد',
            style: TextStyle(fontSize: 18, color: kPurpleDark),
          ),
          backgroundColor: Colors.white,
          colorText: kPinkDark,
          duration: const Duration(milliseconds: 1500),
        );
      } else {
        // اگر محصول جدید است، آن را به فاکتور اضافه می‌کنیم
        await db.insert('invoice_products', {
          "idInvoice": invoice.id,
          "idProduct": product.id,
          "count": order.countOrder ?? 0,  // استفاده از ?? 0 برای جلوگیری از null
          "deleteStatus":0,
        });
        Get.snackbar(
          '',
          '',
          titleText: const Text(
            'ثبت فاکتور',
            style: TextStyle(fontSize: 18, color: kPurpleDark),
          ),
          messageText: const Text(
            'محصول با موفقیت در فاکتور ثبت شد',
            style: TextStyle(fontSize: 18, color: kPurpleDark),
          ),
          backgroundColor: Colors.white,
          colorText: kPinkDark,
          duration: const Duration(milliseconds: 1500),
        );
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
    idProduct.value.clear();
    count.value.clear();
    typePay.value.clear();
    priceFe.value.clear();
    priceSum.value.clear();
    discount.value.clear();
    listOrders.clear();
    listOrder.clear();
    listInvoicesDb.clear();
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
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'حذف سفارش',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'سفارش با موفقیت حذف شد',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: kPurpleDark,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1500),
      );
      return 1;
    }
    else{
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'عملیات ناموفق',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        messageText: const Text(
          'حذف سفارش با خطا مواجه شد',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),

        icon:const Icon(Icons.highlight_remove_outlined,color: Colors.white,size: 35,),
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        shouldIconPulse: false,
        backgroundColor: kRedLight,
        colorText: Colors.white,
        duration: const Duration(milliseconds: 1500),
      );
      return 0;
    }
  }

  Future<List<Product>> getIdNameProductForInvoice() async {
    listProductsForInvoice.clear();
    MyDb xController = Get.find<MyDb>();
    var p = await xController.getProductForInvoice();
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
    listInvoicesDb.clear();
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
