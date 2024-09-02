import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/di/service_locator.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_bloc.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_state.dart';
import 'package:soul_sphere/presentation/feature/post/widget/image_view.dart';
import 'package:soul_sphere/presentation/feature/post/widget/post_app_bar.dart';
import 'package:soul_sphere/presentation/feature/post/widget/select_image_button.dart';
import 'package:soul_sphere/presentation/feature/post/widget/text_input.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  PostScreenState createState() => PostScreenState();
}

class PostScreenState extends State<PostScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (_) => getIt<PostBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.brightLila,
        appBar: PostAppBar(textController: _textController),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostSuccessState) {
                Navigator.pop(context);
              } else if (state is PostFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to submit post: ${state.error}'),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  if (state is ImagePickedState)
                    ImagePreview(image: state.image),
                  TextInput(controller: _textController),
                  const SizedBox(height: 20),
                  const SelectImageButton(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
