import 'package:event_app/core/config/global.dart';
import 'package:flutter/material.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late MidtransSDK? _midtrans;

  @override
  void initState() async {
    super.initState();
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: String.fromEnvironment('MIDTRANS_CLIENT_KEY'),
        merchantBaseUrl: String.fromEnvironment('MIDTRANS_TRANSACTION_URL'),
        enableLog: true,
        colorTheme: ColorTheme(
          colorPrimary:
              Theme.of(gNavigatorKey.currentContext!).colorScheme.primary,
          colorPrimaryDark:
              Theme.of(gNavigatorKey.currentContext!).colorScheme.primary,
          colorSecondary:
              Theme.of(gNavigatorKey.currentContext!).colorScheme.secondary,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed:
            () => _midtrans?.startPaymentUiFlow(
              token: String.fromEnvironment('MIDTRANS_SERVER_KEY'),
            ),
        child: Text("Bayar"),
      ),
    );
  }
}
