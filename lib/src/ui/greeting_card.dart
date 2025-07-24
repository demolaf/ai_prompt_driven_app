import '../model/greeting_model.dart';
import 'package:flutter/material.dart';

class GreetingCard extends StatelessWidget {
  final GreetingModel greeting;
  final bool isLastItem;

  const GreetingCard({
    super.key,
    required this.greeting,
    this.isLastItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: isLastItem ? 0 : 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Colors.blue.shade300, Colors.purple.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              greeting.greeting,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              greeting.question,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 4),
            Text(
              greeting.language,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white60,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
