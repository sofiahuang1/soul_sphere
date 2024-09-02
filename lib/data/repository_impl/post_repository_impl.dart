import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soul_sphere/data/model/post_model.dart';
import 'package:soul_sphere/domain/entities/post_entity.dart';
import 'package:soul_sphere/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final FirebaseFirestore _firestore;

  PostRepositoryImpl(this._firestore);

  @override
  Future<List<PostEntity>> getAllPosts() async {
    final querySnapshot = await _firestore.collection('posts').get();
    return querySnapshot.docs
        .map((doc) => PostModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<List<PostEntity>> getPostsByUser(String userId) async {
    final querySnapshot = await _firestore
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .get();
    return querySnapshot.docs
        .map((doc) => PostModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<void> createPost(PostEntity post) async {
    final postMap = (post as PostModel).toMap();
    await _firestore.collection('posts').add(postMap);
  }
}
