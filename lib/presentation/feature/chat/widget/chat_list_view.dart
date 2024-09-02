import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/data/model/user_model.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';
import 'package:soul_sphere/domain/model/chat_message.dart';
import 'package:soul_sphere/presentation/feature/chat/widget/chat_item.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({
    super.key,
    required this.chatDocs,
    required this.currentUserId,
  });

  final List<QueryDocumentSnapshot<Object?>> chatDocs;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: chatDocs.length,
      separatorBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            height: index == chatDocs.length - 1 ? 0 : 1,
            color: AppColors.opacityGrey,
          ),
        );
      },
      itemBuilder: (context, index) {
        final chatData = chatDocs[index].data() as Map<String, dynamic>;
        final chatMessage =
            ChatMessage.fromFirestore(chatData, chatDocs[index].id);

        final userId = chatMessage.receiverId == currentUserId
            ? chatMessage.senderId
            : chatMessage.receiverId;

        return FutureBuilder<DocumentSnapshot>(
          future:
              FirebaseFirestore.instance.collection('users').doc(userId).get(),
          builder: (context, userSnapshot) {
            if (!userSnapshot.hasData) {
              return const ListTile(
                title: Text('Loading...'),
              );
            }

            final userModel = UserModel.fromFirestore(userSnapshot.data!);
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

            return Dismissible(
              key: ValueKey(chatMessage.id),
              background: Container(
                color: AppColors.lightRed,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete, color: AppColors.grey),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUserId)
                    .collection('chats')
                    .doc(chatMessage.id)
                    .delete();
              },
              child: ChatItem(
                chatMessage: chatMessage,
                user: user,
                onTap: () {
                  context.push(
                    AppPaths.chatScreenPath,
                    extra: {
                      'currentUserId': currentUserId,
                      'randomUser': user,
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
