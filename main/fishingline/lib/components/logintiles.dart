import 'package:flutter/material.dart';

class LoginTiles extends StatelessWidget {
  
  final String imagePath;
  final Function()? onTap;

  const LoginTiles({
    super.key,
    required this.imagePath,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 207, 207, 207)),
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Image.asset(imagePath,
        height: 40,
    
        ),
      ),
    );
  }
}