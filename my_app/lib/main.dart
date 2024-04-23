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
          ),
          body: const SimpleChart(),
        ),
      ),
    );
  }
}

class SimpleChart extends StatefulWidget {
  const SimpleChart({super.key});

  @override
  State<SimpleChart> createState() => _SimpleChartState();
}

class _SimpleChartState extends State<SimpleChart>
    with SingleTickerProviderStateMixin {
  final List<double> data = [20, 30, 50, 40, 70];
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple
  ];
  late AnimationController _controller;
  late Animation<double> _curve;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animation =
        Tween<double>(begin: 0, end: _controller.value).animate(_curve);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                height: 300.0,
                width: 300.0,
                child: CustomPaint(
                  painter: ChartPainter(data, colors, _controller.value),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: _changeColors, child: const Text("Magic!")),
      ],
    );
  }

  Random random = Random();
  void _changeColors() {
    setState(() {
      for (int i = 0; i < data.length; i++) {
        colors[i] = Color.fromRGBO(
            random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ChartPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;
  final double animationValue;

  ChartPainter(this.data, this.colors, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    double total = data.reduce(
        (value, element) => value + element); //сума всіх значень у діаграмі
    double startAngle = 0;

    for (int i = 0; i < data.length; i++) {
      double sweepAngle = (data[i] / total) *
          2 *
          pi *
          animationValue; //переведення кута у радіани

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
