import 'package:coachyp/core/Error/Fail.dart';
import 'package:coachyp/core/parms/parms.dart';
import 'package:coachyp/features/auth/domain/Enteties/UserEnt.dart';
import 'package:dartz/dartz.dart';

abstract class Userrep {
  Future<Either<Failure,UserEnt>> getUser({required UserParams parms});
}