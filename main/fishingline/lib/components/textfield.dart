import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final iconName;

  const UserTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,  
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
        prefixIcon: Icon(iconName),
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? Color.fromARGB(255, 255, 174, 0)
                : Colors.grey),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color.fromARGB(255, 255, 187, 0), width: 4,), 
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
        
  }
}