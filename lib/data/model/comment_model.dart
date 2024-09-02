import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soul_sphere/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.id,
    required super.userId,
    required super.content,
    required super.createdAt,
  });

  factory CommentModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return CommentModel(
      id: doc.id,
      userId: data['userId'] as String,
      content: data['content'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
