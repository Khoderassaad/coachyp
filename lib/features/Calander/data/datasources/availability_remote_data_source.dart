import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/availability_entity.dart';

class AvailabilityRemoteDataSource {
  final CollectionReference calendarRef = FirebaseFirestore.instance.collection('coach_calendar');

  Future<void> saveAvailability(AvailabilityEntity availability) async {
    await calendarRef
        .doc(availability.coachId)
        .collection('availabilities')
        .doc(availability.date.toIso8601String())
        .set({
          'date': availability.date.toIso8601String(),
          'availableSlots': availability.availableSlots,
        });
  }

  Future<List<AvailabilityEntity>> fetchAvailability(String coachId) async {
    final snapshot = await calendarRef.doc(coachId).collection('availabilities').get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return AvailabilityEntity(
        coachId: coachId,
        date: DateTime.parse(data['date']),
        availableSlots: List<String>.from(data['availableSlots']),
      );
    }).toList();
  }
}
