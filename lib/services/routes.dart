import 'package:digishop/screens/admin_customer_create.dart';
import 'package:digishop/screens/admin_customer_update.dart';
import 'package:digishop/screens/admin_home_screen.dart';
import 'package:digishop/screens/admin_invoice_create.dart';
import 'package:digishop/screens/admin_product_create.dart';
import 'package:digishop/screens/admin_product_update.dart';
import 'package:digishop/screens/basket_screen.dart';
import 'package:digishop/screens/customer_details.dart';
import 'package:digishop/screens/home_screen.dart';
import 'package:digishop/screens/intro_screen.dart';
import 'package:digishop/screens/invoice_details.dart';
import 'package:digishop/screens/login_screen.dart';
import 'package:digishop/screens/product_details.dart';
import 'package:digishop/screens/profile_user.dart';
import 'package:digishop/screens/register_screen.dart';
import 'package:digishop/screens/search_screen.dart';
import 'package:digishop/screens/show_all_customers.dart';
import 'package:digishop/screens/show_all_invoices.dart';
import 'package:digishop/screens/show_all_products.dart';
import 'package:digishop/screens/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/home_screen';
  static const String proDet = '/product_details';
  static const String cusDet = '/customer_details';
  static const String invDet = '/invoice_details';
  static const String profile = '/profile_user';
  static const String splash = '/splash_screen';
  static const String login = '/login_screen';
  static const String register = '/register_screen';
  static const String showAllPro = '/show_all_products';
  static const String intro = '/intro_screen';
  static const String search = '/search_screen';
  static const String basket = '/basket_screen';
  static const String adminHome = '/admin_home_screen';
  static const String adminProCre = '/admin_product_create';
  static const String adminProUpd = '/admin_product_update';
  static const String adminCusCre = '/admin_customer_create';
  static const String adminCusUpd = '/admin_customer_update';
  static const String adminInvCre = '/admin_invoice_create';
  static const String showAllCus = '/show_all_customers';
  static const String showAllInv = '/show_all_invoices';

  static final List<GetPage> listGetPage = [
    GetPage(
      name: home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: proDet,
      page: () => ProductDetails(),
    ),
    GetPage(
      name: cusDet,
      page: () => CustomerDetails(),
    ),
    GetPage(
      name: invDet,
      page: () => InvoiceDetails(),
    ),
    GetPage(
      name: profile,
      page: () => ProfileUser(),
    ),
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: register,
      page: () => const SignupPage(),
    ),
    GetPage(
      name: showAllPro,
      page: () => ShowAllProducts(),
    ),
    GetPage(
      name: intro,
      page: () => IntroScreen(),
    ),
    GetPage(
      name: search,
      page: () => SearchScreen(),
    ),
    GetPage(
      name: basket,
      page: () => BasketScreen(),
    ),
    GetPage(
      name: adminHome,
      page: () => AdminHomeScreen(),
    ),
    GetPage(
      name: adminProCre,
      page: () => AdminProductCreate(),
    ),
    GetPage(
      name: adminCusUpd,
      page: () => AdminCustomerUpdate(),
    ),
    GetPage(
      name: adminProUpd,
      page: () => AdminProductUpdate(),
    ),
    GetPage(
      name: adminCusCre,
      page: () => AdminCustomerCreate(),
    ),
    GetPage(
      name: adminInvCre,
      page: () => AdminInvoiceCreate(),
    ),
    GetPage(
      name: showAllCus,
      page: () => ShowAllCustomers(),
    ),
    GetPage(
      name: showAllInv,
      page: () => ShowAllInvoices(),
    ),

  ];
}
