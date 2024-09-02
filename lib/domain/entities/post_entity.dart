import 'package:equatable/equatable.dart';
import 'package:soul_sphere/domain/entities/comment_entity.dart';

class PostEntity extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;
  final int likesCount;
  final List<CommentEntity> comments;

  const PostEntity({
    required this.id,
    required this.userId,
    this.title = '',
    required this.content,
    this.imageUrl,
    required this.createdAt,
    this.likesCount = 0,
    this.comments = const [],
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
        comments,
      ];
}
