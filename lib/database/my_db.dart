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
}
