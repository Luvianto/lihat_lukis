import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final String textBetween;
  const MyDivider({super.key, required this.textBetween});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              textBetween,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
          const Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
