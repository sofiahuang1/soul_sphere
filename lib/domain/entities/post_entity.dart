import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;

  const PostEntity({
    required this.id,
    required this.userId,
    this.title = '',
    required this.content,
    this.imageUrl,
    required this.createdAt,
    this.likesCount = 0,
    this.commentsCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        content,
        imageUrl,
        createdAt,
        likesCount,
        commentsCount,
      ];
}
