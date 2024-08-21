import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/utils/utils.dart';
import 'package:soul_sphere/domain/model/chat_message.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/chat_bloc/chat_bloc.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/chat_bloc/chat_event.dart';

class ChatInputField extends StatefulWidget {
  final ChatBloc chatBloc;
  final String currentUserId;
  final String randomUserId;

  const ChatInputField({
    super.key,
    required this.chatBloc,
    required this.currentUserId,
    required this.randomUserId,
  });

  @override
  ChatInputFieldState createState() => ChatInputFieldState();
}

class ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  bool _isEmojiPickerVisible = false;

  void _toggleEmojiPicker() {
    setState(() {
      _isEmojiPickerVisible = !_isEmojiPickerVisible;
    });
  }

  void _onEmojiSelected(Emoji emoji) {
    setState(() {
      _controller.text += emoji.emoji;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  IconButton(
                    onPressed: _toggleEmojiPicker,
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: AppColors.brightPurple,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.brightPurple,
                    ),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        widget.chatBloc.add(SendMessage(
                          text: _controller.text,
                          type: MessageType.text,
                          senderId: widget.currentUserId,
                          receiverId: widget.randomUserId,
                          chatId: Utils.generateChatId(
                              widget.currentUserId, widget.randomUserId),
                        ));
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 280),
            ],
          ),
        ),
        if (_isEmojiPickerVisible)
          Positioned(
            bottom: 13,
            left: 0,
            right: 0,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                _onEmojiSelected(emoji);
              },
              textEditingController: _controller,
              config: Config(
                height: 250,
                checkPlatformCompatibility: true,
                emojiViewConfig: EmojiViewConfig(
                  emojiSizeMax: 25 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.20
                          : 1.0),
                ),
                swapCategoryAndBottomBar: false,
                skinToneConfig: const SkinToneConfig(),
                categoryViewConfig: const CategoryViewConfig(),
                bottomActionBarConfig: const BottomActionBarConfig(),
                searchViewConfig: const SearchViewConfig(),
              ),
              onBackspacePressed: () {},
            ),
          ),
      ],
    );
  }
}
