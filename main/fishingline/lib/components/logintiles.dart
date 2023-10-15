import 'package:flutter/material.dart';

class LoginTiles extends StatelessWidget {
  
  final String imagePath;

  const LoginTiles({
    super.key,
    required this.imagePath,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 207, 207, 207)),
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Image.asset(imagePath,
      height: 40,

      ),
    );
  }
}