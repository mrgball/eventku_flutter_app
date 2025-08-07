import 'package:event_app/core/config/global.dart';
import 'package:event_app/core/config/route.dart';
import 'package:event_app/core/helper/storage_service.dart.dart';
import 'package:event_app/core/utils/injector.dart';
import 'package:event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:event_app/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageService.init();

  initInjector();

  gNavigatorKey = GlobalKey<NavigatorState>();

  runApp(
    RequestsInspector(
      enabled: kDebugMode,
      showInspectorOn: ShowInspectorOn.Both,
      navigatorKey: null,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthBloc())],
      child: ToastificationWrapper(
        child: MaterialApp(
          navigatorKey: gNavigatorKey,
          onGenerateRoute: MyRouter.generateRoute,
          home: LoginScreen(),
        ),
      ),
    );
  }
}
