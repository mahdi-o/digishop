import 'package:digishop/models/User.dart';
import 'package:digishop/screens/register_screen.dart';
import 'package:digishop/services/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController{

User user = User();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    myNavigate();
  }

  myNavigate()async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 3),() {
      int access = pref.getInt('access')??0;
      if(access == 0){
        Get.to(const SignupPage());
      }else{
        String usernamePref = pref.getString('username') ?? '';
        user.username = usernamePref;
        String username = pref.getString('username')??'';
        Get.toNamed(AppRoutes.home,arguments: user,parameters: {'username':username,'registerOne':'no'});
      }
    },);
  }

}