import 'dart:async';

import 'package:animated_flower/my_home_page.dart';
import 'package:flutter/material.dart';

class FlowerPage extends StatefulWidget {
  const FlowerPage({super.key});

  @override
  State<FlowerPage> createState() => _FlowerPageState();
}

class _FlowerPageState extends State<FlowerPage> with TickerProviderStateMixin {
  late AnimationController _animation1;
  late AnimationController _animation2;
  late AnimationController _flowerAnimation;
  late AnimationController _flowerTilt1;

  @override
  void initState() {
    _animation1 = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _animation2 = AnimationController(
      duration: const Duration(milliseconds: 4800),
      vsync: this,
    );
    _flowerAnimation = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _flowerTilt1 = AnimationController(
      duration: const Duration(milliseconds: 2400),
      vsync: this,
    );
    super.initState();
    _animation1.forward();
    _animation2.forward();
    _flowerTilt1.forward();
    Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      _flowerAnimation.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: const NextFloatingButton(
        isNext: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      body: Stack(
        children: [
          stem1(context),
          flower1(),
          Positioned.fill(
            bottom: 110,
            right: 20,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Transform.rotate(
                angle: -3.1415 / 4.5,
                child: ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0).animate(_flowerAnimation),
                  child: CustomPaint(
                    painter: LeafPainter(),
                    child: const SizedBox(
                      height: 160,
                      width: 80,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Positioned stem1(BuildContext context) {
    return Positioned.fill(
      bottom: 50,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 300,
          width: 100,
          child: Stack(
            children: [
              const Stem(),
              SizeTransition(
                sizeFactor: Tween(begin: 0.8, end: 0.0).animate(_animation1),
                child: Container(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  flower1() {
    return PositionedTransition(
      rect: TweenSequence<RelativeRect>([
        TweenSequenceItem(
          tween: RelativeRectTween(
            begin: RelativeRect.fromSize(
              const Rect.fromLTWH(31, 0, 0, 20),
              const Size(50, 50),
            ),
            end: RelativeRect.fromSize(
              const Rect.fromLTWH(15, -115, 0, 20),
              const Size(50, 50),
            ),
          ).chain(CurveTween(curve: Curves.linear)),
          weight: 100,
        ),
        TweenSequenceItem(
          tween: RelativeRectTween(
            begin: RelativeRect.fromSize(
              const Rect.fromLTWH(15, -115, 0, 20),
              const Size(50, 50),
            ),
            end: RelativeRect.fromSize(
              const Rect.fromLTWH(25, -230, 0, 20),
              const Size(50, 50),
            ),
          ).chain(CurveTween(curve: Curves.linear)),
          weight: 100,
        ),
      ]).animate(_animation1),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 150,
          width: 160,
          child: RotationTransition(
            // turns: Tween(begin: -0.05, end: 0.0).animate(_flowerTilt1),
            turns: TweenSequence<double>(
              <TweenSequenceItem<double>>[
                TweenSequenceItem<double>(
                  tween: Tween<double>(
                    begin: -0.05,
                    end: 0,
                  ).chain(CurveTween(curve: Curves.linear)),
                  weight: 36,
                ),
                TweenSequenceItem<double>(
                  tween: Tween<double>(
                    begin: 0,
                    end: 0.05,
                  ).chain(CurveTween(curve: Curves.linear)),
                  weight: 20,
                ),
              ],
            ).animate(_animation1),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Petal(color: petalRedColor()),
                ),
                petalAnimated(end: 0.066),
                petalAnimated(end: -0.066),
                petalAnimated(end: 0.133),
                petalAnimated(end: -0.133),
                petalAnimated(end: 0.2),
                petalAnimated(end: -0.2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RotationTransition petalAnimated({required double end}) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: end).animate(_flowerAnimation),
      child: Align(
        alignment: Alignment.center,
        child: Petal(
          color: petalRedColor(),
        ),
      ),
    );
  }
}

class Petal extends StatelessWidget {
  const Petal({
    super.key,
    required this.color,
  });

  final LinearGradient color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PetalClipper(),
      child: Container(
        height: 160,
        width: 80,
        decoration: BoxDecoration(
          gradient: color,
        ),
      ),
    );
  }
}

LinearGradient petalRedColor() {
  return const LinearGradient(colors: [
    Color.fromARGB(171, 244, 67, 54),
    Color.fromARGB(255, 247, 122, 113),
  ]);
}

LinearGradient leafGreenColor() {
  return const LinearGradient(colors: [
    Color.fromARGB(118, 0, 190, 25),
    Color.fromARGB(255, 43, 255, 0),
  ]);
}

class PetalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(40, 0);
    path.quadraticBezierTo(0, 40, 40, 80);
    path.quadraticBezierTo(80, 40, 40, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Stem extends StatelessWidget {
  const Stem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: StemClipper(),
      child: Container(
        height: 300,
        width: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.green.shade200,
            Colors.green.shade700,
            Colors.green.shade900,
          ]),
        ),
      ),
    );
  }
}

class StemClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(80, 300);
    path.quadraticBezierTo(20, 200, 47, 20);
    path.quadraticBezierTo(50, 10, 53, 20);
    path.quadraticBezierTo(25, 190, 86, 300);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class LeafPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.shade900
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    var path = Path();

    path.moveTo(40, 0);
    path.quadraticBezierTo(0, 40, 40, 80);
    path.quadraticBezierTo(80, 40, 40, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
