import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  final String coachId;
  final String description;
  final String imageUrl;
  final DateTime timestamp;
  final List<String> likes;
  final String username;
  final String type;
  final String profileImgUrl;
  final Map<String, List<String>> availableDates;
  final bool isActive;


  const Post({
    required this.id,
    required this.coachId,
    required this.description,
    required this.imageUrl,
    required this.timestamp,
    required this.likes,
    required this.username,
    required this.type,
    required this.profileImgUrl,
    this.availableDates = const {},
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
        id,
        coachId,
        description,
        imageUrl,
        timestamp,
        likes,
        username,
        type,
        profileImgUrl,
        availableDates,
      ];
}
