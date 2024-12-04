import 'package:digishop/models/User.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  List<User> userList = [];
  Rx<String> name = ''.obs;
  Rx<String> username = ''.obs;
  Rx<String> email = ''.obs;
  Rx<String> phoneNumber = ''.obs;
  RxInt wallet = 0.obs;
  Rx<String> imageAddress=''.obs;

  loadPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name.value = pref.getString('name')??'';
    username.value = pref.getString('username')??'';
    email.value = pref.getString('email')??'';
    phoneNumber.value = pref.getString('phoneNumber')??'';
    wallet.value = pref.getInt('wallet')??0;
    imageAddress.value = pref.getString('imageAddress')??'';
  }

 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadPref();
  }
}
