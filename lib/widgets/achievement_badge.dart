import 'package:flutter/material.dart';

class Badge {
  final String title;
  final String emoji;
  Badge(this.title, this.emoji);
}

class AchievementBadge extends StatelessWidget {
  final Badge badge;
  const AchievementBadge(this.badge, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          badge.emoji,
          style: const TextStyle(fontSize: 34),
        ),
        Text(
          badge.title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
