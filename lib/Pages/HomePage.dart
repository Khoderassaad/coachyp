import 'package:coachyp/Pages/Notifications.dart';
import 'package:coachyp/Pages/Search.dart';
import 'package:coachyp/Pages/Userhome.dart';
import 'package:coachyp/features/Profile/presantation/pages/Account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
   Userhomepage(),
   const Searchpage(),
   Notificationspage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for proper bottom bar rendering
      backgroundColor: AppColors.primary,
      
      body: 
      Expanded(
              child: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ),
    
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: AppColors.background,
              // hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: AppColors.background,
              color: Colors.black,
              tabs: const [
               GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.bell,
                  text: 'notification',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'User',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),

      // Logout Button
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await FirebaseAuth.instance.signOut();
      //     // ignore: use_build_context_synchronously
      //     Navigator.of(context)
      //         .pushNamedAndRemoveUntil("Login", (Route) => false);
      //   },
      //   child: const Icon(Icons.exit_to_app_rounded),
      // ),
    );
  }
}
