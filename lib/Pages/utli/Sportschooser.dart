import 'package:coachyp/colors.dart';
import 'package:flutter/material.dart';

class Sportschooser extends StatelessWidget {
  final String sports;
  final IconData SportIcon;

  Sportschooser({required this.sports, required this.SportIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
        Container(
          width: 120,
          height: 80,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 3), // Shadow position (x, y)
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              color: AppColors.s2),
          child: Icon(
            SportIcon,
            size: 30,
            color: AppColors.background,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: ShaderMask(
            shaderCallback: (bounds) {
              return myLinearGradient().createShader(bounds);
            },
            child: Text(
              " $sports ",
              style: const TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 20,
                  fontFamily: 'Jersey15'),
            ),
          ),
        ),
        
      ],
      ),
    );
  }
}
