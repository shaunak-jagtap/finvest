import 'package:flutter/material.dart';

class BalanceGraph extends StatelessWidget {
  final double totalBalance;
  final String selectedPeriod;
  final Function(String) onPeriodSelected;
  final Map<DateTime, double> spendingData; // Add spending data for the graph

  BalanceGraph({
    required this.totalBalance,
    required this.selectedPeriod,
    required this.onPeriodSelected,
    required this.spendingData, // Require spending data for graph rendering
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Graph area
        AspectRatio(
          aspectRatio: 1.5, // Adjusted for a better height-to-width ratio
          child: CustomPaint(
            painter: BalanceGraphPainter(
              spendingData: spendingData, // Pass the spending data to the painter
            ),
          ),
        ),
        SizedBox(height: 8),
        // Time period indicators (week, month, etc.)
        _buildTimePeriodIndicators(),
      ],
    );
  }

  Widget _buildTimePeriodIndicators() {
    final periods = ['1W', '1M', '3M', '6M', 'YTD', '1Y', 'ALL'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: periods.map((period) {
        final isSelected = period == selectedPeriod;
        return GestureDetector(
          onTap: () {
            // Trigger the callback function with the selected period
            onPeriodSelected(period);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              period,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class BalanceGraphPainter extends CustomPainter {
  final Map<DateTime, double> spendingData;

  BalanceGraphPainter({required this.spendingData});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();

    if (spendingData.isEmpty) {
      return; // Safeguard: don't attempt to draw the graph if there's no data
    }

    // Determine the max value dynamically to scale the Y-axis appropriately
    final maxSpending = spendingData.values.isEmpty
        ? 1.0
        : spendingData.values.reduce((a, b) => a > b ? a : b);

    // Calculate points based on spending data and size
    final points = List.generate(spendingData.length, (index) {
      final date = spendingData.keys.elementAt(index);
      final amount = spendingData.values.elementAt(index);

      return Offset(
        spendingData.length > 1
            ? size.width * index / (spendingData.length - 1)
            : size.width / 2, // Avoid division by zero if only one point
        size.height * (1 - (amount / maxSpending)), // Use maxSpending for Y-axis scaling
      );
    });

    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);

      // Use quadratic Bezier curve for smooth transitions between points
      for (int i = 1; i < points.length; i++) {
        var previousPoint = points[i - 1];
        var currentPoint = points[i];

        // Quadratic Bezier for smooth curves
        path.quadraticBezierTo(
          (previousPoint.dx + currentPoint.dx) / 2,
          (previousPoint.dy + currentPoint.dy) / 2,
          currentPoint.dx,
          currentPoint.dy,
        );
      }

      canvas.drawPath(path, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint when period or data changes
  }
}
