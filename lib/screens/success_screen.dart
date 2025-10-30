import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class SuccessScreen extends StatefulWidget {
  final String userName;
  final int avatarIndex;
  const SuccessScreen({
    super.key,
    required this.userName,
    required this.avatarIndex,
  });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  late ConfettiController c;

  @override
  void initState() {
    super.initState();
    c = ConfettiController(duration: Duration(seconds: 6));
    WidgetsBinding.instance.addPostFrameCallback((_) => c.play());
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  Widget avatar(int i) {
    final emojis = ['😄', '🧙‍♂️', '🦸‍♀️', '🐱', '👽'];
    final colors = [Colors.purple, Colors.deepPurple, Colors.indigo, Colors.teal, Colors.orange];
    return CircleAvatar(
      radius: 45,
      backgroundColor: colors[i],
      child: Text(emojis[i], style: TextStyle(fontSize: 38)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: c,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 12,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                avatar(widget.avatarIndex),
                SizedBox(height: 20),
                Text(
                  "Welcome, ${widget.userName}! 🎉",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Your adventure begins now enjoy!",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => c.play(),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  child: Text("More Celebrations!"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
