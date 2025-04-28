class AvailabilityEntity {
  final String coachId;
  final DateTime date;
  final List<String> availableSlots;

  AvailabilityEntity({
    required this.coachId,
    required this.date,
    required this.availableSlots,
  });
}
