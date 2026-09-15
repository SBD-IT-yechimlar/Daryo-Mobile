import 'package:flutter/material.dart';

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const cornerRadius = 16.0;
    const notchDepth = 15.0; // ichkariga egilish chuqurligi
    const notchWidth = 50.0; // egri chiziq kengligi
    const notchPosition = 0.5; // o‘rtada

    final h = size.height;
    final w = size.width;
    final notchY = h * notchPosition;

    // 🔹 Yuqori chap burchak
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    // 🔹 Yuqori chiziq
    path.lineTo(w - cornerRadius, 0);

    // 🔹 Yuqori o‘ng burchak
    path.quadraticBezierTo(w, 0, w, cornerRadius);

    // 🔹 O‘ng tomon yuqoridan notch boshlanishigacha
    path.lineTo(w, notchY - notchWidth / 2);

    // 🔹 O‘ng tomondagi to‘lqin (ichkariga egri)
    path.quadraticBezierTo(
      w - notchDepth, // ichkariga kirish
      notchY,
      w,
      notchY + notchWidth / 2,
    );

    // 🔹 Pastga tushish
    path.lineTo(w, h - cornerRadius);

    // 🔹 Pastki o‘ng burchak
    path.quadraticBezierTo(w, h, w - cornerRadius, h);

    // 🔹 Pastki chiziq
    path.lineTo(cornerRadius, h);

    // 🔹 Pastki chap burchak
    path.quadraticBezierTo(0, h, 0, h - cornerRadius);

    // 🔹 Chap tomonda notch boshlanishigacha
    path.lineTo(0, notchY + notchWidth / 2);

    // 🔹 Chap tomondagi to‘lqin (ichkariga egri)
    path.quadraticBezierTo(
      notchDepth,
      notchY,
      0,
      notchY - notchWidth / 2,
    );

    // 🔹 Yuqoriga qaytish
    path.lineTo(0, cornerRadius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketBorderPainter extends CustomPainter {
  final Color borderColor;
  final Color backgroundColor;
  final double borderWidth;

  TicketBorderPainter({
    required this.borderColor,
    this.backgroundColor = Colors.white,
    this.borderWidth = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const cornerRadius = 16.0;
    const notchDepth = 15.0;
    const notchWidth = 50.0;
    const notchPosition = 0.5;

    final h = size.height;
    final w = size.width;
    final notchY = h * notchPosition;

    final path = Path();

    // 🔹 Yuqori chap burchak
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    // 🔹 Yuqori chiziq
    path.lineTo(w - cornerRadius, 0);

    // 🔹 Yuqori o'ng burchak
    path.quadraticBezierTo(w, 0, w, cornerRadius);

    // 🔹 O'ng tomon yuqoridan notch boshlanishigacha
    path.lineTo(w, notchY - notchWidth / 2);

    // 🔹 O'ng tomondagi to'lqin (ichkariga egri)
    path.quadraticBezierTo(
      w - notchDepth,
      notchY,
      w,
      notchY + notchWidth / 2,
    );

    // 🔹 Pastga tushish
    path.lineTo(w, h - cornerRadius);

    // 🔹 Pastki o'ng burchak
    path.quadraticBezierTo(w, h, w - cornerRadius, h);

    // 🔹 Pastki chiziq
    path.lineTo(cornerRadius, h);

    // 🔹 Pastki chap burchak
    path.quadraticBezierTo(0, h, 0, h - cornerRadius);

    // 🔹 Chap tomonda notch boshlanishigacha
    path.lineTo(0, notchY + notchWidth / 2);

    // 🔹 Chap tomondagi to'lqin (ichkariga egri)
    path.quadraticBezierTo(
      notchDepth,
      notchY,
      0,
      notchY - notchWidth / 2,
    );

    // 🔹 Yuqoriga qaytish
    path.lineTo(0, cornerRadius);

    path.close();

    // 🎨 BITTA SOYA (har tomondan bir xil)
    canvas.drawShadow(
      path,
      const Color(0x26000000), // soya rangi va shaffoflik
      15.0, // blur radiusi (kattaroq = yumshoqroq)
      true,
    );

    // 🎨 FON (endi o'zgaruvchan)
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, backgroundPaint);

    // 🎨 BORDER
    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}