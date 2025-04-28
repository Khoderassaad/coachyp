import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachyp/features/posts/domain/entities/post.dart';


class PostModel extends Post {
  PostModel({
    required super.id,
    required super.coachId,
    required super.description,
    required super.imageUrl,
    required super.timestamp,
    required super.likes,
    required super.username,
    required super.type,
    required super.profileImgUrl,
    required super.isActive,
    super.availableDates = const {}, // still keeping the default
  });

  factory PostModel.fromJson(Map<String, dynamic> json, String id) {
  try {
    final url = json['imageUrl'] as String? ?? '';

    final Map<String, List<String>> availableDates = {};
    if (json['availableDates'] != null) {
      (json['availableDates'] as Map<String, dynamic>).forEach((date, slots) {
        availableDates[date] = List<String>.from(slots ?? []);
      });
    }

    return PostModel(
      id: id,
      coachId: json['coachId'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: url,
      timestamp: (json['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      likes: List<String>.from(json['likes'] ?? []),
      username: json['username'] as String? ?? '',
      type: json['type'] as String? ?? '',
      profileImgUrl: json['profileImgUrl'] as String? ?? '',
      availableDates: availableDates,
      isActive: json['isActive'] as bool? ?? true,
    );
  } catch (e) {
    throw Exception('Error parsing PostModel: $e');
  }
}


  Map<String, dynamic> toJson() => {
        'coachId': coachId,
        'description': description,
        'imageUrl': imageUrl,
        'timestamp': Timestamp.fromDate(timestamp),
        'likes': likes,
        'username': username,
        'type': type,
        'profileImgUrl': profileImgUrl,
        'availableDates': availableDates,
        'isActive': isActive,
      };
}
