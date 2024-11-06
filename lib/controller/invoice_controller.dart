import 'package:digishop/constans.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Customer.dart';
import 'package:digishop/models/Invoice.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/models/invoiceProducts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  RxList<Product> listProductsForInvoice = <Product>[].obs;
  RxList<Customer> listCustomersForInvoice = <Customer>[].obs;

  RxList<String> listIdProducts = <String>[].obs;
  RxList<String> listIdCustomers = <String>[].obs;

  RxList<Invoice> listInvoicesDb = <Invoice>[].obs;

  String? selectedValueCus;
  List<DropdownMenuItem<String>> addDividersAfterItemsCus(List<String> listIdCustomers) {
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

  Rx<TextEditingController> idProduct = TextEditingController().obs;
  Rx<TextEditingController> idCustomer = TextEditingController().obs;
  Rx<TextEditingController> priceFe = TextEditingController().obs;
  Rx<TextEditingController> count = TextEditingController().obs;
  Rx<TextEditingController> priceSum = TextEditingController().obs;
  Rx<TextEditingController> typePay = TextEditingController().obs;
  Rx<TextEditingController> discount = TextEditingController().obs;
  RxInt isPay = 0.obs;
  RxList listOrders = [].obs;
  RxInt sumPriceAll = 0.obs;

  getListInvoice()async{
    listInvoicesDb.value.clear();
    listInvoicesDb.value = await MyDb().getInvoice();
  }

  Future<void> addToOrderList() async {
    print(sumPriceAll);
    RxList listOrder = [].obs;
    listOrder.add(idProduct.value.text);
    listOrder.add(count.value.text);
    print('gam 0000000000000000000000');
    var p = listProductsForInvoice
        .where((p0) => p0.nameProduct == idProduct.value.text);
    var priceP = int.parse(p.first.price!);
    var countP = (int.parse(count.value.text));
    listOrder.add('${separateDigits(priceP)} ت');
    listOrder.add('${separateDigits(priceP * countP)} ت ');
    sumPriceAll = sumPriceAll + (priceP * countP);
    priceSum.value.text = '${separateDigits(sumPriceAll.value)} تومان';
    print('lakakajakdajdawdadadawdadawdawd');
    await addInvoiceController();
    print('pwpwpwpwpwpwpwpwpwpwppw');
    listOrders.add(listOrder);
    print('gam 99999999999999999999999999999');

  }

  Future<void> addInvoiceController() async {
    print('00000000000000000000 0');
    final db = await MyDb().db();
    print('00000000000000000000 1');
    Customer customer = Customer();
    Product product = Product();
    print('00000000000000000000 2');
    int proCount = (int.parse(count.value.text));
    print('00000000000000000000 3');
    var pro = await db.query('products',
        where: 'nameProduct=?', whereArgs: [idProduct.value.text]);
    print('00000000000000000000 4');
    var resPro = pro.isNotEmpty ? product = Product.fromJson(pro.first) : Null;
    print('00000000000000000000 5');
    var cus=await db.query('customers',
        where: 'nameCustomer=?', whereArgs: [idCustomer.value.text]);
    print('00000000000000000000 6');
    var resCus = cus.isNotEmpty?customer=Customer.fromJson(cus.first):Null;
    print('00000000000000000000 7');
    if (resCus != Null) {
      print('00000000000000000000 8');
      Invoice invoice = Invoice();
      print('00000000000000000000 9');
      var idInv = await db
          .query('invoices', where: 'idCustomer=?', whereArgs: [customer.id]);
      print('00000000000000000000 10');
      var resInv=idInv.isNotEmpty?invoice=Invoice.fromJson(idInv.first):Null;
      print('00000000000000000000 11');
      for (int i = 0; i <= listOrders.length; i++) {
        print('00000000000000000000 12');
        int sumPrice = (int.parse(product.price!)) * proCount;
        print('00000000000000000000 13');
        var disCountValue = '0';
        print('00000000000000000000 14');
        if (discount.value.text.isEmpty) {
          print('00000000000000000000 15');
          disCountValue = '0';
          print('00000000000000000000 16');
        } else {
          print('00000000000000000000 17');
          disCountValue = discount.value.text;
          print('00000000000000000000 18');
        }
        print('00000000000000000000 19');
        await MyDb().addInvoice(
            customer.id,
            customer.nameCustomer,
            invoice.id,
            product.id,
            product.nameProduct,
            proCount,
            product.price,
            sumPrice,
            typePay.value.text,
            disCountValue,
            isPay.value);
        print('00000000000000000000 20');
      }
      print('00000000000000000000 21');
    }
    print('00000000000000000000 22');

  }



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
