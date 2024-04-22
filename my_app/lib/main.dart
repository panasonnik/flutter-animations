import 'package:flutter/material.dart';
import 'dart:math';

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
            actions: const [
              Icon(Icons.play_arrow_rounded),
              SizedBox(width: 18.0),
            ],
          ),
          body: SimpleChart(),
        ),
      ),
    );
  }
}

class SimpleChart extends StatelessWidget {
  SimpleChart({super.key});

  final List<double> data = [20, 30, 50, 40, 70];
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 300.0,
        width: 300.0,
        child: CustomPaint(
          painter: ChartPainter(data, colors),
        ),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;

  ChartPainter(this.data, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    double total = data.reduce(
        (value, element) => value + element); //сума всіх значень у діаграмі
    double startAngle = 0;

    for (int i = 0; i < data.length; i++) {
      double sweepAngle =
          (data[i] / total) * 2 * pi; //переведення кута у радіани

      Paint slicePaint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), startAngle,
          sweepAngle, true, slicePaint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
