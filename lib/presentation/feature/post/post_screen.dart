import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/app/di/service_locator.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_bloc.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_event.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_state.dart';

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
        appBar: AppBar(
          backgroundColor: AppColors.brightLila,
          title: const Text('Create Post'),
          centerTitle: true,
          actions: [
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    final image = context.read<PostBloc>().state
                            is ImagePickedState
                        ? (context.read<PostBloc>().state as ImagePickedState)
                            .image
                        : null;

                    context.read<PostBloc>().add(
                          SubmitPostEvent(
                            text: _textController.text,
                            image: image,
                          ),
                        );
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostSuccessState) {
                Navigator.pop(context);
              } else if (state is PostFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Failed to submit post: ${state.error}')),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  if (state is ImagePickedState)
                    Image.file(
                      state.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  TextField(
                    controller: _textController,
                    maxLines: null,
                    decoration:
                        const InputDecoration(hintText: 'What’s on your mind?'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PostBloc>().add(PickImageEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.opacityWhite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('Select Image'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
