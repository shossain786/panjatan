import 'package:flutter/material.dart';

class AnimatedCard extends StatelessWidget {
  final String content;
  final String category;
  final String date;

  const AnimatedCard({
    required this.content,
    required this.category,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Category: $category'),
            Text('Date: $date'),
          ],
        ),
      ),
    );
  }
}
