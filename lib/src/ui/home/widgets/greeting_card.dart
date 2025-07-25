import 'package:ai_prompt_driven_app/src/model/greeting_model.dart';
import 'package:flutter/material.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({required this.data, super.key, this.isLastItem = false});

  final GreetingModel data;
  final bool isLastItem;

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
              data.greeting,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              data.question,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 4),
            Text(
              data.language,
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
