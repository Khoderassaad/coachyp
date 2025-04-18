// ignore_for_file: non_constant_identifier_names

import 'package:coachyp/Pages/utli/Sportschooser.dart';
import 'package:coachyp/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';

class Userhomepage extends StatefulWidget {
  const Userhomepage({super.key});

  @override
  State<Userhomepage> createState() => _UserhomepageState();
}

class _UserhomepageState extends State<Userhomepage> {
  final List Sportschoosing = [
    "soccer",
    "tennis",
    "basketball",
    "swimming",
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
    "Mohamad",
    "Ibho",
    "Omr",
  ];

  final List sportcoach = [
    "Fitness coach",
    "Soccer coach",
    "Basketball coach",
    "Running coach",
    "Fitness coach",
  ];

  final List description = [
    "Welcome to my Flutter app",
    "Training available for all levels.",
    "Professional basketball coaching experience.",
    "Run faster, train smarter!",
    "Transform your body with personal guidance.",
  ];

  static const List<String> sportsImages = [
    'assets/image/spart-club.jpg',
    'assets/image/spart-club.jpg',
    'assets/image/spart-club.jpg',
    'assets/image/spart-club.jpg',
    'assets/image/spart-club.jpg',
  ];

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
            onPressed: () {},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: const Icon(LineIcons.facebookMessenger),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: SizedBox(
              height: 140,
              child: ListView.builder(
                itemCount: Sportschoosing.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Sportschooser(
                    sports: Sportschoosing[index],
                    SportIcon: sportsIcons[index],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ShaderMask(
              shaderCallback: (bounds) => myLinearGradient().createShader(bounds),
              child: const Text(
                "Posts",
                style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 28,
                  fontFamily: 'Jersey15',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: Username.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(sportsImages[index]),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Username[index],
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                  sportcoach[index],
                                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          description[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                likedPosts.contains(index)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: likedPosts.contains(index) ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (likedPosts.contains(index)) {
                                    likedPosts.remove(index);
                                  } else {
                                    likedPosts.add(index);
                                  }
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.share),
                              onPressed: () {
                                Share.share(
                                  '${Username[index]}: ${description[index]}',
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
