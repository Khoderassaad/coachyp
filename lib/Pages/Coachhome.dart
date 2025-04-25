import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachyp/Pages/Sportschooser.dart';
import 'package:coachyp/colors.dart';
import 'package:coachyp/features/court/presentation/pages/court.dart';
import 'package:coachyp/features/chat/data/search_user_page.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:table_calendar/table_calendar.dart';

class CoachHomePage extends StatefulWidget {
  const CoachHomePage({super.key});

  @override
  State<CoachHomePage> createState() => _CoachHomePageState();
}

class _CoachHomePageState extends State<CoachHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _subscriberCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchSubscriberCount();
  }

  Future<void> _fetchSubscriberCount() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('subscriptions')
          .get();

      setState(() {
        _subscriberCount = snapshot.docs.length;
      });
    } catch (e) {
      debugPrint("Error fetching subscriber count: $e");
    }
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Subscribers',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$_subscriberCount',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ShaderMask(
              shaderCallback: (bounds) => myLinearGradient().createShader(bounds),
              child: const Text(
                'Work Calendar',
                style: TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 28,
                  fontFamily: 'Jersey15',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


