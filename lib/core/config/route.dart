import 'package:event_app/core/config/constant.dart';
import 'package:event_app/core/config/global.dart';
import 'package:event_app/features/auth/presentation/screen/login_screen.dart';
import 'package:event_app/features/auth/presentation/screen/register_screen.dart';
import 'package:event_app/features/home/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    gRoute = settings.name ?? '';
    late Widget Function(BuildContext) screenTujuan;
    Map<String, dynamic>? arguments;

    if (settings.arguments != null) {
      arguments = settings.arguments as Map<String, dynamic>;
    }

    switch (settings.name) {
      case Constant.routeRegister:
        screenTujuan = (_) => RegisterScreen();
        break;
      case Constant.routeLogin:
        screenTujuan = (_) => LoginScreen();
      case Constant.routeHome:
        screenTujuan = (_) => HomeScreen();
      default:
        screenTujuan = (_) => LoginScreen();
    }

    return MaterialPageRoute(builder: screenTujuan, settings: settings);
  }
}
