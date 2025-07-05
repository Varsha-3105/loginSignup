import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants/app_theme.dart';
import 'views/login_view.dart';
import 'views/signup_view.dart';
import 'views/forgot_password_view.dart';
import 'views/EmployeeDashboardScreen.dart';
import 'controllers/employee_dashboard_controller.dart';
import 'controllers/check_in_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Employee Management',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      initialBinding: BindingsBuilder(() {
        Get.put(CheckInController());
      }),
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/signup', page: () => SignupView()),
        GetPage(name: '/forgot-password', page: () => ForgotPasswordView()),
        GetPage(
          name: '/dashboard',
          page: () => const EmployeeDashboardScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut<EmployeeDashboardController>(() => EmployeeDashboardController());
          }),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
