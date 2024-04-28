import 'package:flutter/material.dart';
import 'package:my_app/widgets/pie_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("My chart"),
          ),
          body: const SimpleChart(),
        ),
      ),
    );
  }
}
