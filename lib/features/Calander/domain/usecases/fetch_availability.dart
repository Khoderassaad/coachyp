import '../entities/availability_entity.dart';
import '../repositories/availability_repository.dart';

class FetchAvailability {
  final AvailabilityRepository repository;

  FetchAvailability(this.repository);

  Future<List<AvailabilityEntity>> call(String coachId) {
    return repository.fetchAvailability(coachId);
  }
}
