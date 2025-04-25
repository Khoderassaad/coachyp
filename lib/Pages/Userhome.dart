// ignore_for_file: non_constant_identifier_names

import 'package:coachyp/Pages/Sportschooser.dart';
import 'package:coachyp/colors.dart';
import 'package:coachyp/features/court/presentation/pages/court.dart';
import 'package:coachyp/features/chat/data/search_user_page.dart'; // Correct import for search page
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';

class Userhomepage extends StatefulWidget {
  const Userhomepage({super.key});

  @override
  State<Userhomepage> createState() => _UserhomepageState();
}

class _UserhomepageState extends State<Userhomepage> {
  

  // For simple like state (non-persistent)
  final Set<int> likedPosts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: ShaderMask(
          shaderCallback: (bounds) => myLinearGradient().createShader(bounds),
          child: const Text(
            "COACHY",
            style: TextStyle(
              color: Colors.amberAccent,
              fontSize: 36,
              fontFamily: 'Jersey15',
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(LineIcons.cog),
            onPressed: () {
             

             
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: const Icon(LineIcons.facebookMessenger),
              onPressed: () {
                // Navigate to the search screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchUserPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Center(child: Text("data"),)
      // backgroundColor: AppColors.primary,
    );
  }
}
