import 'package:digishop/models/Customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../database/my_db.dart';

class CustomerController extends GetxController{
  Rx<TextEditingController> name =TextEditingController().obs;
  Rx<TextEditingController> username =TextEditingController().obs;
  Rx<TextEditingController> password =TextEditingController().obs;
  Rx<TextEditingController> phoneNumber =TextEditingController().obs;
  Rx<TextEditingController> email =TextEditingController().obs;
  Rx<TextEditingController> wallet =TextEditingController().obs;
  Rx<TextEditingController> address =TextEditingController().obs;
  RxList<Customer> listCustomersDb = <Customer>[].obs;
  Rx<TextEditingController> changePassword = TextEditingController().obs;

  Future<List<Customer>>getListCustomer()async{
    listCustomersDb.value.clear();
    listCustomersDb.value = await MyDb().getCustomer();
    print(listCustomersDb.value.toList().length);
    print('babo babo babooooooooooooooo');
    return listCustomersDb.value;
  }
  clear()async{
     name.value.clear();
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
    await getListCustomer();
  }
}