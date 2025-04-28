import '../entities/availability_entity.dart';
import '../repositories/availability_repository.dart';

class SaveAvailability {
  final AvailabilityRepository repository;

  SaveAvailability(this.repository);

  Future<void> call(AvailabilityEntity availability) {
    return repository.saveAvailability(availability);
  }
}
