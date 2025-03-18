import 'package:coachyp/features/auth/presentation/blocs/colors.dart';
import 'package:flutter/material.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({super.key});

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  @override
  int _selectedButtonIndex = -1;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Container(
            height: 173,
            width: 600,
            child: Image.asset(
              "assets/image/spart-club.jpg",
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = 0;
                    });
                  },
                  child: _buildLabel("become a\n   client"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      if (_selectedButtonIndex == 0) {
                        return Colors
                            .grey; 
                      }
                      return Colors.white;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(150, 50)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex =
                          1; 
                    });
                  },
                  child: _buildLabel(
                      "become a \n   coach"), 
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      if (_selectedButtonIndex == 1) {
                        
                        return Colors.grey; 
                      }
                      return Colors.white; 
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(150, 50)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 2),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
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
}
