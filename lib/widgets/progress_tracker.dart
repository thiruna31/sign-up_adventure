import 'package:flutter/material.dart';

class ProgressTracker extends StatelessWidget {
  final double percent;
  const ProgressTracker({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    double p = percent.clamp(0, 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: p / 100,
          minHeight: 10,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation(_color(p)),
        ),
        SizedBox(height: 6),
        Text(
          "${p.toStringAsFixed(0)}% Complete",
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Color _color(double p) {
    if (p >= 75) return Colors.green;
    if (p >= 50) return Colors.amber;
    if (p >= 25) return Colors.orange;
    return Colors.red;
  }
}
