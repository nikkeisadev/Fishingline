import 'package:flutter/material.dart';

class ButtonEntry extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const ButtonEntry({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        
        padding: const EdgeInsets.all(17),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          image: const DecorationImage(
           image: AssetImage(
           "lib/images/button_background.png"
           ), 
           fit:BoxFit.cover
         ),
         
          color: const Color.fromARGB(255, 255, 174, 0), 
          borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
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