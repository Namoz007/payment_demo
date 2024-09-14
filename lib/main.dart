import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:uzpay/enums.dart';
import 'package:uzpay/objects.dart';
import 'package:uzpay/uzpay.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var paymentParams = Params(
    paymeParams: PaymeParams(
      transactionParam: "1",
      merchantId: "6443d473096a61fb42c216af",

      // Quyidagilar ixtiyoriy parametrlar
      accountObject: 'key', // Agar o'zgargan bo'lsa
      headerColor: Colors.indigo, // Header rangi
      headerTitle: "Payme tizimi orqali to'lash",
    ),
  );

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: InkWell(
            onTap: pay,
            child: const Icon(Icons.payment),
          ),
        ),
      ),
    );
  }

  void pay() async {
    try {
      final response = await UzPay.doPayment(
        context,
        amount: 1, // To'ov summasi
        paymentSystem: PaymentSystem.Payme,
        paymentParams: paymentParams,
        browserType: BrowserType.External,
        externalBrowserMenuItem: ChromeSafariBrowserMenuItem(
          id: 1,
          label: 'Dasturchi haqida',
          onClick: (url, title) {
            print("URL: $url");
            print("TITLE: $title");
          },
        ),
      );

      print("RESPONSE: $response");
    } catch (e) {
      print("ERROR: $e");
    }
  }
}
