import 'package:flutter/material.dart';
import 'package:zscan/screens/generator_screen.dart';
import 'package:zscan/screens/scan_history.dart';
import 'package:zscan/screens/scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("ZScan", style: TextStyle(color: Colors.white),),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.deepPurple,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: Icon(Icons.qr_code, color: Colors.white),
                text: "Generate",
              ),
              Tab(
                icon: Icon(Icons.qr_code_scanner, color: Colors.white),
                text: "Scan",
              ),
              Tab(
                icon: Icon(Icons.history, color: Colors.white),
                text: "History",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [GeneratorScreen(), ScannerScreen(), ScanHistory()]),
      ),
    );
  }
}
