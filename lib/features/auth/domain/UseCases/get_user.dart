import 'package:coachyp/core/Error/Fail.dart';
import 'package:coachyp/core/parms/parms.dart';
import 'package:coachyp/features/auth/domain/Enteties/UserEnt.dart';
import 'package:coachyp/features/auth/domain/Repo/UserRep.dart';
import 'package:dartz/dartz.dart';

class GetUser {
  final Userrep repository;

  GetUser({required this.repository});
     Future<Either<Failure,UserEnt>> call({required UserParams parms}){
  return repository.getUser(parms: parms);
  }
}