// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kiosk_pos_app/homescreen.dart';
import 'package:kiosk_pos_app/itemchoosescreen.dart';
import 'package:kiosk_pos_app/loginscreen.dart';
import 'package:kiosk_pos_app/otp.dart';
import 'package:kiosk_pos_app/select_delivery_type.dart';
import 'package:kiosk_pos_app/services/loginservice.dart';
import 'package:kiosk_pos_app/settings.dart';
import 'package:kiosk_pos_app/splash_screen.dart';
import 'login.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/" : (context) => LogoScreen(),
        "/login" : (context) => Login(),
        //"/otp" : (context) => OtpPage(),
        "/deliverytype" : (context) => DeliveryTypePage(),
        "/home" : (context) => LoginPage(),
        "/settings" : (context) => Settings(),
        "/chooseitems" : (context) => ItemChooseScreen(),
       // "/tables" : (context) => Tables(),
      },

      title: 'Minto',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
