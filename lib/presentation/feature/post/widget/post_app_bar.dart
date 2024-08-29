import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_sphere/app/constants/app_colors.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_bloc.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_event.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_state.dart';

class PostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostAppBar({super.key, required this.textController});

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                final image = context.read<PostBloc>().state is ImagePickedState
                    ? (context.read<PostBloc>().state as ImagePickedState).image
                    : null;

                context.read<PostBloc>().add(
                      SubmitPostEvent(
                        text: textController.text,
                        image: image,
                      ),
                    );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
