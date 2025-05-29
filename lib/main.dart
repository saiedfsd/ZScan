import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'database/db_helper.dart';
import 'screens/home_screen.dart';
import 'package:flutter/foundation.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  zx.setLogEnabled(kDebugMode);
  await DbHelper().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZScanner',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: HomeScreen(),
    );
  }
}
