import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "${title}",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
    ]);
  }
}
