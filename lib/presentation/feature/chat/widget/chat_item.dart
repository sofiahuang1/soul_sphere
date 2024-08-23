import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/utils/utils.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';
import 'package:soul_sphere/domain/model/chat_message.dart';

class ChatItem extends StatelessWidget {
  final ChatMessage chatMessage;
  final UserEntity user;
  final VoidCallback onTap;

  const ChatItem({
    required this.chatMessage,
    required this.user,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(user.avatar),
      ),
      title: Text(
        user.email.length > 20
            ? '${user.email.substring(0, 7)}...'
            : user.email,
      ),
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
  }
}
