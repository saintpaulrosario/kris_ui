import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionWidget({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }
}
