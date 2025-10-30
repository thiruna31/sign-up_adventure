import 'package:flutter/material.dart';

class PasswordStrength {
  static double score(String p) {
    double s = 0;
    if (p.length >= 6) s += .25;
    if (RegExp(r'[A-Z]').hasMatch(p)) s += .25;
    if (RegExp(r'[0-9]').hasMatch(p)) s += .25;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(p)) s += .25;
    return s;
  }
}

class PasswordStrengthMeter extends StatelessWidget {
  final String password;
  const PasswordStrengthMeter({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    double s = PasswordStrength.score(password);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: s,
          minHeight: 8,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation(_color(s)),
        ),
        SizedBox(height: 4),
        Text(_label(s)),
      ],
    );
  }

  Color _color(double s) {
    if (s >= .75) return Colors.green;
    if (s >= .5) return Colors.amber;
    if (s > 0) return Colors.red;
    return Colors.grey;
  }

  String _label(double s) {
    if (s >= .75) return "Strong";
    if (s >= .5) return "Medium";
    if (s > 0) return "Weak";
    return "Empty";
  }
}
