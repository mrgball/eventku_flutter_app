import 'package:event_app/core/config/constant.dart';
import 'package:event_app/core/config/global.dart';
import 'package:event_app/features/auth/presentation/screen/login_screen.dart';
import 'package:event_app/features/auth/presentation/screen/register_screen.dart';
import 'package:event_app/features/cart/presentation/screen/cart_screen.dart';
import 'package:event_app/features/event/presentation/screen/detail_event_screen.dart';
import 'package:event_app/features/event/presentation/screen/event_screen.dart';
import 'package:event_app/features/home/presentation/screen/home_screen.dart';
import 'package:event_app/features/payment/presentation/screen/order_summary_screen.dart';
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
        break;
      case Constant.routeHome:
        screenTujuan = (_) => HomeScreen();
        break;
      case Constant.routeEvent:
        screenTujuan = (_) => EventScreen();
        break;
      case Constant.routeEventDetail:
        screenTujuan = (_) => DetailEventScreen(event: arguments?['event']);
        break;
      case Constant.routeOrderSummary:
        screenTujuan = (_) => OrderSummaryScreen(order: arguments?['order']);
        break;
      case Constant.routeCart:
        screenTujuan = (_) => CartScreen();
        break;
      default:
        screenTujuan = (_) => LoginScreen();
    }

    return MaterialPageRoute(builder: screenTujuan, settings: settings);
  }
}
