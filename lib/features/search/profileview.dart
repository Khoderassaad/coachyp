import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:coachyp/colors.dart';

class OtherProfilePage extends StatefulWidget {
  final String userId;
  const OtherProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage>
    with SingleTickerProviderStateMixin {
  final Map<DateTime, int> availability = {
    DateTime.utc(2025, 4, 24): 0,
    DateTime.utc(2025, 4, 25): 2,
    DateTime.utc(2025, 4, 26): 0,
    DateTime.utc(2025, 4, 27): 4,
  };

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: const BackButton(color: AppColors.s2),
        title: ShaderMask(
          shaderCallback: (bounds) => myLinearGradient().createShader(bounds),
          child: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.amberAccent,
              fontSize: 36,
              fontFamily: 'Jersey15',
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('coaches')
              .doc(widget.userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text('Error loading profile',
                      style: TextStyle(color: Colors.white)));
            }
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!;
            final username = data.get('username') ?? '';
            final type = data.get('type') ?? '';
            final profileUrl = data.get('profileImgUrl') ?? '';
            final bio = data.get('bio') ?? 'No bio available';

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: profileUrl.isNotEmpty
                              ? NetworkImage(profileUrl)
                              : null,
                          child: profileUrl.isEmpty
                              ? const Icon(Icons.person,
                                  size: 60, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Text(username,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(type,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16)),
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(bio,
                              style: const TextStyle(color: Colors.black87),
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // TODO: message logic
                            },
                            icon:
                                const Icon(Icons.message, color: Colors.white),
                            label: const Text('Send Message',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.s2,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              TabBar(
                                controller: _tabController,
                                tabs: const [
                                  Tab(
                                      icon: Icon(Icons.calendar_today,
                                          color: Colors.black)),
                                  Tab(
                                      icon: Icon(Icons.grid_on,
                                          color: Colors.black)),
                                ],
                                indicatorColor: AppColors.s2,
                              ),
                              SizedBox(
                                height: 400,
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    // Schedule Tab
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: TableCalendar(
                                        firstDay: DateTime.utc(2025, 1, 1),
                                        lastDay: DateTime.utc(2025, 12, 31),
                                        focusedDay: DateTime.now(),
                                        calendarBuilders: CalendarBuilders(
                                          defaultBuilder:
                                              (context, day, focusedDay) {
                                            final cleanDay = DateTime.utc(
                                                day.year, day.month, day.day);
                                            final slots =
                                                availability[cleanDay];
                                            Color? bgColor;

                                            if (slots == 0) {
                                              bgColor = Colors.red;
                                            } else if (slots != null &&
                                                slots > 0) {
                                              bgColor = Colors.green;
                                            }

                                            return Container(
                                              decoration: BoxDecoration(
                                                color: bgColor,
                                                shape: BoxShape.circle,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${day.day}',
                                                style: TextStyle(
                                                  color: bgColor != null
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    // Posts Tab
                                    const Center(
                                      child: Text("No posts yet.",
                                          style:
                                              TextStyle(color: Colors.black54)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
