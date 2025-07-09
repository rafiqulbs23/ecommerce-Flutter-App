import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  const RetryButton({super.key,
    required this.error,
    required this.onPressed,
  });
  final String error ;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Error: $error'),
        ElevatedButton(
          onPressed: () {
           onPressed();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Retry'),
        ),

      ],
    );
  }
}
