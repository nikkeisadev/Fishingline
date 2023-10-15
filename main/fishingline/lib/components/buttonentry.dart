import 'package:flutter/material.dart';

class ButtonEntry extends StatelessWidget {
  final Function()? onTap;
  const ButtonEntry({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(19),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 200, 18), 
          borderRadius: BorderRadius.circular(16)),
        child: const Center(
          child: Text(
            "Bejelentkezés",
            style: TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold, 
              fontSize: 20
            ),
          ),
        ),
      ),
    );
  }
}