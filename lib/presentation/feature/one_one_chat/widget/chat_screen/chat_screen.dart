import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/config/app_fonts.dart';
import 'package:soul_sphere/app/utils/utils.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/chat_bloc/chat_bloc.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/chat_bloc/chat_event.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/chat_bloc/chat_state.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/widget/chat_screen/chat_bubble.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/widget/chat_screen/chat_input_field.dart'; // Import the ChatBubble widget

class ChatScreen extends StatelessWidget {
  final String currentUserId;
  final UserEntity randomUser;

  const ChatScreen({
    super.key,
    required this.currentUserId,
    required this.randomUser,
  });

  @override
  Widget build(BuildContext context) {
    final chatId = Utils.generateChatId(currentUserId, randomUser.id);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                randomUser.avatar,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Text(
              //luego cambia a id
              randomUser.email,
              style: AppFonts.smallText,
            )),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocProvider(
        create: (context) => ChatBloc()..add(LoadMessages(chatId)),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        final isCurrentUser = message.senderId == currentUserId;
                        return ChatBubble(
                          message: message,
                          isCurrentUser: isCurrentUser,
                        );
                      },
                    ),
                  ),
                  ChatInputField(
                    chatBloc: BlocProvider.of<ChatBloc>(context),
                    currentUserId: currentUserId,
                    randomUserId: randomUser.id,
                  ),
                ],
              );
            } else if (state is ChatError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Something went wrong.'));
            }
          },
        ),
      ),
    );
  }
}
