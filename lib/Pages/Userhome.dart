// ignore_for_file: non_constant_identifier_names

import 'package:coachyp/features/Profile/presantation/pages/Account.dart';
import 'package:coachyp/Pages/utli/Sportschooser.dart';
import 'package:coachyp/features/Posts/presentation/pages/UserPost.dart';
import 'package:coachyp/colors.dart';
import 'package:coachyp/features/chat/data/search_user_page.dart'; // Correct import for search page
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Userhomepage extends StatelessWidget {
  final List Sportschoosing = [
    "soccer",
    "tennis",
    "basketball",
    "swimmimg",
    "running",
  ];

  static const List<IconData> sportsIcons = [
    Icons.sports_soccer,
    Icons.sports_tennis,
    LineIcons.basketballBall,
    LineIcons.swimmingPool,
    LineIcons.running,
  ];

  final List Username = [
    "Khoder",
    "Ahmad",
    "mohamad",
    "ibho",
    "omr",
  ];

  final List sportcoach = [
    "Fitness coach",
    "Soccer coach",
    "Bastketball coach",
    "Running coach",
    "Fitness coach",
  ];

  final List description = [
    "welcome to my flutter app",
    "welcome to my hhhh lkasdlfknasdkjfad vklashdfkahsdkfj",
    "welcome to my asdlkfadkslfasdfasdfasdfasdfasdfasdfasdfasdfkaskdf app",
    "welcome to my asdfjdfndndddjdjdjdjd app",
    "welcome to my flutter app",
  ];

  static const List<String> sportsImages = [
    'assets/image/spart-club.jpg',
    'assets/image/spart-club.jpg',
    'assets/image/spart-club.jpg',
    'assets/image/spart-club.jpg',
    'assets/image/spart-club.jpg',
  ];

  Userhomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: ShaderMask(
          shaderCallback: (bounds) => myLinearGradient().createShader(bounds),
          child: const Text(
            " COACHY ",
            style: TextStyle(
              color: Colors.amberAccent,
              fontSize: 40,
              fontFamily: 'Jersey15',
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(LineIcons.cog),
            onPressed: () {
              // Handle settings
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7, right: 7),
            child: SizedBox(
              height: 140,
              child: ListView.builder(
                itemCount: Sportschoosing.length,
                itemBuilder: (context, index) {
                  return Sportschooser(
                    sports: Sportschoosing[index],
                    SportIcon: sportsIcons[index],
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          ShaderMask(
            shaderCallback: (bounds) => myLinearGradient().createShader(bounds),
            child: const Text(
              " Posts ",
              style: TextStyle(
                color: Colors.amberAccent,
                fontSize: 30,
                fontFamily: 'Jersey15',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Username.length,
              itemBuilder: (context, index) {
                return Userpost(
                  name: Username[index],
                  imagepath: sportsImages[index],
                  desc: description[index],
                  sportcoach: sportcoach[index],
                );
              },
            ),
          )
        ],
      ),
      backgroundColor: AppColors.primary,
    );
  }
}
