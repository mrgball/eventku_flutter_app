import 'package:flutter/material.dart';

class TicketContainer extends StatelessWidget {
  final Widget topChild;
  final Widget bottomChild;
  final Color backgroundColor;
  final double notchRadius;
  final Color dashColor;
  final double height;
  final double topFlex; // proporsi bagian atas
  final double bottomFlex; // proporsi bagian bawah

  const TicketContainer({
    super.key,
    required this.topChild,
    required this.bottomChild,
    this.backgroundColor = Colors.white,
    this.notchRadius = 16.0,
    this.dashColor = Colors.grey,
    this.height = 200, // default tinggi tiket
    this.topFlex = 1,
    this.bottomFlex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipPath(
        clipper: TicketClipper(notchRadius: notchRadius),
        child: Container(
          height: height,
          color: backgroundColor,
          child: Column(
            children: [
              // Bagian atas tiket
              Expanded(
                flex: (topFlex * 100).toInt(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: topChild,
                ),
              ),

              // Garis putus-putus
              CustomPaint(
                size: Size(double.infinity, 1),
                painter: DashedLinePainter(color: dashColor),
              ),

              // Bagian bawah tiket
              Expanded(
                flex: (bottomFlex * 100).toInt(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: bottomChild,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double notchRadius;
  TicketClipper({required this.notchRadius});

  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 2 - notchRadius);
    path.arcToPoint(
      Offset(size.width, size.height / 2 + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height / 2 + notchRadius);
    path.arcToPoint(
      Offset(0, size.height / 2 - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 8.0;
    const dashSpace = 16.0;
    double startX = 0;
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
