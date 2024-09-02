import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soul_sphere/domain/entities/post_entity.dart';

import 'comment_model.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.userId,
    super.title,
    required super.content,
    super.imageUrl,
    required super.createdAt,
    super.likesCount,
    List<CommentModel> super.comments = const [],
  });

  factory PostModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return PostModel(
      id: doc.id,
      userId: data['userId'] as String,
      title: data['title'] as String? ?? '',
      content: data['text'] as String? ?? '',
      imageUrl: data['mediaUrl'] as String?,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      likesCount: data['likesCount'] as int? ?? 0,
      comments: (data['comments'] as List<dynamic>?)
              ?.map((comment) => CommentModel.fromFirestore(
                  comment as DocumentSnapshot<Map<String, dynamic>>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'likesCount': likesCount,
      'comments':
          comments.map((comment) => (comment as CommentModel).toMap()).toList(),
    };
  }
}
