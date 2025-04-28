import 'package:coachyp/features/Calander/data/datasources/availability_remote_data_source.dart';

import '../../domain/entities/availability_entity.dart';
import '../../domain/repositories/availability_repository.dart';


class AvailabilityRepositoryImpl implements AvailabilityRepository {
  final AvailabilityRemoteDataSource remoteDataSource;

  AvailabilityRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> saveAvailability(AvailabilityEntity availability) {
    return remoteDataSource.saveAvailability(availability);
  }

  @override
  Future<List<AvailabilityEntity>> fetchAvailability(String coachId) {
    return remoteDataSource.fetchAvailability(coachId);
  }
}
