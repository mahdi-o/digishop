import 'package:digishop/models/Customer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../constans.dart';
import '../database/my_db.dart';

class CustomerController extends GetxController{

  Rx<TextEditingController> nameCustomer =TextEditingController().obs;
  Rx<TextEditingController> username =TextEditingController().obs;
  Rx<TextEditingController> password =TextEditingController().obs;
  Rx<TextEditingController> phoneNumber =TextEditingController().obs;
  Rx<TextEditingController> email =TextEditingController().obs;
  Rx<TextEditingController> wallet =TextEditingController().obs;
  Rx<TextEditingController> address =TextEditingController().obs;
  Rx<TextEditingController> changePassword = TextEditingController().obs;

  // use controller 'invoiceController'
  // use file 'my_db' to function 'get customer'
  RxList<Customer> customerList = <Customer>[].obs;

  // ************Customer*****************
  // ************Customer*****************

  // use to screen 'admin customer create'
  Future<int> addCustomer(nameCustomer, username, password, email, phoneNumber,
      wallet, address, description) async {
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
        "deleteStatus": 0,
        "createdAt": DateTime.now().toString().split(".")[0],
        "updatedAt": DateTime.now().toString().split(".")[0],
      });
      await readAllCustomers();
      mySnackBar(true,true, 'اطلاعات مشتری با موفقیت ثبت شد');
      return 1;
    } else {
      mySnackBar(false, true,'نام کاربری در سیستم وجود دارد');
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
      mySnackBar(true,true, 'این مشتری در سیستم موجود نمی باشد');
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
      await readAllCustomers();
      mySnackBar(true,true, 'اطلاعات مشتری با موفقیت ویرایش شد');
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
      mySnackBar(true,false, 'مشتری با موفقیت حذف شد');
      return 1;
    } else {
      mySnackBar(false,false, 'حذف مشتری با خطا مواجه شد');
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
      mySnackBar(true,false, 'تمام مشتریان با موفقیت حذف شدند');
      return 1;
    } else {
      mySnackBar(false, false,'حذف مشتریان با خطا مواجه شد');
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

  Future<List<Map<String, dynamic>>> readAllCustomers() async {
    // use function read products from db
    final Database db = await MyDb().db();
    final List<Map<String, dynamic>> maps =
    await db.query('customers', where: "deleteStatus=?", whereArgs: [0]);
    if (maps.isEmpty) {
      return maps;
    } else {
      return maps;
    }
  }

  clear()async{
    nameCustomer.value.clear();
     username.value.clear();
     password.value.clear();
     phoneNumber.value.clear();
     email.value.clear();
     wallet.value.clear();
     address.value.clear();
  }

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getCustomers();
  }
}