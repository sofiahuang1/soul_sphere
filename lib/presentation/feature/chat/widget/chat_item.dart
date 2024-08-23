import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/utils/utils.dart';
import 'package:soul_sphere/data/model/user_model.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';
import 'package:soul_sphere/domain/model/chat_message.dart';

class ChatItem extends StatelessWidget {
  final ChatMessage chatMessage;
  final String currentUserId;
  final VoidCallback onTap;

  const ChatItem({
    required this.chatMessage,
    required this.currentUserId,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(chatMessage.receiverId == currentUserId
              ? chatMessage.senderId
              : chatMessage.receiverId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const ListTile(
            title: Text('Loading...'),
          );
        }

        final userModel = UserModel.fromFirestore(snapshot.data!);
        final user = UserEntity(
          id: userModel.id,
          email: userModel.email,
          avatar: userModel.avatar,
          bio: userModel.bio,
          createdAt: userModel.createdAt,
          followersCount: userModel.followersCount,
          followingCount: userModel.followingCount,
          postCount: userModel.postCount,
        );

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(user.avatar),
          ),
          title: Text(user.email),
          subtitle: Text(
            chatMessage.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            Utils.formatTimestamp(chatMessage.timestamp),
            style: const TextStyle(color: AppColors.lightGrey),
          ),
          onTap: onTap,
        );
      },
    );
  }
}
