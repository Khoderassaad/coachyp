import '../entities/availability_entity.dart';

abstract class AvailabilityRepository {
  Future<void> saveAvailability(AvailabilityEntity availability);
  Future<List<AvailabilityEntity>> fetchAvailability(String coachId);
}
