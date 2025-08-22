import 'package:event_app/core/config/global.dart';
import 'package:event_app/core/config/route.dart';
import 'package:event_app/core/helper/cart_service.dart';
import 'package:event_app/core/helper/storage_service.dart';
import 'package:event_app/core/shared/screen/splash_screen.dart';
import 'package:event_app/core/utils/injector.dart';
import 'package:event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:event_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:event_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:event_app/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  gNavigatorKey = GlobalKey<NavigatorState>();

  await StorageService.init();

  await CartService().database;

  initInjector();

  runApp(
    RequestsInspector(enabled: kDebugMode, showInspectorOn: ShowInspectorOn.Both, navigatorKey: null, child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => PaymentBloc()),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: ToastificationWrapper(
        child: MaterialApp(navigatorKey: gNavigatorKey, onGenerateRoute: MyRouter.generateRoute, home: SplashScreen()),
      ),
    );
  }
}
