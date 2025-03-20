import 'package:flutter/material.dart';

class CropPriceLineChart extends StatelessWidget {
  final List<double> data;
  const CropPriceLineChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: CustomPaint(
        painter: LineChartPainter(data: data),
        size: Size.infinite,
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<double> data;
  LineChartPainter({
    required this.data,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double paddingLeft = 40;
    const double paddingBottom = 24;
    const double paddingTop = 16;
    const double paddingRight = 16;
    final double chartHeight = size.height - paddingBottom - paddingTop;
    final double chartWidth = size.width - paddingLeft - paddingRight;

    double maxValue = data.reduce((a, b) => a > b ? a : b);
    double minValue = data.reduce((a, b) => a < b ? a : b);
    double rangePadding = (maxValue - minValue) * 0.1;
    maxValue += rangePadding;
    minValue -= rangePadding;

    final Paint axisPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    final Paint gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 0.5;

    final Paint linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint dotPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const TextStyle labelStyle = TextStyle(color: Colors.black, fontSize: 12);

    // Draw border rectangle around the chart area
    Rect chartRect = Rect.fromLTWH(
      paddingLeft,
      paddingTop,
      chartWidth,
      chartHeight,
    );
    canvas.drawRect(chartRect, borderPaint);

    // Y-axis grid + labels
    int steps = 5;
    double range = maxValue - minValue;
    for (int i = 0; i <= steps; i++) {
      double y = paddingTop + i * (chartHeight / steps);
      double value = maxValue - i * (range / steps);

      // grid line
      canvas.drawLine(
        Offset(paddingLeft, y),
        Offset(size.width - paddingRight, y),
        gridPaint,
      );

      // Y-axis label
      final textSpan =
          TextSpan(text: value.toStringAsFixed(0), style: labelStyle);
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(paddingLeft - tp.width - 4, y - tp.height / 2));
    }

    // X-axis
    canvas.drawLine(
        Offset(paddingLeft, size.height - paddingBottom),
        Offset(size.width - paddingRight, size.height - paddingBottom),
        axisPaint);

    // Calculate points
    final double spacePerPoint = chartWidth / (data.length - 1);
    List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      double x = paddingLeft + i * spacePerPoint;
      double y = paddingTop +
          chartHeight -
          ((data[i] - minValue) / range * chartHeight);
      points.add(Offset(x, y));
    }

    // Draw line
    final path = Path();
    for (int i = 0; i < points.length; i++) {
      if (i == 0) {
        path.moveTo(points[i].dx, points[i].dy);
      } else {
        path.lineTo(points[i].dx, points[i].dy);
      }
    }
    canvas.drawPath(path, linePaint);

    // Draw dots
    for (var point in points) {
      canvas.drawCircle(point, 4, dotPaint);
    }

    // X-axis month labels
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    for (int i = 0; i < months.length; i++) {
      final textSpan = TextSpan(text: months[i], style: labelStyle);
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas,
          Offset(points[i].dx - tp.width / 2, size.height - paddingBottom + 4));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
