import 'package:flutter/material.dart';

class GoogleLogo extends StatelessWidget {
  const GoogleLogo({super.key, this.size = 24});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Offset center = Offset(w / 2, h / 2);
    final double radius = w / 2;
    final double stroke = w * 0.22;

    final Paint arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    final Rect arcRect = Rect.fromCircle(
      center: center,
      radius: radius - stroke / 2,
    );

    // Blue arc (right-bottom)
    arcPaint.color = const Color(0xFF4285F4);
    canvas.drawArc(arcRect, 0, 0.75, false, arcPaint);

    // Green arc (bottom)
    arcPaint.color = const Color(0xFF34A853);
    canvas.drawArc(arcRect, 0.75, 1.6, false, arcPaint);

    // Yellow arc (left)
    arcPaint.color = const Color(0xFFFBBC05);
    canvas.drawArc(arcRect, 2.35, 1.6, false, arcPaint);

    // Red arc (top)
    arcPaint.color = const Color(0xFFEA4335);
    canvas.drawArc(arcRect, 3.95, 1.6, false, arcPaint);

    // Blue crossbar
    final Paint fillBlue = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(w / 2 - 1, h / 2 - stroke / 2, w / 2 + 1, stroke),
      fillBlue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
