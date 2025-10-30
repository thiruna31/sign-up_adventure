import 'package:flutter/material.dart';

class AvatarPicker extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const AvatarPicker({super.key, required this.selectedIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final emojis = ['😄', '🧙‍♂️', '🦸‍♀️', '🐱', '👽'];
    final colors = [Colors.purple, Colors.deepPurple, Colors.indigo, Colors.teal, Colors.orange];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        itemCount: emojis.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          bool selected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onSelect(i),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.all(selected ? 6 : 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: selected
                      ? [BoxShadow(color: colors[i], blurRadius: 10)]
                      : [],
                ),
                child: CircleAvatar(
                  radius: selected ? 35 : 30,
                  backgroundColor: colors[i],
                  child: Text(
                    emojis[i],
                    style: TextStyle(
                      fontSize: selected ? 32 : 26,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
