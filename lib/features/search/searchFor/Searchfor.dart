import 'package:coachyp/colors.dart';
import 'package:coachyp/features/court/presentation/pages/court.dart';
import 'package:coachyp/features/search/Search.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class TwoTabNavPage extends StatefulWidget {
  const TwoTabNavPage({Key? key}) : super(key: key);

  @override
  State<TwoTabNavPage> createState() => _TwoTabNavPageState();
}

class _TwoTabNavPageState extends State<TwoTabNavPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const SearchView(),       // First screen
     SportCourtFinder(), // Second screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            // Top navigation bar
            Container(
              decoration: BoxDecoration(
                color: AppColors.s2,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: GNav(
                  gap: 8,
                  activeColor: AppColors.s2,
                  iconSize: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: AppColors.primary,
                  color: Colors.white70,
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) => setState(() => _selectedIndex = index),
                  tabs: const [
                    GButton(
                      icon: LineIcons.user,
                      text: 'Coaches',
                      iconColor: Colors.white,
                    ),
                    GButton(
                      icon: Icons.stadium,
                      text: 'Nearby court',
                      iconColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            // Page content
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: _pages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
