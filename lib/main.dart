import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/call_log_controller.dart';
import 'screens/call_log_screen.dart';
import 'screens/dialer_screen.dart';
import 'screens/incoming_call_screen.dart';
import 'screens/outgoing_call_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner : false,
      title: 'Calling App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/dialer',
      getPages: [
        GetPage(name: '/dialer', page: () => DialerScreen()),
        GetPage(name: '/callLog', page: () => CallLogScreen()),
        // GetPage(name: '/incomingCall', page: () => IncomingCallScreen()),
        GetPage(name: '/outgoingCall', page: () => OutgoingCallScreen()),
      ],
      initialBinding: BindingsBuilder(() {
        Get.put(CallLogController());
      }),
    );
  }
}