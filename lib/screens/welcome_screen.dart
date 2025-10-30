import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 249),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.elasticOut,
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 92, 49, 168),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.emoji_emotions, color: Color.fromARGB(255, 145, 143, 143), size: 60),
              ),
              const SizedBox(height: 40),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Join The Adventures!',
                    textStyle: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 63, 35, 110)),
                    speed: Duration(milliseconds: 80),
                  ),
                ],
                totalRepeatCount: 1,
              ),
              const SizedBox(height: 20),
              const Text(
                'Create Your Account And Start Your Journey',
                style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 117, 116, 116)),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, SignupScreen.routeName),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Start Adventures',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
