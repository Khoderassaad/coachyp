import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFE2E0E0);
  static const Color secondary = Color(0xFF1E90FF);
  static const Color background = Color.fromRGBO(245, 245, 245, 1);
  static const Color s2 = Color(0xff173054);
    
  
}
LinearGradient myLinearGradient() {
  return LinearGradient(
    colors: [
      Color(0xff173054),   // Start color
      Color(0xff4435B4),   // Start color
      Color(0xff570483),   // Start color
         // End color
    ],
    stops: [0.15, 0.3, 1.0],
  
  );
}
 Widget buildLabel(String text) {
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: ShaderMask(
        shaderCallback: (bounds) {
          return myLinearGradient().createShader(bounds);
        },
        child: Text(
          text,
          style: const TextStyle( // Added const
            color: Colors.amberAccent,
            fontSize: 22,
            fontFamily: 'Jersey15',
          ),
        ),
      ),
    );
  }
  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 10), // Added const
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      fillColor: Colors.white,
      filled: true,
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: ShaderMask(
        shaderCallback: (bounds) {
          return myLinearGradient().createShader(bounds);
        },
        child: Text(
          text,
          style: const TextStyle(
          
            color: Colors.amberAccent,
            fontSize: 22,
            fontFamily: 'Jersey15',
          ),
        ),
      ),
    );
  }

