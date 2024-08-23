import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/app/router/app_paths.dart';
import 'package:soul_sphere/domain/model/chat_message.dart';
import 'package:soul_sphere/presentation/feature/chat/widget/chat_item.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/current_user/current_user_bloc.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/current_user/current_user_event.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/current_user/current_user_state.dart';
import 'package:soul_sphere/presentation/widgets/custom_app_bar.dart';

class AllChatScreen extends StatelessWidget {
  const AllChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CurrentUserBloc()..add(LoadUserId()),
      child: Scaffold(
        appBar: const CustomAppBar(title: AppConstants.chats),
        body: BlocBuilder<CurrentUserBloc, CurrentUserState>(
          builder: (context, state) {
            if (state is UserIdLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserIdLoaded) {
              final currentUserId = state.userId;

              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUserId)
                    .collection('chats')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final chatDocs = snapshot.data!.docs;

                  if (chatDocs.isEmpty) {
                    return const Center(child: Text('No chats yet'));
                  }

                  return ListView.builder(
                    itemCount: chatDocs.length,
                    itemBuilder: (context, index) {
                      final chatData =
                          chatDocs[index].data() as Map<String, dynamic>;
                      final chatMessage = ChatMessage.fromFirestore(
                          chatData, chatDocs[index].id);

                      return ChatItem(
                        chatMessage: chatMessage,
                        currentUserId: currentUserId,
                        onTap: () {
                          context.push(
                            AppPaths.chatScreenPath,
                            extra: {
                              'currentUserId': currentUserId,
                              'randomUser':
                                  chatMessage.receiverId == currentUserId
                                      ? chatMessage.senderId
                                      : chatMessage.receiverId,
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            } else if (state is UserIdError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Something went wrong.'));
            }
          },
        ),
      ),
    );
  }
}
