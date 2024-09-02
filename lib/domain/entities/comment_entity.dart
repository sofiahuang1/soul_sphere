import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String userId;
  final String content;
  final DateTime createdAt;

  const CommentEntity({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, content, createdAt];
}
